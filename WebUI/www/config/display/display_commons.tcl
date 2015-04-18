#!/bin/tclsh
source once.tcl
loadOnce tclrpc.so

set DISPLAY_FILE    "/etc/config/hss_lcd.conf"
set INTERFACES_FILE "/etc/config/InterfacesList.xml"
set TIMEOUT         "300000"
set INSTALL_IFACE   BidCos-RF

proc read_interfaces_for_display {p_iface_url p_iface_descr} {

    global INTERFACES_FILE

	upvar $p_iface_url   iface_url
	upvar $p_iface_descr iface_descr

	if { ! [catch {open $INTERFACES_FILE RDONLY} fd] } then {
	
        set contents [read $fd]
		
        while { [regexp -indices {</ipc[^>]*>} $contents range] } {
		
            set section  [string range $contents 0                            [lindex $range 1]]
            set contents [string range $contents [expr [lindex $range 1] + 1] end]
			
            if { 
                    [regexp {<name[^>]*>([^<]+)</name} $section dummy name] &&
                    [regexp {<url[^>]*>([^<]+)</url} $section dummy url] &&
                    [regexp {<info[^>]*>([^<]+)</info} $section dummy description ]
            } {
                array set iface_url   [list $name $url]
                array set iface_descr [list $name $description]
            }
        }
		
        close $fd
    }
}

proc count_devices { p_iface_url } {

	global INSTALL_IFACE

	upvar $p_iface_url iface_url

	set chlist {}
	catch {set chlist [xmlrpc $iface_url($INSTALL_IFACE) listDevices [list bool 0]]}
	
	set devcount 0

	#Nur die Geräte herausfiltern. Nicht die Kanäle zählen.
	set chcount [llength $chlist]
	for {set i 0} {$i < $chcount} {incr i} {
		array set dev_descr [lindex $chlist $i]
		if { $dev_descr(PARENT) == "" } then { incr devcount }
	}

	return $devcount
}
