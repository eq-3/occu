##
# run-script
##

source common.tcl

proc getType { _descr } {
	array set descr $_descr
	
	return $descr(TYPE)
}

proc main { } {
	set sid       [getQueryArg sid]
	set interface [getQueryArg interface]
	set address   [getQueryArg address]
	set key       [getQueryArg key]

	if { [session_isValid $sid] == "false" } { error INVALID_SESSION }
	
	puts "Content-Type: text/plain"
	puts ""

	set descr [xmlrpc [getInterfaceUrl $interface] getParamsetDescription [list string $address] [list string $key]]
	array set types {}
	foreach { id paramDescr } $descr {
		set types($id) [getType $paramDescr]
	}
	
	set paramset [xmlrpc [getInterfaceUrl $interface] getParamset [list string $address] [list string $key]]
	foreach { id value } $paramset {
		puts "$id:$types($id)=$value"
	}
	
}

startup
