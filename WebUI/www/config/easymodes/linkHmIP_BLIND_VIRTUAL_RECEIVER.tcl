#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]

global dev_descr_receiver dev_descr_sender url

set multilingual 1
set internal ""

array set dev_descr [xmlrpc $url getDeviceDescription [list string [lindex [split $dev_descr_receiver(ADDRESS) :] 0]]]

# Firmware = x.y.z
# devFwMajor = x
set Fw $dev_descr(FIRMWARE)
set devFwMajor [expr [lindex [split $Fw .] 0] * 1]
set devFwMinor [expr [lindex [split $Fw .] 1] * 1]

set fwVersionOk 0
# Fw. >= 1.6
if {($devFwMajor > 1) || ($devFwMajor == 1 && $devFwMinor > 5)} {
  set fwVersionOk 1
}

# Check the mode of a wired blind (shutter or blind)
# Determine the current channelMode
set chnMode [xmlrpc $url getMetadata [list string $dev_descr_receiver(ADDRESS)] channelMode]

if {($fwVersionOk == 1) && ( ([string equal [lindex [split $dev_descr_receiver(PARENT_TYPE) -] 0] HmIPW] == 1) || ([string equal $dev_descr_receiver(PARENT_TYPE) HmIP-DRBLI4] == 1) )} {
  if {[string equal $chnMode ""] == 1 || [string equal $chnMode "shutter"] == 1} {
    set dev_descr_receiver(TYPE) "SHUTTER_VIRTUAL_RECEIVER"
  } else {
    set dev_descr_receiver(TYPE) "BLIND_VIRTUAL_RECEIVER"
  }
}

set ACTOR $dev_descr_receiver(TYPE)


# Sender and receiver are the same device which means this is a internal device button
if {$dev_descr_sender(PARENT) == $dev_descr_receiver(PARENT)} {
  # set internal "_INTERNAL"
}

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


