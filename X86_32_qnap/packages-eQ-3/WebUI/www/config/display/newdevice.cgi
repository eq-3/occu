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

set iDevCount [count_devices iface_url]

catch {xmlrpc $iface_url($INSTALL_IFACE) setInstallMode [list bool 1]}

puts {<hssml pagetype="NEWDEVICE">}
puts {<head>}
puts "<date symbols format=\"$dateformat\"/>"
puts "<time symbols format=\"$timeformat\"/>"
puts "<a href=\"http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/>"
puts {</head>}
puts {<body>}
puts "<div name=\"ND_01\"><blink>Listening!</blink><form action=\"http://127.0.0.1/config/display/countdevices.cgi\" method=\"get\" enctype=\"text/plain\" autosubmit=\"1\"><input type=\"hidden\" name=\"iDevCount\"    value=\"$iDevCount\"/><input type=\"incdata\" key=\"7\"/><input type=\"submit\" key=\"2\"/></form><a href=\"?incdata\" key=\"0\" autoswitch=\"2000\"/><skip/><counter from=\"59\" to=\"1\"/>s</div>"
puts {</body>}
puts {</hssml>}
