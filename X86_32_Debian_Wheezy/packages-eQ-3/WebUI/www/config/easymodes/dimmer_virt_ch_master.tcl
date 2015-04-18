#!/bin/tclsh

# dev_descr(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)

global env dev_descr internalKey

set internalKey 1

set addr $dev_descr(ADDRESS)

puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"VIRTUAL_DIMMER-$addr\">" 
puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"VIRTUAL_DIMMER\">" 
	
source [file join $env(DOCUMENT_ROOT) config/easymodes/VIRTUAL_DIMMER/VIRTUAL_DIMMER.tcl]  


