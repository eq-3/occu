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

set sDivname "DT_01"
set sSetTF ""
set sSetDF ""

cgi_eval {
    cgi_input
	catch {cgi_import sDivname}
	catch {cgi_import sSetTF}
	catch {cgi_import sSetDF}
}

set dirty 0

if {$sSetTF == "%I%M" || $sSetTF == "%H%M"} then {
	set timeformat $sSetTF
	set DISPLAY_VALUES(TIMEFORMAT) $timeformat
	set dirty 1
}

if {$sSetDF == "%y%m%d" || $sSetDF == "%d%m%y"} then {
	set dateformat $sSetDF
	set DISPLAY_VALUES(DATEFORMAT) $dateformat
	set dirty 1
}

if {$dirty} then {
	set soft_eof 0
	write_assignment_file $DISPLAY_FILE DISPLAY_VALUES $soft_eof
}

puts {<hssml pagetype="DATETIME">}
puts {<head>}
puts "<goto div=\"$sDivname\"/>"
puts "<date symbols format=\"$dateformat\"/>"
puts "<time symbols format=\"$timeformat\"/>"
puts "<a href=\"http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/>"
puts {</head>}
puts {<body>}
puts {<div name="DT_01">Time<br/>Set<                              a href="#DT_02" key="4"/><a href="#DT_07" key="2"/></div>}
puts {<div name="DT_02">Time<br/>12/24<  a href="#DT_01" key="1"/><a href="#DT_03" key="4"/><a href="#DT_05" key="2"/></div>}
puts {<div name="DT_03">Time<br/>DMY/YMD<a href="#DT_02" key="1"/><a href="#DT_04" key="4"/><a href="#DT_06" key="2"/></div>}
puts {<div name="DT_04">Time<br/>Back<   a href="#DT_03" key="1"/><                          a href="http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_02" key="2"/></div>}
puts {<div name="DT_05">Time<br/><form action="http://127.0.0.1/config/display/datetime.cgi" method="get" enctype="text/plain">}
puts {<select name="sSetTF">}
puts "<option [expr {$timeformat=="%I%M"?"selected":""} ] value=\"%I%M\" readout=\"12h\"/>"
puts "<option [expr {$timeformat=="%H%M"?"selected":""} ] value=\"%H%M\" readout=\"24h\"/>"
puts {</select>}
puts {<input type="hidden"  name="sDivname" value="DT_02"/><input type="decdata" key="1"/><input type="submit"  key="2"/><input type="incdata" key="4"/></form></div>}
puts {<div name="DT_06">Time<br/><form action="http://127.0.0.1/config/display/datetime.cgi" method="get" enctype="text/plain">}
puts {<select name="sSetDF">}
puts "<option [expr {$dateformat=="%y%m%d"?"selected":""} ] value=\"%y%m%d\" readout=\"Y-M-D\"/>"
puts "<option [expr {$dateformat=="%d%m%y"?"selected":""} ] value=\"%d%m%y\" readout=\"D-M-Y\"/>"
puts {</select>}
puts {<input type="hidden"  name="sDivname" value="DT_03"/><input type="decdata" key="1"/><input type="submit"  key="2"/><input type="incdata" key="4"/></form></div>}
puts "<div name=\"DT_07\">Set Time<setdatetime format=\"$timeformat$dateformat\" decdatakey=\"1\" inccursorkey=\"2\" incdatakey=\"4\" goto=\"#DT_01\"/></div>"
puts {</body>}
puts {</hssml>}
