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

set sDivname    "DP_01"
set sContrast   ""
set sBrightness ""
set sBacklight  ""

cgi_eval {
    cgi_input
#cgi_debug -on
	catch {cgi_import sDivname}
	catch {cgi_import sContrast}
	catch {cgi_import sBrightness}
	catch {cgi_import sBacklight}
}

puts {<hssml pagetype="DISPLAY">}
puts {<head>}
puts "<goto div=\"$sDivname\"/>"
puts "<date symbols format=\"$dateformat\"/>"
puts "<time symbols format=\"$timeformat\"/>"
puts "<a href=\"http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/>"
puts {</head>}
puts {<body>}
puts {<div name="DP_01"  >Display<br/>Contrast<                             a href="#DP_02" key="4"/><a href="#DP_01_a" key="2"/></div>}
puts {<div name="DP_02"  >Display<br/>Backlight<  a href="#DP_01" key="1"/><a href="#DP_03" key="4"/><a href="#DP_02_a" key="2"/></div>}
puts {<div name="DP_03"  >Display<br/>Brightness< a href="#DP_02" key="1"/><a href="#DP_99" key="4"/><a href="#DP_03_a" key="2"/></div>}
puts {<div name="DP_99"  >Display<br/>Back<       a href="#DP_03" key="1"/><                          a href="http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_03" key="2"/></div>}
puts "<div name=\"DP_01_a\">Contrast<br/><  a href=\"#DP_01\" key=\"2\"/><form action=\"DISPLAY_SETTING\" method=\"get\" enctype=\"text/plain\" autosubmit=\"1\"><stepper name=\"CONTRAST\" min=\"0\" max=\"15\" [expr {$sContrast==""?"":"init=\"$sContrast\""} ] step=\"1\"/><input type=\"incdata\"     key=\"4\"/><input type=\"decdata\"     key=\"1\"/></form></div>"
puts "<div name=\"DP_02_a\">Backlight<br/>"
puts "<form action=\"DISPLAY_SETTING\" method=\"get\" enctype=\"text/plain\">"
puts "<input type=\"hidden\" name=\"sDivname\" value=\"DP_02\"/>"
puts "<input type=\"hidden\" name=\"sLoadPage\" value=\"http://127.0.0.1/config/display/display.cgi\"/>"
puts "<select name=\"BACKLIGHT\">"
puts "<option value=\"0\"    [expr {$sBacklight!="0"?"":"selected"} ]    readout=\"Aus\"/>"
puts "<option value=\"5\"    [expr {$sBacklight!="5"?"":"selected"} ]    readout=\"5s\"/>"
puts "<option value=\"10\"   [expr {$sBacklight!="10"?"":"selected"} ]   readout=\"10s\"/>"
puts "<option value=\"15\"   [expr {$sBacklight!="15"?"":"selected"} ]   readout=\"15s\"/>"
puts "<option value=\"30\"   [expr {$sBacklight!="30"?"":"selected"} ]   readout=\"30s\"/>"
puts "<option value=\"60\"   [expr {$sBacklight!="60"?"":"selected"} ]   readout=\"1min\"/>"
puts "<option value=\"300\"  [expr {$sBacklight!="300"?"":"selected"} ]  readout=\"5min\"/>"
puts "<option value=\"900\"  [expr {$sBacklight!="900"?"":"selected"} ]  readout=\"15min\"/>"
puts "<option value=\"1800\" [expr {$sBacklight!="1800"?"":"selected"} ] readout=\"30min\"/>"
puts "<option value=\"3600\" [expr {$sBacklight!="3600"?"":"selected"} ] readout=\"1h\"/>"
puts "<option value=\"7200\" [expr {$sBacklight!="7200"?"":"selected"} ] readout=\"2h\"/>"
puts "<option value=\"-1\"   [expr {$sBacklight!="-1"?"":"selected"} ]   readout=\"On\"/>"
puts "</select>"
puts "<input type=\"submit\" key=\"2\"/><input type=\"incdata\" key=\"4\"/><input type=\"decdata\"     key=\"1\"/></form></div>"
puts "<div name=\"DP_03_a\">Brightness<br/><a href=\"#DP_03\" key=\"2\"/>"
puts "<form action=\"DISPLAY_SETTING\" method=\"get\" enctype=\"text/plain\" autosubmit=\"1\">"
puts "<stepper name=\"BRIGHTNESS\" min=\"0\" max=\"15\" [expr {$sBrightness==""?"":"init=\"$sBrightness\""} ] step=\"1\"/>"
puts "<input type=\"incdata\" key=\"4\"/>"
puts "<input type=\"decdata\" key=\"1\"/>"
puts "</form></div>"
puts {</body>}
puts {</hssml>}
