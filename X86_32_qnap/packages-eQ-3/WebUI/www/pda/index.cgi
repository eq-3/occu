#!/bin/tclsh

load tclrega.so

source extern/cgi.tcl
source extern/tmpl_parser.tcl

source eq3/ui.tcl
source eq3/util.tcl
source eq3/template.tcl

set TEMPLATE_FILE templates/index.tmpl

cgi_eval {
  
	cgi_input
	set uiStyle {}
	catch { import uiStyle }

  set template [template_parseFile $TEMPLATE_FILE]
  
  http_head
  puts [eval $template]

}
