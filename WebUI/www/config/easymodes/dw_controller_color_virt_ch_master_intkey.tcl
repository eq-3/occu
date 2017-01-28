#!/bin/tclsh

# dev_descr(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)

global env dev_descr internalKey

set internalKey 1

set addr $dev_descr(ADDRESS)

puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"VIRTUAL_DUAL_WHITE_COLOR-$addr\">"
puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"VIRTUAL_DUAL_WHITE_COLOR\">"

source [file join $env(DOCUMENT_ROOT) config/easymodes/VIRTUAL_DUAL_WHITE_COLOR/VIRTUAL_DUAL_WHITE_COLOR.tcl]
