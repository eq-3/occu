#!/bin/tclsh

# dev_descr_sender(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)

global url dev_descr_receiver dev_descr_sender hmw 

set multilingual 1

set ACTOR "HMW_" 
append ACTOR $dev_descr_receiver(TYPE) 

# den Status (Schalter oder Taster) setzen 
# 0 = Schalter, 1 = Taster

if {[catch {set type $hmw(INPUT_TYPE)}] != 0} {
	set type 1
}

catch {puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)_$type-$dev_descr_sender(PARENT)\">"} 
catch {puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"$ACTOR\">"} 

if {[catch {set x $dev_descr_sender(TYPE)}] == 0} {
	
	if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$x\_$type.tcl]}] != 0} {
		catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
	}

} else {
	
	if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$dev_descr_sender_tmp.tcl]}] != 0} {
		catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
	}
}


