#!/bin/tclsh

global url dev_descr_sender dev_descr_receiver

array set paramSet [xmlrpc $url getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
set mode $paramSet(CHANNEL_OPERATION_MODE)

puts "<script type=\"text/javascript\">mode_MULTI_MODE_INPUT_TRANSMITTER = $mode</script>"

if {($dev_descr_receiver(PARENT_TYPE) != "HmIP-FDC") || ($mode != 1)} {
  source [file join $env(DOCUMENT_ROOT) config/easymodes/SWITCH_VIRTUAL_RECEIVER/MULTI_MODE_INPUT_TRANSMITTER_$mode.tcl]
} else {
  source [file join $env(DOCUMENT_ROOT) config/easymodes/SWITCH_VIRTUAL_RECEIVER/MULTI_MODE_INPUT_TRANSMITTER_$mode\_FDC.tcl]
}