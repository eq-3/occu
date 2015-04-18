##
# run-script
##

source common.tcl

proc main { } {
	set sid    [getQueryArg sid]
	set script [getPostData]

	if { [session_isValid $sid] == "false" } { error INVALID_SESSION }
	
	puts "Content-Type: text/plain"
	puts ""
	puts [encoding convertfrom utf-8 [rega_exec $script]]
}

startup
