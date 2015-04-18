#!/bin/tclsh

# dev_descr(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)

global env dev_descr internalKey 

set internalKey 1

set addr $dev_descr(ADDRESS)

puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"SWITCH-$addr\">" 
puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"SWITCH\">" 
	
source [file join $env(DOCUMENT_ROOT) config/easymodes/SWITCH/SWITCH.tcl]  


