#!/bin/tclsh

# dev_descr(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)
cgi_debug -on
global env dev_descr internalKey 

set internalKey 1

set addr $dev_descr(ADDRESS)

puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"JALOUSIE-$addr\">"
puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"JALOUSIE\">"
	
source [file join $env(DOCUMENT_ROOT) config/easymodes/JALOUSIE/JALOUSIE.tcl]


