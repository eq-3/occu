#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_TW/profiles.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_TW/getColorTempElement.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${dimmer_on_brighter}"
set PROFILES_MAP(2)  "\${dimmer_off_darker}"
set PROFILES_MAP(3)  "\${dimmer_on_off_b_d}"
set PROFILES_MAP(4)  "\${colortemp_up}"
set PROFILES_MAP(5)  "\${colortemp_down}"
set PROFILES_MAP(6)  "\${colortemp_up_down}"
set PROFILES_MAP(7)  "\${hcl_on_up}"
set PROFILES_MAP(8)  "\${hcl_off_down}"
set PROFILES_MAP(9)  "\${hcl_on_of_up_down}"
set PROFILES_MAP(10)  "\${dim2warm_on_up}"
set PROFILES_MAP(11)  "\${dim2warm_off_down}"
set PROFILES_MAP(12)  "\${dim2warm_on_of_up_down}"

# Effect
set PROFILES_MAP(13)  "\${Effect}"

set PROFILES_MAP(14)  "\${not_active}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"


proc getDescription {longAvailable prn} {
  if {$longAvailable} {
    return "\${description_$prn}"
  } else {
    return "\${description_noLong_$prn}"
  }
}

puts "<script type='text/javascript'>"
  puts "showHideParam = function(val, prn) {"
    puts "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
    puts "if (parseInt(val) > 0) {"
      puts "longParamElm.show();"
    puts "} else {longParamElm.hide();}"
  puts "};"
puts "</script>"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url sender_address dev_descr_sender dev_descr_receiver

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set url $iface_url($iface)

  set device $dev_descr_sender(TYPE)
  set ch $dev_descr_sender(INDEX)

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }

  set longKeypressAvailable [isLongKeypressAvailable $dev_descr_sender(PARENT_TYPE) $sender_address $url]

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

# die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/ic_effects.js');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"


  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # SHORT/LONG_ON_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorTempSlider ps SHORT ON]"

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # ON_TIME
    set extraParam "name='trLongParam_$prn' class='hidden'"
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG $extraParam]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 1
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"

    append HTML_PARAMS(separate_$prn) "</script>"

  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class='hidden'><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK|LONG_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

    set param _SHORT_OPTICAL_SIGNAL_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 4 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MIN_LEVEL}</td><td>"

    incr pref
    option DIM_OFFLEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 2
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # SHORT/LONG_ON_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorTempSlider ps SHORT ON]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class='hidden'><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  if {$longKeypressAvailable} {
    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 5 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # ON_TIME
    set extraParam "name='trLongParam_$prn' class='hidden'"
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG $extraParam]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MIN_LEVEL}</td><td>"
    option DIM_OFFLEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 3
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_COLOR_TEMP_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # SHORT/LONG_ON_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorTempSlider ps SHORT ON]"

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # LONG_DIM_MAX_COLOR_TEMPERATURE
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
      append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps LONG MAX]"
    append HTML_PARAMS(separate_$prn) "</tr>"

    set param LONG_DIM_STEP_COLOR_TEMPERATURE
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option COLOR_TEMPERATURE_STEP
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP_COLOR_TEMPERATURE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP_COLOR_TEMPERATURE "onchange=\"ActivateFreeValue(\$('${special_input_id}_profiles'),$pref);\""]
      EnterFreeValue $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP_COLOR_TEMPERATURE "K"
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 4
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_COLOR_TEMP_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  # SHORT/LONG_ON_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorTempSlider ps SHORT OFF]"

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 4 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # LONG_DIM_MIN_COLOR_TEMPERATURE
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
      append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps LONG MIN]"
    append HTML_PARAMS(separate_$prn) "</tr>"

    set param LONG_DIM_STEP_COLOR_TEMPERATURE
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option COLOR_TEMPERATURE_STEP
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP_COLOR_TEMPERATURE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP_COLOR_TEMPERATURE "onchange=\"ActivateFreeValue(\$('${special_input_id}_profiles'),$pref);\""]
      EnterFreeValue $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP_COLOR_TEMPERATURE K
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 5
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#6
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_ON_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # SHORT/LONG_ON_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorTempSlider ps SHORT ON ON]"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_OFF_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  # SHORT/LONG_ON_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorTempSlider ps SHORT OFF OFF]"

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 5 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # LONG_DIM_MIN_COLOR_TEMPERATURE
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
      append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps LONG MIN]"
    append HTML_PARAMS(separate_$prn) "</tr>"

    # LONG_DIM_MAX_COLOR_TEMPERATURE
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
      append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps LONG MAX]"
    append HTML_PARAMS(separate_$prn) "</tr>"

    set param LONG_DIM_STEP_COLOR_TEMPERATURE
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option COLOR_TEMPERATURE_STEP
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP_COLOR_TEMPERATURE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP_COLOR_TEMPERATURE "onchange=\"ActivateFreeValue(\$('${special_input_id}_profiles'),$pref);\""]
      EnterFreeValue $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP_COLOR_TEMPERATURE K
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 6
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"

  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#7
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # LONG_DIM_MIN_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MIN]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  # LONG_DIM_MAX_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MAX]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"


  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # ON_TIME
    set extraParam "name='trLongParam_$prn' class='hidden'"
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG $extraParam]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 7
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"

  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#8
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # LONG_DIM_MIN_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MIN]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  # LONG_DIM_MAX_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MAX]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class='hidden'><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK|LONG_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

    set param _SHORT_OPTICAL_SIGNAL_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 4 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MIN_LEVEL}</td><td>"

    incr pref
    option DIM_OFFLEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 8
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#9
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"


  # LONG_DIM_MIN_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MIN]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  # LONG_DIM_MAX_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MAX]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"


  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class='hidden'><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"


  if {$longKeypressAvailable} {    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 5 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # ON_TIME
    set extraParam "name='trLongParam_$prn' class='hidden'"
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG $extraParam]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MIN_LEVEL}</td><td>"
    option DIM_OFFLEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }
    # profile 9
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#10
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # LONG_DIM_MIN_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MIN]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  # LONG_DIM_MAX_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MAX]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"


  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"


  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # ON_TIME
    set extraParam "name='trLongParam_$prn' class='hidden'"
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG $extraParam]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 10
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#11
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # LONG_DIM_MIN_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MIN]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  # LONG_DIM_MAX_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MAX]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"


  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class='hidden'><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK|LONG_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

    set param _SHORT_OPTICAL_SIGNAL_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 4 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MIN_LEVEL}</td><td>"

    incr pref
    option DIM_OFFLEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 11
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#12
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # LONG_DIM_MIN_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MIN_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MIN]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  # LONG_DIM_MAX_COLOR_TEMPERATURE
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td><span>\${MAX_COLOR_TEMP}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorTempSliderMinMax ps SHORT_LONG MAX]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"


  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class='hidden' ><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  if {$longKeypressAvailable} {
    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 5 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

    # ON_TIME
    set extraParam "name='trLongParam_$prn' class='hidden'"
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG $extraParam]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_MIN_LEVEL}</td><td>"
    option DIM_OFFLEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_DIM_STEP
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }
    # profile 12
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  # 13 Effect
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
    append HTML_PARAMS(separate_$prn) "\${description_$prn}"
    # append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
    append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr>"
        append HTML_PARAMS(separate_$prn) "<td id='lblEffect'>\${OUTPUT_BEHAVIOUR_effect}</td>"
        append HTML_PARAMS(separate_$prn) "<td>"
          # option DALI_EFFECTS
          array_clear options
          set options(0) "\${optionNoEffect}"
          for {set effect 1} {$effect <= 19} {set effect [expr $effect + 2]} {
            set options($effect) ""
          }
         # append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OUTPUT_BEHAVIOUR|LONG_OUTPUT_BEHAVIOUR separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OUTPUT_BEHAVIOUR "onchange=\"stopEffect(this, $prn, $pref);\""]
          append HTML_PARAMS(separate_$prn) [get_ComboBox options dummy effect_$prn\_$pref PROFILE_$prn SHORT_OUTPUT_BEHAVIOUR "onchange=\"setSelectedEffect(this); stopEffect(this, $prn, $pref);\""]
        append HTML_PARAMS(separate_$prn) "</td>"

        append HTML_PARAMS(separate_$prn) "<td>"

          append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_${special_input_id}_$prn\_$pref' name='SHORT_OUTPUT_BEHAVIOUR|LONG_OUTPUT_BEHAVIOUR' class='$ps(SHORT_OUTPUT_BEHAVIOUR) hidden' value='$ps(SHORT_OUTPUT_BEHAVIOUR)'>"

        append HTML_PARAMS(separate_$prn) "</td>"

      append HTML_PARAMS(separate_$prn) "</tr>"

      append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
          set prefEffect $pref
          append HTML_PARAMS(separate_$prn) "var effectOptionElm = jQuery(\"#lblEffect\").next().children().first(),"
          append HTML_PARAMS(separate_$prn) "effectOptions = jQuery('#' + effectOptionElm.prop('id') + ' option'),"
          append HTML_PARAMS(separate_$prn) "oDevice = DeviceList.getDeviceByAddress('$dev_descr_receiver(PARENT)'),"
          append HTML_PARAMS(separate_$prn) "oChannel = DeviceList.getChannelByAddress('$address'),"
          append HTML_PARAMS(separate_$prn) "effectName = '';"

          append HTML_PARAMS(separate_$prn) "curEffect = parseInt(jQuery('\#separate_receiver_$prn\_$pref').val()),"
          append HTML_PARAMS(separate_$prn) "effectModeLink = ((curEffect != 0) && ((curEffect % 2) == 0)) ? true : false;"

          append HTML_PARAMS(separate_$prn) "if (curEffect == 0) \{"
            append HTML_PARAMS(separate_$prn) "jQuery(\"\#trOnLevel_$prn\").hide();"
            append HTML_PARAMS(separate_$prn) "jQuery(\"\#trEffectMode_$prn\").hide();"
          append HTML_PARAMS(separate_$prn) "\}"

          append HTML_PARAMS(separate_$prn) "if (effectModeLink) \{"
            append HTML_PARAMS(separate_$prn) "var optionValue = (curEffect - 1);"
            append HTML_PARAMS(separate_$prn) "effectOptionElm.find('option\[value='+optionValue+'\]').attr('selected', 'selected').prop('class',optionValue);"
          append HTML_PARAMS(separate_$prn) "\}"

          append HTML_PARAMS(separate_$prn) "jQuery.each(effectOptions, function(index, option) {"
            append HTML_PARAMS(separate_$prn) "if (index > 0) {"
              append HTML_PARAMS(separate_$prn) "effectName = homematic(\"Interface.getMetadata\", \{'objectId' : oDevice.id, 'dataId': 'effectName_' + index\});"
              append HTML_PARAMS(separate_$prn) "if ((effectName == \"\") || (effectName == \"null\")) {effectName = translateKey(\"lblEffect\") + \" \" + index;}"
              append HTML_PARAMS(separate_$prn) "jQuery(effectOptions\[index\]).text(effectName);"
            append HTML_PARAMS(separate_$prn) "}"
          append HTML_PARAMS(separate_$prn) "});"

          append HTML_PARAMS(separate_$prn) "setEffectModeLink = function(elm, prn, pref) \{"
            append HTML_PARAMS(separate_$prn) "var val2SendElm = jQuery('\#separate_receiver_$prn\_$pref'),"
            append HTML_PARAMS(separate_$prn) " effectModeLink = (jQuery(elm).is(':checked')) ? true : false;"

            append HTML_PARAMS(separate_$prn) "if (effectModeLink) \{"
              append HTML_PARAMS(separate_$prn) "val2SendElm.val(parseInt(val2SendElm.val()) + 1);"
            append HTML_PARAMS(separate_$prn) "\} else \{"
              append HTML_PARAMS(separate_$prn) "val2SendElm.val(parseInt(val2SendElm.val()) - 1);"
            append HTML_PARAMS(separate_$prn) "\}"

          append HTML_PARAMS(separate_$prn) "\};"

          append HTML_PARAMS(separate_$prn) "setSelectedEffect = function(elm) \{"
            append HTML_PARAMS(separate_$prn) "var oChannel = DeviceList.getChannelByAddress('$address');"
            append HTML_PARAMS(separate_$prn) "jQuery(elm).parent().next().children().first().val(elm.value);"
            append HTML_PARAMS(separate_$prn) "jQuery('\#chkBoxEffectModeLink_$prn').prop('checked', false);"
            append HTML_PARAMS(separate_$prn) "homematic('Interface.setMetadata', {'objectId': oChannel.id, 'dataId': 'effectModeLink', 'value': 'false'});"
          append HTML_PARAMS(separate_$prn) "\};"

          append HTML_PARAMS(separate_$prn) "var effectElm = jQuery(\"#separate_receiver_$prn\_$pref\");"
          append HTML_PARAMS(separate_$prn) "stopEffect = function(effectElm, prn, pref) \{"
            append HTML_PARAMS(separate_$prn) "var levelElm = jQuery(\"#separate_receiver_\"+prn+\"_\"+(parseInt(pref) + 1)),"
            append HTML_PARAMS(separate_$prn) "trLevel = jQuery(\"\#trOnLevel_\"+ prn),"
            append HTML_PARAMS(separate_$prn) "trEffectMode = jQuery(\"\#trEffectMode_\"+ prn);"

            append HTML_PARAMS(separate_$prn) "if (jQuery(effectElm).val() == '0') \{;"
              append HTML_PARAMS(separate_$prn) "trLevel.hide();"
              append HTML_PARAMS(separate_$prn) "trEffectMode.hide();"
              append HTML_PARAMS(separate_$prn) "levelElm.val('0.0');"
            append HTML_PARAMS(separate_$prn) "\} else \{"
              append HTML_PARAMS(separate_$prn) "trLevel.show();"
              append HTML_PARAMS(separate_$prn) "trEffectMode.show();"
              append HTML_PARAMS(separate_$prn) "levelElm.val('1.0');"
            append HTML_PARAMS(separate_$prn) "\}"
          append HTML_PARAMS(separate_$prn) "\};"

          append HTML_PARAMS(separate_$prn) "effectElm.change();"
      append HTML_PARAMS(separate_$prn) "</script>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<tr id='trOnLevel_$prn'><td>\${ON_LEVEL_EFFECT}</td><td>"
      option DIM_0-100
      append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
      append HTML_PARAMS(separate_$prn) "</td></tr>"

      append HTML_PARAMS(separate_$prn) "<tr id='trEffectMode_$prn'>"
        append HTML_PARAMS(separate_$prn) "<td>"
          append HTML_PARAMS(separate_$prn) "<div style='width:200px;'>\${lblResorePreviousStatus}</div>"
        append HTML_PARAMS(separate_$prn) "</td>"
        append HTML_PARAMS(separate_$prn) "<td>"
          append HTML_PARAMS(separate_$prn) "<input type='checkbox' id='chkBoxEffectModeLink_$prn' onchange='setEffectModeLink(this, $prn, $pref)'>"
        append HTML_PARAMS(separate_$prn) "</td>"
      append HTML_PARAMS(separate_$prn) "</tr>"

      append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"

        append HTML_PARAMS(separate_$prn) "var oChannel = DeviceList.getChannelByAddress('$address'),"
        append HTML_PARAMS(separate_$prn) "curEffect = parseInt(jQuery('\#separate_receiver_$prn\_$prefEffect').val()),"
        append HTML_PARAMS(separate_$prn) "effectModeLink = ((curEffect != 0) && ((curEffect % 2) == 0)) ? true : false,"
        append HTML_PARAMS(separate_$prn) "chkBoxEffectModeLinkElm = jQuery('\#chkBoxEffectModeLink_$prn');"

        append HTML_PARAMS(separate_$prn) "chkBoxEffectModeLinkElm.attr('checked', effectModeLink);"
        append HTML_PARAMS(separate_$prn) "homematic('Interface.setMetadata', {'objectId': oChannel.id, 'dataId': 'effectModeLink', 'value': effectModeLink});"

      append HTML_PARAMS(separate_$prn) "</script>"

    append HTML_PARAMS(separate_$prn) "</table>"

  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#14
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
