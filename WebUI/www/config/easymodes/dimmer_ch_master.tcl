#!/bin/tclsh

# dev_descr(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)

proc isLongKeyPressAvailable {} {
  global dev_descr
  set dimmerType [lindex [split $dev_descr(TYPE) "-"] 2]
  set devFw $dev_descr(FIRMWARE)
  set longKeyPressAvailable 1
   
  #minimum firmwareversion 
  if {[string match -nocase Dim?L $dimmerType] == 1} {
    # Anschnittdimmer beherrschen ab Fw. 2.0 den langen Tastendruck
    set minFw  "2.0"
    if {[expr $devFw * 1] < [expr $minFw * 1]} {
      set longKeyPressAvailable 0
    }
  } elseif {[string match -nocase Dim?T $dimmerType] == 1} {
    # Abschnittdimmer beherrschen ab Fw. 0.8 den langen Tastendruck
    set minFw "0.8"
    if { [expr $devFw * 1]  < [expr $minFw * 1] } {
      set longKeyPressAvailable 0
    }
  }
  return $longKeyPressAvailable
}

global env dev_descr internalKey iface iface_url

set internalKey 1
set longKeyPressAvailable 0
set addr $dev_descr(ADDRESS)

## array set paramSet [xmlrpc $iface_url($iface) getParamset [list string $addr] [list string MASTER]]

# check if long keypress is available
## catch {set longKeyPressAvailable $paramSet(CONF_BUTTON_TIME)}


#puts "longKeyPressAvailable: [isLongKeyPressAvailable]<br/>"

set longKeyPressAvailable [isLongKeyPressAvailable]
	
if {$longKeyPressAvailable == 1} { 
  puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"DIMMER-$addr\">" 
  puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"DIMMER\">" 
  source [file join $env(DOCUMENT_ROOT) config/easymodes/DIMMER/DIMMER.tcl]  
} else {
  # Dimmer without long keypress      
  puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"DIMMER_woLongKeyPress-$addr\">" 
  puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"DIMMER_woLongKeyPress\">" 
  source [file join $env(DOCUMENT_ROOT) config/easymodes/DIMMER_woLongKeyPress/DIMMER_woLongKeyPress.tcl]  
}

