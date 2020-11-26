##
# CCU.getHttpsRedirectEnabled
#
# Checks if automatic redirect from http to https is enabled or disabled.
# Return value:         1: Redirect enabled 
#                       0: Redirect disabled 
#
##

set file "/etc/config/httpsRedirectEnabled"

jsonrpc_response [file exists $file]

