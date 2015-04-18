##
# logout
##

source common.tcl

proc main { } {
	set sid [getQueryArg sid]
	
	if [catch { session_logout $sid}] { error LOGOUT }
	
	puts "Content-Type: text/plain"
	puts ""
	puts "OK"	
}

startup
