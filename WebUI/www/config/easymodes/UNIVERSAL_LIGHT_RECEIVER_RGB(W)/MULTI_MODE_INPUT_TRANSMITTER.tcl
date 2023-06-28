#!/bin/tclsh

global url dev_descr_sender

array set paramSet [xmlrpc $url getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
set mode $paramSet(CHANNEL_OPERATION_MODE)

puts "<script type=\"text/javascript\">mode_MULTI_MODE_INPUT_TRANSMITTER = $mode</script>"
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_RGB(W)/MULTI_MODE_INPUT_TRANSMITTER_$mode.tcl]
