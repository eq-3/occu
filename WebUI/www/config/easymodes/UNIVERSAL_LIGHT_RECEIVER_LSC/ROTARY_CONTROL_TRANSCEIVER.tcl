#!/bin/tclsh

global url sender_address

# array set paramSet [xmlrpc $url getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
set mode [lindex [split $sender_address :] 1]

puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"
puts "<script type=\"text/javascript\">mode_MULTI_MODE_INPUT_TRANSMITTER = $mode</script>"
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_LSC/ROTARY_CONTROL_TRANSCEIVER_$mode.tcl]
