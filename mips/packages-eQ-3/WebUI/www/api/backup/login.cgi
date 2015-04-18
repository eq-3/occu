##
# login
# 
# args
#  username
#  password
#
# error-codes
#  MISSING_ARGUMENT
#  LOGIN_ERROR
#  TOO_MANY_SESSIONS 
#  INVALID_CREDENTIALS
##

source common.tcl

proc main { } {
	set username [getQueryArg username]
	set password [getQueryArg password]
	
	if [catch {
		set sid [session_login $username $password]
	} errorMsg] {
		switch $errorMsg {
			"create"      	{ error TOO_MANY_SESSIONS }
			"credentials"		{ error INVALID_CREDENTIALS }
			default 				{ error LOGIN_ERROR }
		}
	}
	
	puts "Content-Type: text/plain"
	puts ""
	puts -nonewline $sid

}

startup
