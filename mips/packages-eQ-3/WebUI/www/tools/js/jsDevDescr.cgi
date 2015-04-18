#!/bin/tclsh
source ../once.tcl
sourceOnce ../config/devdescr/DEVDB.tcl
sourceOnce ../../cgi.tcl

set JS_FILENAME "jsDevDescr.js"
	
proc put_javascript {} {

	global DEV_LIST
	global DEV_DESCRIPTION
	global DEV_PATHS
	global DEV_HIGHLIGHT

	puts "DEV_LIST        = new Array();"
	puts "DEV_DESCRIPTION = new Array();"
	puts "DEV_PATHS       = new Array();"
	puts "DEV_HIGHLIGHT   = new Array();"

	foreach descr $DEV_LIST {
		
		puts "DEV_LIST.push('$descr');"
		
		puts "DEV_DESCRIPTION\[\"$descr\"\] = \"$DEV_DESCRIPTION($descr)\";"	
		
		puts "DEV_PATHS\[\"$descr\"\] = new Object();"
		foreach pathentry $DEV_PATHS($descr) {

			set size [lindex $pathentry 0]
			set path [lindex $pathentry 1]
			
			puts "DEV_PATHS\[\"$descr\"\]\[\"$size\"\] = \"$path\";"
		}

		puts "DEV_HIGHLIGHT\[\"$descr\"\] = new Object();"
		foreach coordentry $DEV_HIGHLIGHT($descr) {

			set varname     [lindex $coordentry 0]
			set koordstruct [lrange $coordentry 1 end]

			set js_koord_arr ""
			foreach koord $koordstruct {
				append js_koord_arr "$koord, "
			}
			set js_koord_arr [string trimright $js_koord_arr " ,"]
			
			puts "DEV_HIGHLIGHT\[\"$descr\"\]\[\"$varname\"\] = \[$js_koord_arr\];"
		}
	}
}

proc put_js_functions {} {

	global JS_FILENAME
	
	if { ! [catch {open $JS_FILENAME "r"} jsfile] } then {

		while {! [eof $jsfile] } {
			gets $jsfile zeile

			#Weiche EOF-Marke:
			if {$zeile == "//<."} then { break }
			
			puts $zeile
		}

		catch {close $jsfile}
	}
}

cgi_http_head {
  cgi_content_type "text/javascript; charset=iso-8859-1"
}
put_javascript
put_js_functions
