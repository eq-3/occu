#!/bin/tclsh

global url dev_descr_sender

array set paramSet [xmlrpc $url getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
set mode $paramSet(CHANNEL_OPERATION_MODE)

# if {$dev_descr_sender(PARENT_TYPE)  == "ELV-SH-BM-S"} {
#   set mode 2
# }

puts "<script type=\"text/javascript\">mode_MULTI_MODE_INPUT_TRANSMITTER = $mode</script>"
source [file join $env(DOCUMENT_ROOT) config/easymodes/DIMMER_VIRTUAL_RECEIVER/MULTI_MODE_INPUT_TRANSMITTER_$mode.tcl]
