#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce common.tcl
sourceOnce display_commons.tcl
loadOnce tclrpc.so

array set iface_url   ""
array set iface_descr ""
read_interfaces_for_display iface_url iface_descr
	
read_assignment_file $DISPLAY_FILE DISPLAY_VALUES

set dateformat "%d%m%y"
catch {set dateformat $DISPLAY_VALUES(DATEFORMAT)}

set timeformat "%H%M"
catch {set timeformat $DISPLAY_VALUES(TIMEFORMAT)}

set oldcount 0

cgi_eval {
    cgi_input
	catch {
		cgi_import iDevCount
		set oldcount $iDevCount
	}
}

catch {xmlrpc $iface_url($INSTALL_IFACE) setInstallMode [list bool 0]} 

set iDevNewCount [count_devices iface_url]
set delta [expr $iDevNewCount - $oldcount]

puts {<hssml pagetype="COUNTDEVICES">}
puts {<head>}
puts "<date symbols format=\"$dateformat\"/>"
puts "<time symbols format=\"$timeformat\"/>"
puts "<a href=\"http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/>"
puts {</head>}
puts {<body>}
puts "<div name=\"ND_01\">$delta<br/>new devices<a href=\"http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_00\" key=\"2\"/></div>"
puts {</body>}
puts {</hssml>}
