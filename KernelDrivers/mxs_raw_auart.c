/*
* Raw UART driver for HomeMatic CCU2 (Freescale MXS platform)
*
* Copyright (c) 2015 by eQ-3 Entwicklung GmbH
* Author: Lars Reemts, lars.reemts@finalbit.de
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*
*/

#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/console.h>
#include <linux/sysrq.h>
#include <linux/interrupt.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/wait.h>
#include <linux/poll.h>
#include <linux/platform_device.h>
#include <linux/device.h>
#include <linux/clk.h>
#include <linux/delay.h>
#include <linux/io.h>
#include <linux/uaccess.h>
#include <linux/circ_buf.h>
#include <linux/cdev.h>
#include <linux/sched.h>
#include <linux/proc_fs.h>
#include <linux/spinlock.h>
#include <linux/version.h>
#include <asm/termbits.h>
#include <asm/termios.h>
#include <asm/ioctls.h>

#include <asm/cacheflush.h>

/*
* Ioctl definitions
*/

/* Use 'u' as magic number */
#define MXS_AUART_IOC_MAGIC  'u'

/*
* S means "Set" through a ptr,
* G means "Get": reply by setting through a pointer
*/

/* Set and get the priority for the current channel */
#define MXS_AUART_IOCSPRIORITY _IOW(MXS_AUART_IOC_MAGIC,  1, unsigned long)
#define MXS_AUART_IOCGPRIORITY _IOR(MXS_AUART_IOC_MAGIC,  2, unsigned long)

#define MXS_AUART_IOC_MAXNR 2

#define MXS_AUART_PORTS 5
#define CIRCBUF_SIZE 1024
#define BAUD    115200

#define MODNAME "mxs-raw-auart"

/* enable debuging via proc filesystem */
#define PROC_DEBUG

/* TX FIFO empty interrupt is generated if FIFO is less than this level. */
#define TXIFSEL   AUART_CTRL2_TXIFSEL_ONE_HALF /* half full, N <= 8 */

/* number of charaters to be written to the TX FIFO at once. */
/* This number must be selected big enough that a write operation always fills the FIFO above the interrupt threshold defined by TXIFSEL. */
#define TX_CHUNK_SIZE 11

/* RX FIFO interrupt is generated if FIFO level is above this level */
#define RXIFSEL AUART_CTRL2_RXIFSEL_ONE_QUARTER /* quarter full, N >= 4 */
//#define RXIFSEL AUART_CTRL2_RXIFSEL_ONE_HALF /* half full, N >= 8 */

/* notify user space application if nothing was received for the following number of bit times */
static int rxto=31; /* rx timeout in bit times */
module_param(rxto, int, S_IRUGO);

/*
 * Latency calculation *
 * =================== *
 * UART settings are 8N1@115k2. This means 10 bits per byte or 0,087ms per byte. Assuming 0,013ms pause between consecutive bytes we calculate with 0,1ms per byte. *
 * With the above settings the user space application is notified when there are at least 4 bytes in the RX FIFO and if nothing was received for 31 bit times. *
 * Under these assumptions the maximum receive latency is 3 byte time plus 31 bit times = 0,3ms + 0,27ms = 0,57ms. *
 * The maximum send latency is determined by the TX FIFO size. The FIFO has 16 entries, each corresponding to 0,087ms wire time. This gives 1,392ms maximum send latency *
 */
 
/*
 * Priorites *
 * ========= *
 * Each connection from user space is assigned a priority. The default priority is 0. A higher priority can be set using ioctls. *
 * Write operations from user space are synchronous. The write() function returns after all bytes have been transferred to the TX FIFO. *
 * A write operation from a channel with a higher priority cancels a lower priority write in progress. *
 * write() always returns the numer of bytes actually sent.
 */
 
 

#define AUART_CTRL0			0x00000000
#define AUART_CTRL0_SET			0x00000004
#define AUART_CTRL0_CLR			0x00000008
#define AUART_CTRL0_TOG			0x0000000c
#define AUART_CTRL1			0x00000010
#define AUART_CTRL1_SET			0x00000014
#define AUART_CTRL1_CLR			0x00000018
#define AUART_CTRL1_TOG			0x0000001c
#define AUART_CTRL2			0x00000020
#define AUART_CTRL2_SET			0x00000024
#define AUART_CTRL2_CLR			0x00000028
#define AUART_CTRL2_TOG			0x0000002c
#define AUART_LINECTRL			0x00000030
#define AUART_LINECTRL_SET		0x00000034
#define AUART_LINECTRL_CLR		0x00000038
#define AUART_LINECTRL_TOG		0x0000003c
#define AUART_LINECTRL2			0x00000040
#define AUART_LINECTRL2_SET		0x00000044
#define AUART_LINECTRL2_CLR		0x00000048
#define AUART_LINECTRL2_TOG		0x0000004c
#define AUART_INTR			0x00000050
#define AUART_INTR_SET			0x00000054
#define AUART_INTR_CLR			0x00000058
#define AUART_INTR_TOG			0x0000005c
#define AUART_DATA			0x00000060
#define AUART_STAT			0x00000070
#define AUART_DEBUG			0x00000080
#define AUART_VERSION			0x00000090
#define AUART_AUTOBAUD			0x000000a0

#define AUART_CTRL0_SFTRST			(1 << 31)
#define AUART_CTRL0_CLKGATE			(1 << 30)
#define AUART_CTRL0_RXTIMEOUT_SHIFT   16
#define AUART_CTRL0_RXTIMEOUT_MASK   (0x7ff << AUART_CTRL0_RXTIMEOUT_SHIFT)

#define AUART_CTRL2_CTSEN			(1 << 15)
#define AUART_CTRL2_RTS				(1 << 11)
#define AUART_CTRL2_RXE				(1 << 9)
#define AUART_CTRL2_TXE				(1 << 8)
#define AUART_CTRL2_UARTEN			(1 << 0)
#define AUART_CTRL2_RXIFSEL_SHIFT   20
#define AUART_CTRL2_RXIFSEL_MASK   (7 << AUART_CTRL2_RXIFSEL_SHIFT)
#define AUART_CTRL2_RXIFSEL_NOT_EMPTY   (0 << AUART_CTRL2_RXIFSEL_SHIFT)
#define AUART_CTRL2_RXIFSEL_ONE_QUARTER   (1 << AUART_CTRL2_RXIFSEL_SHIFT)
#define AUART_CTRL2_RXIFSEL_ONE_HALF   (2 << AUART_CTRL2_RXIFSEL_SHIFT)
#define AUART_CTRL2_RXIFSEL_THREE_QUARTER   (3 << AUART_CTRL2_RXIFSEL_SHIFT)
#define AUART_CTRL2_RXIFSEL_SEVEN_EIGHTS   (4 << AUART_CTRL2_RXIFSEL_SHIFT)
#define AUART_CTRL2_TXIFSEL_SHIFT   16
#define AUART_CTRL2_TXIFSEL_MASK   (7 << AUART_CTRL2_TXIFSEL_SHIFT)
#define AUART_CTRL2_TXIFSEL_NOT_EMPTY   (0 << AUART_CTRL2_TXIFSEL_SHIFT)
#define AUART_CTRL2_TXIFSEL_ONE_QUARTER   (1 << AUART_CTRL2_TXIFSEL_SHIFT)
#define AUART_CTRL2_TXIFSEL_ONE_HALF   (2 << AUART_CTRL2_TXIFSEL_SHIFT)
#define AUART_CTRL2_TXIFSEL_THREE_QUARTER   (3 << AUART_CTRL2_TXIFSEL_SHIFT)
#define AUART_CTRL2_TXIFSEL_SEVEN_EIGHTS   (4 << AUART_CTRL2_TXIFSEL_SHIFT)

#define AUART_LINECTRL_BAUD_DIVINT_SHIFT	16
#define AUART_LINECTRL_BAUD_DIVINT_MASK		0xffff0000
#define AUART_LINECTRL_BAUD_DIVINT(v)		(((v) & 0xffff) << 16)
#define AUART_LINECTRL_BAUD_DIVFRAC_SHIFT	8
#define AUART_LINECTRL_BAUD_DIVFRAC_MASK	0x00003f00
#define AUART_LINECTRL_BAUD_DIVFRAC(v)		(((v) & 0x3f) << 8)
#define AUART_LINECTRL_WLEN_MASK		0x00000060
#define AUART_LINECTRL_WLEN(v)			(((v) & 0x3) << 5)
#define AUART_LINECTRL_FEN			(1 << 4)
#define AUART_LINECTRL_STP2			(1 << 3)
#define AUART_LINECTRL_EPS			(1 << 2)
#define AUART_LINECTRL_PEN			(1 << 1)
#define AUART_LINECTRL_BRK			(1 << 0)

#define AUART_INTR_ABDIEN			(1 << 27)
#define AUART_INTR_OEIEN			(1 << 26)
#define AUART_INTR_BEIEN			(1 << 25)
#define AUART_INTR_PEIEN			(1 << 24)
#define AUART_INTR_FEIEN			(1 << 23)
#define AUART_INTR_RTIEN			(1 << 22)
#define AUART_INTR_TXIEN			(1 << 21)
#define AUART_INTR_RXIEN			(1 << 20)
#define AUART_INTR_CTSMIEN			(1 << 17)
#define AUART_INTR_ABDIS			(1 << 11)
#define AUART_INTR_OEIS				(1 << 10)
#define AUART_INTR_BEIS				(1 << 9)
#define AUART_INTR_PEIS				(1 << 8)
#define AUART_INTR_FEIS				(1 << 7)
#define AUART_INTR_RTIS				(1 << 6)
#define AUART_INTR_TXIS				(1 << 5)
#define AUART_INTR_RXIS				(1 << 4)
#define AUART_INTR_DSRMIS			(1 << 3)
#define AUART_INTR_DCDMIS			(1 << 2)
#define AUART_INTR_CTSMIS			(1 << 1)
#define AUART_INTR_RIMIS			(1 << 0)

#define AUART_STAT_BUSY				(1 << 29)
#define AUART_STAT_CTS				(1 << 28)
#define AUART_STAT_TXFE				(1 << 27)
#define AUART_STAT_TXFF				(1 << 25)
#define AUART_STAT_RXFE				(1 << 24)
#define AUART_STAT_OERR				(1 << 19)
#define AUART_STAT_BERR				(1 << 18)
#define AUART_STAT_PERR				(1 << 17)
#define AUART_STAT_FERR				(1 << 16)

struct per_connection_data;

/* Information about a single hardware UART */
struct mxs_auart_port {
	unsigned long mapbase;							//physical address of UART registers
	unsigned long irq;								//interrupt number
	void __iomem* membase;							//logical address of UART registers
	int open_count;									//number of open connections

	struct circ_buf rxbuf;							//RX buffer
	struct per_connection_data* tx_connection;		//connection which is currently sending
	spinlock_t lock_tx;								//TX lock for accessing tx_connection

	struct semaphore sem;							//semaphore for accessing this struct
	wait_queue_head_t readq;						//wait queue for read operations
	wait_queue_head_t writeq;						//wait queue for write operations
	
	struct clk *clk;								//System clock assigned to the UART device
	struct device *dev;								//System device
	
	dev_t devnode;									//Major/minor of /dev entry
	struct cdev cdev;								//character device structure
	struct class * class;							//driver class
	
	struct termios termios;							//dummy termios for emulating tty ioctls
	
	int count_tx;									//Statistic counter: Number of bytes transmitted
	int count_rx;									//Statistic counter: Number of bytes received
	int count_brk;									//Statistic counter: Number of break conditions received
	int count_parity;								//Statistic counter: Number of parity errors
	int count_frame;								//Statistic counter: Number of frame errors
	int count_overrun;								//Statistic counter: Number of RX overruns in hardware FIFO
	int count_buf_overrun;							//Statistic counter: Number of RX overruns in user space buffer
};

/* Information about a single connection from user space */
struct per_connection_data
{
	unsigned char txbuf[512];				//tx buffer. For HM-MOD-UART set buffer size at least to 3072
	size_t tx_buf_length;					//length of tx frame transmitted from userspace
	size_t tx_buf_index;					//index into txbuf
	
	struct mxs_auart_port* port;			//corresponding port
	
	unsigned long priority;					//priority of the corresponding channel

	struct semaphore sem;					//semaphore for accessing this struct. 
};

/* Array of port information for ports handled by this driver */
static struct mxs_auart_port *auart_port[MXS_AUART_PORTS];

static void mxs_raw_auart_start_tx(struct mxs_auart_port *port);
static struct mxs_auart_port* mxs_raw_auart_port_by_devnode( dev_t devnode );

/* read() function. */
static ssize_t mxs_raw_auart_read(struct file *filp, char *buf, size_t count, loff_t *offset)
{
	struct per_connection_data *conn = filp->private_data;
	struct mxs_auart_port *port = conn->port;

	if (down_interruptible(&port->sem))
	return -ERESTARTSYS;
	
	while(!CIRC_CNT( port->rxbuf.head, port->rxbuf.tail, CIRCBUF_SIZE)) { /* nothing to read */
		up(&port->sem); /* release the lock */
		if (filp->f_flags & O_NONBLOCK)
		return -EAGAIN;
		if (wait_event_interruptible(port->readq, CIRC_CNT( port->rxbuf.head, port->rxbuf.tail, CIRCBUF_SIZE)))
		return -ERESTARTSYS; /* signal: tell the fs layer to handle it */
		/* otherwise loop, but first reacquire the lock */
		if (down_interruptible(&port->sem))
		return -ERESTARTSYS;
	}
	/* ok, data is there, return something */
	count = min((int)count, CIRC_CNT_TO_END( port->rxbuf.head, port->rxbuf.tail, CIRCBUF_SIZE));
	if (copy_to_user(buf, port->rxbuf.buf+port->rxbuf.tail, count)) {
		up (&port->sem);
		return -EFAULT;
	}
	smp_mb();
	port->rxbuf.tail = (port->rxbuf.tail + count) & (CIRCBUF_SIZE - 1);
	up (&port->sem);

	return count;
}

/* try to become the current sender and start sending. Fails if a higher priority send is in progress */
static int acquire_sender( struct per_connection_data *conn )
{
	int retval = 0;
	struct mxs_auart_port *port = conn->port;
	unsigned long lock_flags;
	int sender_idle;
	spin_lock_irqsave(&port->lock_tx, lock_flags);
	sender_idle = port->tx_connection == NULL;
	if( (port->tx_connection == NULL) || (port->tx_connection->priority < conn->priority) )
	{
		port->tx_connection = conn;
		retval = 1;
		if( sender_idle )
		{
			mxs_raw_auart_start_tx( port );
		}else{
			wake_up_interruptible( &port->writeq );
		}
	}
	spin_unlock_irqrestore(&port->lock_tx, lock_flags);
	return retval;
}

/* check if sendig by the given connection was completed. Sendig was completed if the sending connection has changed */
static int send_completed( struct per_connection_data *conn )
{
	int retval = 0;
	struct mxs_auart_port *port = conn->port;
	unsigned long lock_flags;
	spin_lock_irqsave(&port->lock_tx, lock_flags);
	retval = port->tx_connection != conn;
	spin_unlock_irqrestore(&port->lock_tx, lock_flags);
	return retval;
}

/* write() function. Waits until count bytes have been transferred to the TX FIFO. May return less than count if send was interrupted by a higher priority write operation */
static ssize_t mxs_raw_auart_write(struct file *filp, const char *buf, size_t count, loff_t *offset)
{
	struct per_connection_data *conn = filp->private_data;
	struct mxs_auart_port *port = conn->port;
	
	int retval=0;
	
	int conn_sem_aquired = 0;/* keep track of aquiring the connection semaphore in order to properly release it */

	if (down_interruptible(&conn->sem))
	{
		retval = -ERESTARTSYS;
		goto exit;
	}
	conn_sem_aquired = 1;
	
	if( count > sizeof(conn->txbuf)  )
	{
		retval =  -EMSGSIZE;
		goto exit;
	}
	
	if(copy_from_user(conn->txbuf, buf, count)){
		retval=-EFAULT;
		goto exit;
	}
	
	conn->tx_buf_index = 0;
	conn->tx_buf_length = count;
	smp_wmb();
	
	if (wait_event_interruptible(port->writeq, acquire_sender( conn ) )){
		retval=-ERESTARTSYS;
		goto exit;
	}
	
	//wait for sending to complete
	if (wait_event_interruptible(port->writeq, send_completed( conn ) )){
		retval=-ERESTARTSYS;
		goto exit;
	}
	
	//return number of characters actually sent
	retval = conn->tx_buf_index;
	
exit:
	if(conn_sem_aquired)up(&conn->sem);
	return retval;    
}

/* Disable TX FIFO interrupt */
static void mxs_raw_auart_stop_txie(struct mxs_auart_port *port)
{
	writel(AUART_INTR_TXIEN, port->membase + AUART_INTR_CLR);
}

/* Transfer the next chunk of characters from the sending connection to the TX FIFO */
static inline void mxs_raw_auart_tx_chars(struct mxs_auart_port *port)
{
	int tx_count = 0;
	while( (tx_count < TX_CHUNK_SIZE) && (!(readl(port->membase + AUART_STAT) & AUART_STAT_TXFF)) && (port->tx_connection != NULL) && (port->tx_connection->tx_buf_index < port->tx_connection->tx_buf_length) )
	{
		writeb(port->tx_connection->txbuf[port->tx_connection->tx_buf_index], port->membase + AUART_DATA);
		port->tx_connection->tx_buf_index++;
		smp_wmb();
		tx_count++;
	}
	if( (port->tx_connection != NULL) && (port->tx_connection->tx_buf_index >= port->tx_connection->tx_buf_length) )
	{
		mxs_raw_auart_stop_txie(port);
		port->tx_connection = NULL;
		smp_wmb();
		wake_up_interruptible( &port->writeq );
	}
}

/* Read a single character from the RX FIFO and store it in the port's circular RX buffer */
static void mxs_raw_auart_rx_char(struct mxs_auart_port *port)
{
	u32 stat;
	u8 c;

	c = readl(port->membase + AUART_DATA);
	stat = readl(port->membase + AUART_STAT);

	port->count_rx++;

	if (stat & AUART_STAT_BERR) {
		port->count_brk++;
		goto out;
	} else if (stat & AUART_STAT_PERR) {
		port->count_parity++;
	} else if (stat & AUART_STAT_FERR) {
		port->count_frame++;
	}

	if (stat & AUART_STAT_OERR)
	port->count_overrun++;

	if( CIRC_SPACE( port->rxbuf.head, port->rxbuf.tail, CIRCBUF_SIZE ) )
	{
		port->rxbuf.buf[port->rxbuf.head] = c;
		smp_wmb();
		port->rxbuf.head = (port->rxbuf.head + 1) & (CIRCBUF_SIZE - 1);
	}
out:
	writel(stat, port->membase + AUART_STAT);
}

/* Read all available characters from the hardware RX FIFO and store them in the port's circular RX buffer. Notify userspace. */
static void mxs_raw_auart_rx_chars(struct mxs_auart_port *port)
{
	u32 stat = 0;

	for (;;) {
		stat = readl(port->membase + AUART_STAT);
		if (stat & AUART_STAT_RXFE)
		break;
		mxs_raw_auart_rx_char(port);
	}

	writel(stat, port->membase + AUART_STAT);
	wake_up_interruptible( &port->readq );
}

/* UART interrupt dispatcher for RX and TX interrupts */
static irqreturn_t mxs_raw_auart_irq_handle(int irq, void *context)
{
	u32 istatus, istat;
	struct mxs_auart_port *port = context;

	istatus = istat = readl(port->membase + AUART_INTR);

	writel(istatus & 0xffffu, port->membase + AUART_INTR_CLR);

	if (istat & (AUART_INTR_RTIS | AUART_INTR_RXIS)) {
		mxs_raw_auart_rx_chars(port);
		istat &= ~(AUART_INTR_RTIS | AUART_INTR_RXIS);
	}

	if (istat & AUART_INTR_TXIS) {
		spin_lock( &port->lock_tx );
		mxs_raw_auart_tx_chars(port);
		spin_unlock( &port->lock_tx );
		istat &= ~AUART_INTR_TXIS;
	}

	return IRQ_HANDLED;
}

/* Reset the UART hardware */ 
static void mxs_raw_auart_reset(struct mxs_auart_port *port)
{
	int i;
	unsigned int reg;

	while ((readl(port->membase + AUART_CTRL2) & AUART_CTRL2_UARTEN) &&	(readl(port->membase + AUART_STAT) & AUART_STAT_BUSY))
		schedule();

	writel(AUART_CTRL2_TXE, port->membase + AUART_CTRL0_CLR);

	writel(AUART_CTRL0_SFTRST, port->membase + AUART_CTRL0_CLR);

	for (i = 0; i < 10000; i++) {
		reg = readl(port->membase + AUART_CTRL0);
		if (!(reg & AUART_CTRL0_SFTRST))
		break;
		udelay(3);
	}
	writel(AUART_CTRL0_CLKGATE, port->membase + AUART_CTRL0_CLR);
}

/* Configure and enable the UART hardware */
static int mxs_raw_auart_startup(struct mxs_auart_port *port)
{
	int rc;
	u32 div, ctrl, ctrl2;

	clk_prepare_enable(port->clk);

	writel(AUART_CTRL0_CLKGATE, port->membase + AUART_CTRL0_CLR);

	writel( AUART_CTRL0_RXTIMEOUT_MASK, port->membase + AUART_CTRL0_CLR);
	writel( (rxto / 8) << AUART_CTRL0_RXTIMEOUT_SHIFT, port->membase + AUART_CTRL0_SET);
	writel(3, port->membase + AUART_CTRL0_SET);
	
	/* FIFO enable, 8 data bits, no parity */
	ctrl = AUART_LINECTRL_FEN | AUART_LINECTRL_WLEN(3);
	
	/* set baud rate */
	div = clk_get_rate(port->clk) * 32 / BAUD;
	ctrl |= AUART_LINECTRL_BAUD_DIVFRAC(div & 0x3F);
	ctrl |= AUART_LINECTRL_BAUD_DIVINT(div >> 6);

	writel(ctrl, port->membase + AUART_LINECTRL);
	
	/* disable + clear interrupts */
	writel(0, port->membase + AUART_INTR);

	rc = request_irq(port->irq, mxs_raw_auart_irq_handle, 0, dev_name(port->dev), port);
	if (rc)
	goto out;

	/* enable RX and TX, set RX FIFO threshold to lowest and TX FIFO threshold to mid */
	
	ctrl2 = AUART_CTRL2_UARTEN | AUART_CTRL2_RXE | AUART_CTRL2_TXE | RXIFSEL | TXIFSEL;
	writel(ctrl2, port->membase + AUART_CTRL2);
	
	/*
	* Enable fifo so all four bytes of a DMA word are written to
	* output (otherwise, only the LSB is written, ie. 1 in 4 bytes)
	*/
	writel(AUART_LINECTRL_FEN, port->membase + AUART_LINECTRL_SET);

	writel(AUART_INTR_OEIEN |
	AUART_INTR_BEIEN |
	AUART_INTR_FEIEN |
	AUART_INTR_RTIEN |
	AUART_INTR_RXIEN,
	port->membase + AUART_INTR);

	port->rxbuf.head = port->rxbuf.tail = 0;
	rc = 0;

out:
	if (rc < 0)
	clk_disable(port->clk);

	return rc;
}

/* Disable the UART hardware */
static void mxs_raw_auart_shutdown(struct mxs_auart_port *port)
{

	writel(AUART_CTRL2_UARTEN, port->membase + AUART_CTRL2_CLR);

	writel(AUART_CTRL0_CLKGATE, port->membase + AUART_CTRL0_SET);

	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
	port->membase + AUART_INTR_CLR);

	free_irq(port->irq, port);
	clk_disable_unprepare(port->clk);
}

/* Start sending */
static void mxs_raw_auart_start_tx(struct mxs_auart_port *port)
{
	/* enable transmitter */
	writel(AUART_CTRL2_TXE, port->membase + AUART_CTRL2_SET);

	/* clear + enable TX interrupts */
	writel(AUART_INTR_TXIS,  port->membase + AUART_INTR_CLR);
	writel(AUART_INTR_TXIEN, port->membase + AUART_INTR_SET);

	mxs_raw_auart_tx_chars(port);
}

/* Get the port structure for a given device node (major/minor) */
static struct mxs_auart_port * mxs_raw_auart_port_by_devnode( dev_t devnode )
{
	int i;
	for( i = 0; i < MXS_AUART_PORTS; i++ )
	{
		if( auart_port[i] && auart_port[i]->devnode == devnode )
		{
			return auart_port[i];
		}
	}
	return NULL;
}


/* open(). Attach to UART port identified by devnode. If necessary, perform initialization and enable port for reception */
static int mxs_raw_auart_open(struct inode *inode, struct file *filp)
{
	int retval;
	struct mxs_auart_port *port = mxs_raw_auart_port_by_devnode(inode->i_rdev);
	struct per_connection_data* conn;
	
	if( !port )
	{
		return -ENODEV;
	}
	
	if (down_interruptible(&port->sem)){
		return -ERESTARTSYS;
	}
	
	if( !port->open_count ){
		port->rxbuf.head = port->rxbuf.tail = 0;
		retval = mxs_raw_auart_startup( port );
		if(retval){
			up(&port->sem);
			return retval;
		}
		init_waitqueue_head(&port->writeq);
		init_waitqueue_head(&port->readq);
	}
	port->open_count++;

	up(&port->sem);

	conn = kmalloc( sizeof( struct per_connection_data ), GFP_KERNEL );
	memset( conn, 0, sizeof( struct per_connection_data ) );
	conn->port = port;

	sema_init(&conn->sem, 1);

	filp->private_data = (void *)conn;
	
	return 0;
}

/* close(). Remove conection. If necessary, disable UART port */
static int mxs_raw_auart_close(struct inode *inode, struct file *filp)
{
	struct per_connection_data *conn = filp->private_data;
	struct mxs_auart_port *port = conn->port;

	if (down_interruptible(&conn->sem)){
		return -ERESTARTSYS;
	}

	kfree(conn);
	
	if (down_interruptible(&port->sem)){
		return -ERESTARTSYS;
	}
	
	port->open_count--;
	
	if(!port->open_count){
		mxs_raw_auart_shutdown( port);
	}
	
	up(&port->sem);
	
	return 0;
}

/* poll(). Called from userspace to request notification if port becomes readable or writeable. */
static unsigned int mxs_raw_auart_poll(struct file* filp, poll_table* wait)
{
	unsigned int mask=0;
	struct per_connection_data *conn = filp->private_data;
	struct mxs_auart_port *port = conn->port;
	unsigned long lock_flags;
	
	poll_wait(filp, &port->readq, wait);
	poll_wait(filp, &port->writeq, wait);
	
	spin_lock_irqsave(&port->lock_tx, lock_flags);
	if( (port->tx_connection == NULL) || (port->tx_connection->priority < conn->priority) )
	{
		mask |= POLLOUT | POLLWRNORM;
	}
	spin_unlock_irqrestore(&port->lock_tx, lock_flags);
	
	if( CIRC_CNT(port->rxbuf.head, port->rxbuf.tail, CIRCBUF_SIZE) > 0 ) mask |= POLLIN | POLLRDNORM;
	return mask;
}

/* ioctl(). Called from userspace to set the connection priority. Emulates a subset of TTY ioctls used by some userspace tools. */
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,11))
static int mxs_raw_auart_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
#else
static long mxs_raw_auart_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
#endif
{
	struct per_connection_data *conn = filp->private_data;
	struct mxs_auart_port *port = conn->port;
	int err = 0;
	int ret = 0;
	unsigned long temp;
	
	if (_IOC_TYPE(cmd) == MXS_AUART_IOC_MAGIC)
	{
		/*
		* extract the type and number bitfields, and don't decode
		* wrong cmds: return ENOTTY (inappropriate ioctl) before access_ok()
		*/
		if (_IOC_NR(cmd) > MXS_AUART_IOC_MAXNR) return -ENOTTY;

		/*
		* the direction is a bitmask, and VERIFY_WRITE catches R/W
		* transfers. `Type' is user-oriented, while
		* access_ok is kernel-oriented, so the concept of "read" and
		* "write" is reversed
		*/
		if (_IOC_DIR(cmd) & _IOC_READ)
		err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));
		else if (_IOC_DIR(cmd) & _IOC_WRITE)
		err =  !access_ok(VERIFY_READ, (void *)arg, _IOC_SIZE(cmd));
		if (err) return -EFAULT;
	}

	if (down_interruptible(&conn->sem))
		return -ERESTARTSYS;
	
	switch(cmd) {

	/* Set connection priority */
	case MXS_AUART_IOCSPRIORITY: /* Set: arg points to the value */
		ret = __get_user(temp, (unsigned long *)arg);
		if(ret)break;
		conn->priority = temp;
		break;

	/* Get connection priority */
	case MXS_AUART_IOCGPRIORITY: /* Get: arg is pointer to result */
		ret = __put_user(conn->priority, (unsigned long *)arg);
		break;
		
	/* Emulated TTY ioctl: Get termios struct */
	case TCGETS:
		if( access_ok(VERIFY_READ, (void *)arg, sizeof(struct termios) ) )
		{
			if (down_interruptible(&port->sem))
			{
				ret = -ERESTARTSYS;
			}else{
				ret = copy_to_user( (void*)arg, &port->termios, sizeof(struct termios) );
				up(&port->sem);
			}
		} else {
			ret = -EFAULT;
		}
	break;
	
	/* Emulated TTY ioctl: Set termios struct */
	case TCSETS:
		if( access_ok(VERIFY_WRITE, (void *)arg, sizeof(struct termios) ) )
		{
			if (down_interruptible(&port->sem))
			{
				ret = -ERESTARTSYS;
			}else{
				ret = copy_from_user( &port->termios, (void*)arg, sizeof(struct termios) );
				up(&port->sem);
			}
		} else {
			ret = -EFAULT;
		}
		break;
		
	/* Emulated TTY ioctl: Get receive queue size */
	case TIOCINQ:
		if (down_interruptible(&port->sem))
		{
			ret = -ERESTARTSYS;
		}else{
			temp = CIRC_CNT( port->rxbuf.head, port->rxbuf.tail, CIRCBUF_SIZE);
			up(&port->sem);
			ret = __put_user( temp, (int*)arg );
		}
		break;
		
	/* Emulated TTY ioctl: Get send queue size */
	case TIOCOUTQ:
		temp = 0;
		ret = __put_user( temp, (int*)arg );
		break;
		
	/* Emulated TTY ioctl: Exclusive use */
	case TIOCEXCL:
		break;
		
	/* Emulated TTY ioctl: Flush */
	case TCFLSH:
		break;
		
	/* Emulated TTY ioctl: Get states of modem control lines */
	case TIOCMGET:
		temp = TIOCM_DSR | TIOCM_CD | TIOCM_CTS;
		ret = __put_user( temp, (int*)arg );
		break;
		
	/* Emulated TTY ioctl: Set states of modem control lines */
	case TIOCMSET:
		break;

	default:
		ret = -ENOTTY;
	}
	
	up(&conn->sem);
	return ret;

}



static struct file_operations mxs_raw_auart_fops = {
	.owner		= THIS_MODULE,
	.llseek		= no_llseek,
	.read		= mxs_raw_auart_read,
	.write		= mxs_raw_auart_write,
	.open		= mxs_raw_auart_open,
	.release	= mxs_raw_auart_close,
	.poll       = mxs_raw_auart_poll,
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,11))
	.ioctl      = mxs_raw_auart_ioctl,
#else
	.unlocked_ioctl = mxs_raw_auart_ioctl,
#endif
};

#ifdef PROC_DEBUG
/* Provides values of relevant hardware registers and statistical information via /proc filesystem. Useful for debugging */
static int mxs_raw_auart_read_procmem(char* buf, char** start, off_t offset, int count, int* eof, void* data)
{
	struct mxs_auart_port *port = data;
	int len = 0;
	
	len += sprintf(buf+len, "CTRL0    =%08X\n", readl(port->membase + AUART_CTRL0));
	len += sprintf(buf+len, "CTRL1    =%08X\n", readl(port->membase + AUART_CTRL1));
	len += sprintf(buf+len, "CTRL2    =%08X\n", readl(port->membase + AUART_CTRL2));
	len += sprintf(buf+len, "LINECTRL =%08X\n", readl(port->membase + AUART_LINECTRL));
	len += sprintf(buf+len, "INTR     =%08X\n", readl(port->membase + AUART_INTR));
	len += sprintf(buf+len, "STAT     =%08X\n", readl(port->membase + AUART_STAT));

	len += sprintf( buf+len, "open_count=%d\n", port->open_count);
	len += sprintf( buf+len, "count_tx=%d\n", port->count_tx);
	len += sprintf( buf+len, "count_rx=%d\n", port->count_rx);
	len += sprintf( buf+len, "count_brk=%d\n", port->count_brk);
	len += sprintf( buf+len, "count_parity=%d\n", port->count_parity);
	len += sprintf( buf+len, "count_frame=%d\n", port->count_frame);
	len += sprintf( buf+len, "count_overrun=%d\n", port->count_overrun);
	len += sprintf( buf+len, "rxbuf_size=%d\n", CIRC_CNT(port->rxbuf.head, port->rxbuf.tail, CIRCBUF_SIZE));
	len += sprintf( buf+len, "rxbuf_head=%d\n", port->rxbuf.head);
	len += sprintf( buf+len, "rxbuf_tail=%d\n", port->rxbuf.tail);
	
	*eof = 1;
	return len;
}
#endif

/* Exit function called once for every UART port handled by this driver. */
static int __devexit mxs_raw_auart_remove(struct platform_device *pdev)
{
	struct mxs_auart_port *port = platform_get_drvdata(pdev);
	
#ifdef PROC_DEBUG
	{
		char proc_name[32];
		sprintf( proc_name, "mxs_auart_raw.%d", pdev->id );
		remove_proc_entry(proc_name, NULL);
	}
#endif
	
	device_destroy(port->class, MKDEV(MAJOR(port->devnode), MINOR(port->devnode)));
	class_destroy(port->class);
	cdev_del(&port->cdev);
	unregister_chrdev_region(port->devnode, 1);
	

	auart_port[pdev->id] = NULL;

	clk_put(port->clk);
	
	kfree(port->rxbuf.buf);
	
	kfree(port);

	return 0;
}

/* Probe function called once for every UART port handled by this driver */
static int __devinit mxs_raw_auart_probe(struct platform_device *pdev)
{
	struct mxs_auart_port *port;
	u32 version;
	int ret = 0;
	struct resource *r;
	char clk_name[32];
	char dev_name[32];

	port = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
	if (!port) {
		ret = -ENOMEM;
		goto out;
	}

	sprintf( clk_name, "mxs-auart.%d", pdev->id );

	port->clk = clk_get_sys(clk_name, NULL);
	if (IS_ERR(port->clk)) {
		printk(KERN_ERR "mxs_auart_raw: Unable to get device clock %s\n", clk_name);
		ret = PTR_ERR(port->clk);
		goto out_free;
	}

	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!r) {
		printk(KERN_ERR "mxs_auart_raw: Unable to get mem resource\n");
		ret = -ENXIO;
		goto out_free_clk;
	}

	sprintf( dev_name, "mxs_auart_raw.%d", pdev->id );
	
	ret = alloc_chrdev_region(&port->devnode, 0, 1, dev_name);
	if( ret )
	{
		printk(KERN_ERR "mxs_auart_raw: Unable to get device number region\n");
		goto out_free_clk;
	}
	cdev_init(&port->cdev, &mxs_raw_auart_fops);
	port->cdev.owner=THIS_MODULE;
	port->cdev.ops=&mxs_raw_auart_fops;
	ret=cdev_add(&port->cdev, port->devnode, 1);
	if(ret){
		printk(KERN_ERR "mxs_auart_raw: Unable to add driver\n");
		goto out_unregister_chrdev_region;
	}
	port->class=class_create(THIS_MODULE, dev_name);
	if(IS_ERR(port->class)){
		ret = -EIO;
		printk(KERN_ERR "mxs_auart_raw: Unable to register driver class\n");
		goto out_cdev_del;
	}
	
	device_create(port->class, NULL, MKDEV(MAJOR(port->devnode), MINOR(port->devnode)), "%s", dev_name);
	

	port->mapbase = r->start;
	port->membase = ioremap(r->start, resource_size(r));
	port->dev = get_device(&pdev->dev);
	port->irq = platform_get_irq(pdev, 0);
	
	sema_init(&port->sem, 1);
	spin_lock_init(&port->lock_tx);
	init_waitqueue_head(&port->readq);
	init_waitqueue_head(&port->writeq);
	
	port->rxbuf.buf = kmalloc(CIRCBUF_SIZE, GFP_KERNEL);
	
	platform_set_drvdata(pdev, port);

	auart_port[pdev->id] = port;

	mxs_raw_auart_reset(port);

	version = readl(port->membase + AUART_VERSION);
	dev_info(&pdev->dev, "Found raw APPUART %d.%d.%d\n",
	(version >> 24) & 0xff,
	(version >> 16) & 0xff, version & 0xffff);

#ifdef PROC_DEBUG
	{
		create_proc_read_entry(dev_name, 0, NULL, mxs_raw_auart_read_procmem, port);
	}
#endif

	return 0;

	auart_port[pdev->id] = NULL;

	out_cdev_del:
	cdev_del(&port->cdev);
	
	out_unregister_chrdev_region:
	unregister_chrdev_region(port->devnode, 1);
	
	out_free_clk:
	clk_put(port->clk);
	out_free:
	kfree(port);
out:
	return ret;
}


static struct platform_driver mxs_auart_driver = {
	.probe = mxs_raw_auart_probe,
	.remove = __devexit_p(mxs_raw_auart_remove),
	.driver = {
		.name = MODNAME,
		.owner = THIS_MODULE,
	},
};

/* Init funtion for this driver. */
static int __init mxs_raw_auart_init(void)
{
	int r;
	
	memset( auart_port, 0, sizeof(auart_port) );
	r = platform_driver_register(&mxs_auart_driver);
	if (r)
	goto out;

	return 0;

out:
	return r;
}

/* Exit function for this driver */
static void __exit mxs_raw_auart_exit(void)
{
	platform_driver_unregister(&mxs_auart_driver);
}

module_init(mxs_raw_auart_init);
module_exit(mxs_raw_auart_exit);
MODULE_DESCRIPTION("eQ-3 raw MXS application uart driver");
MODULE_LICENSE("GPL");
