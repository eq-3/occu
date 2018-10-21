##
# CCU.getSecurityLevel
#
# Retrieves current security level.
# Parameters: None
# Return value: Current security level of type string.
#               Possible values:
#                       LOW :   Low security. (compatibility mode)
#                       MEDIUM: Medium security - Authentication enabled; Firewall set to MOST_OPEN
#                       HIGH:   High security - Authentication enabled; Firewall set to RESTRICTIVE
##

source /lib/libsecuritylevel.tcl

set result [ SEC_getsecuritylevel ]

jsonrpc_response [json_toString $result]

