#!/bin/tclsh

# dev_descr_sender(TYPE) enthaelt den Sendertype (KEY, WATERDETECTIONSENSOR usw.)

global url dev_descr_receiver dev_descr_sender receiver_address

set multilingual 1
set internal ""
set ACTOR $dev_descr_receiver(TYPE) 


# Get the mode of the device

set addrMaintenance "[lindex [split $receiver_address :] 0]:0"

array set dev_ps [xmlrpc $url getParamset $addrMaintenance MASTER]
set devMode $dev_ps(DEVICE_OPERATION_MODE); # 0 = RGBW, 1 = RGB, 2 = Tuneable White, 3 = PWM


# TODO Check if the mode is correct and set the var ACTOR accordingly


set dev_descr_receiver(ORIG_TYPE) $dev_descr_receiver(TYPE)

if {($devMode == 0) || ($devMode == 1)} {
  set ACTOR "UNIVERSAL_LIGHT_RECEIVER_RGB(W)"
  set dev_descr_receiver(TYPE) $ACTOR
}

if {$devMode == 2} {
  set ACTOR "UNIVERSAL_LIGHT_RECEIVER_TW"
  set dev_descr_receiver(TYPE) $ACTOR
}

if {$devMode == 3} {
  set ACTOR "UNIVERSAL_LIGHT_RECEIVER_PWM"
  set dev_descr_receiver(TYPE) $ACTOR
}


if {[catch {set x $dev_descr_sender(TYPE)}] == 0} {

  if {$dev_descr_sender(TYPE) == "KEY_TRANSCEIVER"} {
    if {$dev_descr_sender(PARENT_TYPE) == "HmIP-MOD-RC8"} {
      global sender_address
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

  catch {puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$dev_descr_sender(PARENT)\">"}
  catch {puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"$ACTOR\">"}

  append x $internal
  if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$x.tcl]}] != 0} {
    catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
  }

} else {
  
  if {[catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/$ACTOR/$dev_descr_sender_tmp.tcl]}] != 0} {
    catch {source [file join $env(DOCUMENT_ROOT) config/easymodes/NO_PROFILE.tcl]}
  }
}


