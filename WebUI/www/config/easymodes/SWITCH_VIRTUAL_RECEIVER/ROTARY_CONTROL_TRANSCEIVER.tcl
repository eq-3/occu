#!/bin/tclsh

global url sender_address

# array set paramSet [xmlrpc $url getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
set mode [lindex [split $sender_address :] 1]

puts "<script type=\"text/javascript\">mode_MULTI_MODE_INPUT_TRANSMITTER = $mode</script>"
source [file join $env(DOCUMENT_ROOT) config/easymodes/SWITCH_VIRTUAL_RECEIVER/ROTARY_CONTROL_TRANSCEIVER_$mode.tcl]
