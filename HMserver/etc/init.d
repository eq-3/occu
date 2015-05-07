#!/bin/sh
#
# Starts HMServer.
#

LOGLEVEL_HMServer=5
CFG_TEMPLATE_DIR=/etc/config_templates

init() {
	export TZ=`cat /etc/config/TZ | cut -d'-' -f1 | cut -d'+' -f1`
	export JAVA_HOME=/opt/ejre1.7.0_10/
	export PATH=$PATH:$JAVA_HOME/bin
	if [ ! -e /etc/config/log4j.xml ] ; then
		cp $CFG_TEMPLATE_DIR/log4j.xml /etc/config
	fi
}

start() {
	echo -n "Starting HMServer: "
	init
	start-stop-daemon -S -q -p /var/run/HMServer.pid --exec java -- -Xmx32m -Dlog4j.configuration=file:///etc/config/log4j.xml -Dfile.encoding=ISO-8859-1 -jar /opt/HMServer/HMServer.jar &
	sleep 135
	echo "OK"
}
stop() {
	echo -n "Stopping HMServer: "
	start-stop-daemon -K -q -p /var/run/HMServer.pid
	echo "OK"
}
restart() {
	stop
	start
}

case "$1" in
  start)
	start
	;;
  stop)
	stop
	;;
  restart|reload)
	restart
	;;
  *)
	echo "Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $?

