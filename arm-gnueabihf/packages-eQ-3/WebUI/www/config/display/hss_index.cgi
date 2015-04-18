#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce common.tcl
sourceOnce display_commons.tcl

read_assignment_file $DISPLAY_FILE DISPLAY_VALUES

set dateformat "%d%m%y"
catch {set dateformat $DISPLAY_VALUES(DATEFORMAT)}

set timeformat "%H%M"
catch {set timeformat $DISPLAY_VALUES(TIMEFORMAT)}

set sDivname "M_00"

cgi_eval {
    cgi_input
	catch {cgi_import sDivname}
}

puts {<hssml pagetype="MENU">}
puts {<head>}
puts "<goto div=\"$sDivname\"/>"
puts "<date symbols format=\"$dateformat\"/>"
puts "<time symbols format=\"$timeformat\"/>"
puts {</head>}
puts {<body>}
puts {<div name="M_00"><skip count="4"/>CCU     HomeMatic<a href="#M_99" key="1" duration="5"/><a href="#M_01" key="2"/><a href="#M_99" key="4" duration="5"/></div>}
puts "<div name=\"M_01\">Network<a href=\"#M_02\" key=\"4\"/><a href=\"http://127.0.0.1/config/display/network.cgi\"                            key=\"2\"/><a href=\"#M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/></div>"
puts "<div name=\"M_02\">Time<   a href=\"#M_03\" key=\"4\"/><a href=\"#M_01\" key=\"1\"/><a href=\"http://127.0.0.1/config/display/datetime.cgi?sDivname=DT_01\" key=\"2\"/><a href=\"#M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/></div>"
puts "<div name=\"M_03\">Display<a href=\"#M_04\" key=\"4\"/><a href=\"#M_02\" key=\"1\"/><a href=\"http://127.0.0.1/config/display/display.cgi?sDivname=DP_01\"    key=\"2\"/><a href=\"#M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/></div>"
puts "<div name=\"M_04\">Back<                            a href=\"#M_03\" key=\"1\"/><a href=\"#M_00\" key=\"2\" autoswitch=\"$TIMEOUT\"/></div>"
puts {<div name="M_99"><form action="http://127.0.0.1/config/display/newdevice.cgi" method="get" enctype="text/plain"><input type="hidden" name="sRedirectURL" value="%22http://127.0.0.1/config/display/newdevice.cgi?sDivname=ND_03%22"/><input type="hidden" name="sInstallMode" value="true"/><input type="submit" key="2"/></form><a href="?submit" key="2" autoswitch="1"/></div>}
puts {</body>}
puts {</hssml>}
