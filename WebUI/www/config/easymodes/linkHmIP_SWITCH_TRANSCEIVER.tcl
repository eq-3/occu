#!/bin/tclsh


global dev_descr_receiver dev_descr_sender 

set multilingual 1

# Introduced with the HmIP-FLC
# This channel type is a SWITCH_TRANSCEIVER but it acts the same way as a SWITCH_VIRTUAL_RECEIVER. So we are using this.
set ACTOR SWITCH_VIRTUAL_RECEIVER

set dev_descr_receiver(TYPE) $ACTOR


if {[catch {set x $dev_descr_sender(TYPE)}] == 0} {

  if {$dev_descr_sender(TYPE) == "KEY_TRANSCEIVER"} {
    if {$dev_descr_sender(PARENT_TYPE) == "HmIP-MOD-RC8"} {
      global url sender_address
      # Get mode of the channel
      array set dev_ps [xmlrpc $url getParamset $sender_address MASTER]
      set mode $dev_ps(CHANNEL_OPERATION_MODE)
      if {$mode == 2} {
        set x "SWITCH_TRANSCEIVER"
        set dev_descr_sender(TYPE) $x
      }

      if {$mode == 3} {
        set x "SHUTTER_CONTACT"
        set dev_descr_sender(TYPE) $x
      }
    }
  }

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

  if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$x.tcl]}] != 0} {
    catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
  }

} else {
  
  if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$dev_descr_sender_tmp.tcl]}] != 0} {
    catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
  }
}


