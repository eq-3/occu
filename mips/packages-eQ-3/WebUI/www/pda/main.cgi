#!/bin/tclsh

load tclrega.so

source extern/cgi.tcl
source extern/tmpl_parser.tcl

source eq3/ui.tcl
source eq3/rega.tcl
source eq3/session.tcl
source eq3/favorite.tcl

source eq3/util.tcl
source eq3/template.tcl

set TEMPLATE_FILE                      templates/main.tmpl
set TEMPLATE_FILE_ERROR_CREDENTIALS    templates/error_credentials.tmpl
set TEMPLATE_FILE_ERROR_CREATE_SESSION templates/error_create_session.tmpl
set TEMPLATE_FILE_ERROR_SESSION        templates/error_session.tmpl

proc createSession { } {
	global sid login password TEMPLATE_FILE_ERROR_CREDENTIALS TEMPLATE_FILE_ERROR_CREATE_SESSION UI_URLBASE
	
	if { [catch { set sid [session_login $login $password] } errMsg] } then {
	
		set templateFile $TEMPLATE_FILE_ERROR_CREDENTIALS
		if { {create} == $errMsg } then { 
			set templateFile $TEMPLATE_FILE_ERROR_CREATE_SESSION
		}
		
		set template [template_parseFile $templateFile]
		http_head
		puts [eval $template]
		
		exit
	}
}

cgi_eval {
  
	cgi_input
	
	set login {}
	catch { import login }
	set password {}
	catch { import password }
	set sid {}
	catch { cgi_import sid }
	set uiStyle {}
	catch { import uiStyle }
  
	if { {} == $sid } then { createSession }
	
	if { {true} != [session_isValid $sid] } then {
		http_head
		puts [eval [template_parseFile $TEMPLATE_FILE_ERROR_SESSION]]
		exit
	}
	
	set userId [session_getUserId $sid]
	
  set template [template_parseFile $TEMPLATE_FILE]
  
  http_head
  puts [eval $template]

}
