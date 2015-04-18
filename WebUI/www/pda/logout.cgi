#!/bin/tclsh

load tclrega.so

source extern/cgi.tcl
source extern/tmpl_parser.tcl

source eq3/ui.tcl
source eq3/rega.tcl
source eq3/session.tcl

source eq3/util.tcl
source eq3/template.tcl

set TEMPLATE_FILE templates/logout.tmpl


cgi_eval {
  
	cgi_input
	set sid {}
	catch { import sid }
	set uiStyle {}
	catch { import uiStyle }
	
	session_logout $sid
	
  
  set template [template_parseFile $TEMPLATE_FILE]
  
  http_head
  puts [eval $template]

}
