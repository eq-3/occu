#!/bin/tclsh

# dev_descr_sender(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)

global dev_descr_receiver dev_descr_sender 

set multilingual 1
set ACTOR $dev_descr_receiver(TYPE) 


  if {$dev_descr_sender(TYPE) == "LEVEL_COMMAND_TRANSMITTER_CO2"} {
    set x "COND_SWITCH_TRANSMITTER"
    set dev_descr_sender(TYPE) $x
  }

  if {$dev_descr_sender(TYPE) == "LEVEL_COMMAND_TRANSMITTER_HUMIDITY"} {
    set x "COND_SWITCH_TRANSMITTER_HUMIDITY"
    set dev_descr_sender(TYPE) $x
  }

  if {$dev_descr_sender(TYPE) == "LEVEL_COMMAND_TRANSMITTER_TEMPERATURE"} {
    set x "COND_SWITCH_TRANSMITTER_TEMPERATURE"
    set dev_descr_sender(TYPE) $x
  }

catch {puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$dev_descr_sender(PARENT)\">"} 
catch {puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"$ACTOR\">"} 

if {[catch {set x $dev_descr_sender(TYPE)}] == 0} {
  
  if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$x.tcl]}] != 0} {
    catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
  }

} else {
  
  if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$dev_descr_sender_tmp.tcl]}] != 0} {
    catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
  }
}


