##
# run-script
##

source common.tcl

proc put_link { linkstr } {
	array set link $linkstr
	
	puts "\[BEGIN LINK\]"
	puts "NAME=$link(NAME)"
	puts "DESCRIPTION=$link(DESCRIPTION)"
	puts "SENDER=$link(SENDER)"
	puts "RECEIVER=$link(RECEIVER)"
	puts "\[END LINK\]"

}

proc main { } {
	set sid       [getQueryArg sid]
	set interface [getQueryArg interface]

	if { [session_isValid $sid] == "false" } { error INVALID_SESSION }
	
	puts "Content-Type: text/plain"
	puts ""

	set links [xmlrpc [getInterfaceUrl $interface] getLinks [list string {}] [list int 0]]
	foreach link $links {
		put_link $link
	}
	
}

startup
