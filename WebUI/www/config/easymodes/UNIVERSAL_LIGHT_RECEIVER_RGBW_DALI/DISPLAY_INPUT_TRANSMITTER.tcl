#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_RGBW_DALI/profiles.tcl]
# source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_RGBW_DALI/profilesTunableWhite.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_RGBW_DALI/getColorTempElement.tcl]

source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_RGBW_DALI/getColorElement.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${dimmer_on_brighter}"
set PROFILES_MAP(2)  "\${dimmer_off_darker}"
set PROFILES_MAP(3)  "\${dimmer_on_off_b_d}"
set PROFILES_MAP(4)  "\${color_up}"
set PROFILES_MAP(5)  "\${color_down}"
set PROFILES_MAP(6)  "\${color_up_down}"
set PROFILES_MAP(7)  "\${saturation_up}"
set PROFILES_MAP(8)  "\${saturation_down}"
set PROFILES_MAP(9)  "\${saturation_up_down}"

# Tunable White
set PROFILES_MAP(10)  "\${TW_dimmer_on_brighter}"
set PROFILES_MAP(11)  "\${TW_dimmer_off_darker}"
set PROFILES_MAP(12)  "\${TW_dimmer_on_off_b_d}"
set PROFILES_MAP(13)  "\${TW_colortemp_up}"
set PROFILES_MAP(14)  "\${TW_colortemp_down}"
set PROFILES_MAP(15)  "\${TW_colortemp_up_down}"
set PROFILES_MAP(16)  "\${TW_hcl_on_up}"
set PROFILES_MAP(17)  "\${TW_hcl_off_down}"
set PROFILES_MAP(18)  "\${TW_hcl_on_of_up_down}"
set PROFILES_MAP(19)  "\${TW_dim2warm_on_up}"
set PROFILES_MAP(20)  "\${TW_dim2warm_off_down}"
set PROFILES_MAP(21)  "\${TW_dim2warm_on_of_up_down}"

# Effect
set PROFILES_MAP(22)  "\${Effect}"

set PROFILES_MAP(23)  "\${not_active}"




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

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global iface_url sender_address dev_descr_sender dev_descr_receiver UNIVERSAL_LIGHT_ACTOR

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
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorPicker ps SHORT]"

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3 "onchange='showHideParam(this.value, $prn);'"]
    set tmpPref $pref

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

    set param _LONG_OUTPUT_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
    }

    # profile 1
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
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
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_BLINK}</td><td>"
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
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
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

    set param _LONG_OUTPUT_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
    }

    # profile 2
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
      append HTML_PARAMS(separate_$prn) "},50);"

    append HTML_PARAMS(separate_$prn) "</script>"

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0
  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td><span class='hidden'>{HSV_COLOR}</span></td>"
    append HTML_PARAMS(separate_$prn) "[getColorPicker ps SHORT]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
  }

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_BLINK}</td><td>"
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
      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
      append HTML_PARAMS(separate_$prn) "},50);"

    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"


  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_RAMPTIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

set comment { Request from KB (developer)
  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"
}

set comment { Request from KB (developer)
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"
}

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
  }


  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps ON]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  if {$longKeypressAvailable} {

    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3 "onchange='showHideParam(this.value, $prn);'"]

    set tmpPref $pref

    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'>"
      append HTML_PARAMS(separate_$prn) "<td>\${DIM_INFINITIVE}</td>"

      append HTML_PARAMS(separate_$prn) "<td>"
        append HTML_PARAMS(separate_$prn) "<input type='checkbox' id='chkDimInfinitive_$prn' onchange='setLongDimMinMaxHue4(this, $prn, $pref)'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
        append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
          append HTML_PARAMS(separate_$prn) "var chkDimInfinitiveElm = jQuery('#chkDimInfinitive_$prn');"
          append HTML_PARAMS(separate_$prn) "if ($ps(LONG_DIM_MAX_HUE) == 360) \{chkDimInfinitiveElm.prop('checked', true);\}"
          append HTML_PARAMS(separate_$prn) "chkDimInfinitiveElm.change();"
        append HTML_PARAMS(separate_$prn) "},50);"
      append HTML_PARAMS(separate_$prn) "</script>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='SHORT_DIM_MIN_HUE' value='$ps(SHORT_DIM_MIN_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='SHORT_DIM_MAX_HUE' value='$ps(SHORT_DIM_MAX_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='LONG_DIM_MIN_HUE' value='$ps(LONG_DIM_MIN_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='LONG_DIM_MAX_HUE' value='$ps(LONG_DIM_MAX_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

    append HTML_PARAMS(separate_$prn) "</tr>"

set comment {
    set param LONG_DIM_STEP_HUE
    if {[info exists ps($param)] == 1} {
      incr pref
      array_clear param_descr
      array set param_descr $ps_descr($param)
      set min $param_descr(MIN)
      set max $param_descr(MAX)

      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'>"
      append HTML_PARAMS(separate_$prn) "<td>\${DIM_STEP}</td>"
      append HTML_PARAMS(separate_$prn) "<td><input type=\"text\"  id='separate_receiver_$prn\_$pref' name='$param' value=$ps($param) size='4' class='alignCenter' onblur=\"ProofAndSetValue(this.id, this.id, 0, 180, 1);\">&nbsp&nbsp;($min - $max)</td>"

      append HTML_PARAMS(separate_$prn)) "</tr>"
    }
}
    set param LONG_DIM_STEP_HUE
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option HUE_STEP
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP_HUE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP_HUE "onchange=\"ActivateFreeValue(\$('${special_input_id}_profiles'),$pref);\""]
      EnterFreeValue $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP_HUE
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 4
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"

      append HTML_PARAMS(separate_$prn) "initChkDimInfinitive = function(prn) {"
        append HTML_PARAMS(separate_$prn) "var dimMinHue = parseInt($ps(LONG_DIM_MIN_HUE)),"
        append HTML_PARAMS(separate_$prn) "dimMaxHue = parseInt($ps(LONG_DIM_MAX_HUE));"
        append HTML_PARAMS(separate_$prn) "if (dimMaxHue == 360) {"
          append HTML_PARAMS(separate_$prn) "jQuery('#chkDimInfinitive_$prn').prop('checked', true);"
        append HTML_PARAMS(separate_$prn) "} else {"
          append HTML_PARAMS(separate_$prn) "jQuery('#chkDimInfinitive_$prn').prop('checked', false);"
        append HTML_PARAMS(separate_$prn) "}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "setLongDimMinMaxHue4 = function(jChkBox, prn, pref) {"
        append HTML_PARAMS(separate_$prn) "var infiniteDimActive = jQuery(jChkBox).is(':checked'),"
        append HTML_PARAMS(separate_$prn) "selectedColorElm = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) - 1)),"
        append HTML_PARAMS(separate_$prn) "dimMinElmShort = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 1)),"
        append HTML_PARAMS(separate_$prn) "dimMaxElmShort = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 2)),"
        append HTML_PARAMS(separate_$prn) "dimMinElmLong = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 3)),"
        append HTML_PARAMS(separate_$prn) "dimMaxElmLong = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 4));"

        append HTML_PARAMS(separate_$prn) "if (infiniteDimActive) {"
          append HTML_PARAMS(separate_$prn) "dimMinElmLong.val('0');"
          append HTML_PARAMS(separate_$prn) "dimMaxElmLong.val('360');"
        append HTML_PARAMS(separate_$prn) "} else {"
          append HTML_PARAMS(separate_$prn) "dimMinElmLong.val('0');"
          append HTML_PARAMS(separate_$prn) "dimMaxElmLong.val(selectedColorElm.val());"
        append HTML_PARAMS(separate_$prn) "} "

      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
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

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_RAMPTIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps OFF]"
  append HTML_PARAMS(separate_$prn) "</tr>"


  if {$longKeypressAvailable} {

    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 4 "onchange='showHideParam(this.value, $prn);'"]

    set tmpPref $pref

    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'>"
      append HTML_PARAMS(separate_$prn) "<td>\${DIM_INFINITIVE}</td>"

      append HTML_PARAMS(separate_$prn) "<td>"
        append HTML_PARAMS(separate_$prn) "<input type='checkbox' id='chkDimInfinitive_$prn' onchange='setLongDimMinMaxHue5(this, $prn, $pref)'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
        append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
          append HTML_PARAMS(separate_$prn) "var chkDimInfinitiveElm = jQuery('#chkDimInfinitive_$prn');"
          append HTML_PARAMS(separate_$prn) "if ($ps(LONG_DIM_MIN_HUE) == 360) \{chkDimInfinitiveElm.prop('checked', true);\}"
          append HTML_PARAMS(separate_$prn) "chkDimInfinitiveElm.change();"
        append HTML_PARAMS(separate_$prn) "},50);"
      append HTML_PARAMS(separate_$prn) "</script>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='SHORT_DIM_MIN_HUE' value='$ps(SHORT_DIM_MIN_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='SHORT_DIM_MAX_HUE' value='$ps(SHORT_DIM_MAX_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='LONG_DIM_MIN_HUE' value='$ps(LONG_DIM_MIN_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='LONG_DIM_MAX_HUE' value='$ps(LONG_DIM_MAX_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

    append HTML_PARAMS(separate_$prn) "</tr>"

    set param LONG_DIM_STEP_HUE
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option HUE_STEP
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP_HUE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP_HUE "onchange=\"ActivateFreeValue(\$('${special_input_id}_profiles'),$pref);\""]
      EnterFreeValue $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP_HUE
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 5
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"

      append HTML_PARAMS(separate_$prn) "initChkDimInfinitive = function(prn) {"
        append HTML_PARAMS(separate_$prn) "var dimMinHue = parseInt($ps(LONG_DIM_MIN_HUE)),"
        append HTML_PARAMS(separate_$prn) "dimMaxHue = parseInt($ps(LONG_DIM_MAX_HUE));"
        append HTML_PARAMS(separate_$prn) "if (dimMaxHue == 360) {"
          append HTML_PARAMS(separate_$prn) "jQuery('#chkDimInfinitive_$prn').prop('checked', true);"
        append HTML_PARAMS(separate_$prn) "} else {"
          append HTML_PARAMS(separate_$prn) "jQuery('#chkDimInfinitive_$prn').prop('checked', false);"
        append HTML_PARAMS(separate_$prn) "}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "setLongDimMinMaxHue5 = function(jChkBox, prn, pref) {"
        append HTML_PARAMS(separate_$prn) "var infiniteDimActive = jQuery(jChkBox).is(':checked'),"
        append HTML_PARAMS(separate_$prn) "selectedColorElm = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) - 1)),"
        append HTML_PARAMS(separate_$prn) "dimMinElmShort = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 1)),"
        append HTML_PARAMS(separate_$prn) "dimMaxElmShort = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 2)),"
        append HTML_PARAMS(separate_$prn) "dimMinElmLong = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 3)),"
        append HTML_PARAMS(separate_$prn) "dimMaxElmLong = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 4));"

        append HTML_PARAMS(separate_$prn) "if (infiniteDimActive) {"
          append HTML_PARAMS(separate_$prn) "dimMinElmLong.val('360');"
          append HTML_PARAMS(separate_$prn) "dimMaxElmLong.val('0');"
        append HTML_PARAMS(separate_$prn) "} else {"
          append HTML_PARAMS(separate_$prn) "dimMinElmLong.val(selectedColorElm.val());"
          append HTML_PARAMS(separate_$prn) "dimMaxElmLong.val('359');"
        append HTML_PARAMS(separate_$prn) "} "

      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
      append HTML_PARAMS(separate_$prn) "},50);"


    append HTML_PARAMS(separate_$prn) "</script>"

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#6
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0
  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_RAMPTIME_ON ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps ON true]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
  }

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"


  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_RAMPTIME_OFF ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps OFF true]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  if {$longKeypressAvailable} {

    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 5 "onchange='showHideParam(this.value, $prn);'"]

    set tmpPref $pref

    append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'>"
      append HTML_PARAMS(separate_$prn) "<td>\${DIM_INFINITIVE}</td>"

      append HTML_PARAMS(separate_$prn) "<td>"
        append HTML_PARAMS(separate_$prn) "<input type='checkbox' id='chkDimInfinitive_$prn' onchange='setLongDimMinMaxHue6(this, $prn, $pref)'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
        append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
          append HTML_PARAMS(separate_$prn) "var chkDimInfinitiveElm = jQuery('#chkDimInfinitive_$prn');"
          append HTML_PARAMS(separate_$prn) "if (($ps(LONG_DIM_MIN_HUE) == 360) && ($ps(LONG_DIM_MAX_HUE) == 360)) \{chkDimInfinitiveElm.prop('checked', true);\}"
          append HTML_PARAMS(separate_$prn) "chkDimInfinitiveElm.change();"
        append HTML_PARAMS(separate_$prn) "},50);"
      append HTML_PARAMS(separate_$prn) "</script>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='SHORT_DIM_MIN_HUE' value='$ps(SHORT_DIM_MIN_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='SHORT_DIM_MAX_HUE' value='$ps(SHORT_DIM_MAX_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='LONG_DIM_MIN_HUE' value='$ps(LONG_DIM_MIN_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

      incr pref
      append HTML_PARAMS(separate_$prn) "<td class='hidden'>"
        append HTML_PARAMS(separate_$prn) "<input type='text' id='separate_receiver_$prn\_$pref' name='LONG_DIM_MAX_HUE' value='$ps(LONG_DIM_MAX_HUE)' size='4'>"
      append HTML_PARAMS(separate_$prn) "</td>"

    append HTML_PARAMS(separate_$prn) "</tr>"

    set param LONG_DIM_STEP_HUE
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option HUE_STEP
      append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_STEP_HUE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_STEP_HUE "onchange=\"ActivateFreeValue(\$('${special_input_id}_profiles'),$pref);\""]
      EnterFreeValue $prn $pref ${special_input_id} ps_descr LONG_DIM_STEP_HUE
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    # profile 6
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"

      append HTML_PARAMS(separate_$prn) "initChkDimInfinitive = function(prn) {"
        append HTML_PARAMS(separate_$prn) "var dimMinHue = parseInt($ps(LONG_DIM_MIN_HUE)),"
        append HTML_PARAMS(separate_$prn) "dimMaxHue = parseInt($ps(LONG_DIM_MAX_HUE));"
        append HTML_PARAMS(separate_$prn) "if (dimMaxHue == 360) {"
          append HTML_PARAMS(separate_$prn) "jQuery('#chkDimInfinitive_$prn').prop('checked', true);"
        append HTML_PARAMS(separate_$prn) "} else {"
          append HTML_PARAMS(separate_$prn) "jQuery('#chkDimInfinitive_$prn').prop('checked', false);"
        append HTML_PARAMS(separate_$prn) "}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "setLongDimMinMaxHue6 = function(jChkBox, prn, pref) {"
        append HTML_PARAMS(separate_$prn) "var infiniteDimActive = jQuery(jChkBox).is(':checked'),"
        append HTML_PARAMS(separate_$prn) "selectedColorElmON = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) - 6)),"
        append HTML_PARAMS(separate_$prn) "selectedColorElmOFF = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) - 1)),"
        append HTML_PARAMS(separate_$prn) "dimMinElmShort = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 1)),"
        append HTML_PARAMS(separate_$prn) "dimMaxElmShort = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 2)),"
        append HTML_PARAMS(separate_$prn) "dimMinElmLong = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 3)),"
        append HTML_PARAMS(separate_$prn) "dimMaxElmLong = jQuery('#separate_receiver_' + prn + '_' + (parseInt(pref) + 4));"

        append HTML_PARAMS(separate_$prn) "if (infiniteDimActive) {"
          append HTML_PARAMS(separate_$prn) "dimMinElmLong.val('360');"
          append HTML_PARAMS(separate_$prn) "dimMaxElmLong.val('360');"
        append HTML_PARAMS(separate_$prn) "} else {"
          append HTML_PARAMS(separate_$prn) "dimMinElmLong.val(selectedColorElmOFF.val());"
          append HTML_PARAMS(separate_$prn) "dimMaxElmLong.val(selectedColorElmON.val());"
        append HTML_PARAMS(separate_$prn) "} "

      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
      append HTML_PARAMS(separate_$prn) "},50);"


    append HTML_PARAMS(separate_$prn) "</script>"

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#7
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector SATURATION_CHANGE_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"


  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_DELAY ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  # append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$longKeypressAvailable} {

    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3 "onchange='showHideParam(this.value, $prn);'"]

    set tmpPref $pref

    set param LONG_DIM_MAX_SATURATION
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${SATURATION_MAX_LEVEL}</td><td>"
      option DIM_STEPwoLastValue_5-100
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    set param LONG_DIM_STEP_SATURATION
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        # append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
      append HTML_PARAMS(separate_$prn) "},50);"


    append HTML_PARAMS(separate_$prn) "</script>"

  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#8
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector SATURATION_CHANGE_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"


  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_OFFTIME_CHANGE_DELAY ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  # OFF_TIME
  # append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_OFF_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$longKeypressAvailable} {


    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 4 "onchange='showHideParam(this.value, $prn);'"]

    set tmpPref $pref

    set param LONG_DIM_MIN_SATURATION
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${SATURATION_MIN_LEVEL}</td><td>"
      option DIM_OFFLEVELwoLastValue
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    set param LONG_DIM_STEP_SATURATION
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    set param _LONG_OUTPUT_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
    }

    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        # append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
      append HTML_PARAMS(separate_$prn) "},50);"


    append HTML_PARAMS(separate_$prn) "</script>"

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#9
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_ON_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_OFF_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_OFF_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  if {$longKeypressAvailable} {
    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 5 "onchange='showHideParam(this.value, $prn);'"]

    set tmpPref $pref

    set param LONG_DIM_MIN_SATURATION
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${SATURATION_MIN_LEVEL}</td><td>"
      option DIM_OFFLEVELwoLastValue
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    set param LONG_DIM_MAX_SATURATION
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${SATURATION_MAX_LEVEL}</td><td>"
      option DIM_STEPwoLastValue_5-100
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    set param LONG_DIM_STEP_SATURATION
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) "<tr name='trLongParam_$prn' class='hidden'><td>\${DIM_STEP}</td><td>"
      option DIM_STEPwoLastValue_5-90
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
    }

    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "showHideParam = function(val, prn) {"
        append HTML_PARAMS(separate_$prn) "longParamElm = jQuery(\"\[name='trLongParam_\"+prn+\"'\]\");"
        append HTML_PARAMS(separate_$prn) "if (parseInt(val) > 0) {"
          append HTML_PARAMS(separate_$prn) "longParamElm.show();"
        append HTML_PARAMS(separate_$prn) "} else {longParamElm.hide();}"
      append HTML_PARAMS(separate_$prn) "};"

      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
        # append HTML_PARAMS(separate_$prn) "initChkDimInfinitive($prn);"
      append HTML_PARAMS(separate_$prn) "},50);"


    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  # Here comes the Tunable White Mode (DALI)
  #10
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

#12
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

#13
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

#14
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_COLOR_TEMP_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  # SHORT/LONG_OFF_COLOR_TEMPERATURE
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

#15
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

#16
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


#17
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

#18
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

#19
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

#20
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

#21
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
    # profile 21
    append HTML_PARAMS(separate_$prn) "<script type='text/javascript'>"
      append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {"
        append HTML_PARAMS(separate_$prn) "jQuery('#separate_receiver_$prn\_$tmpPref').change();"
      append HTML_PARAMS(separate_$prn) "},50);"
    append HTML_PARAMS(separate_$prn) "</script>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  # 22 Effect
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
              append HTML_PARAMS(separate_$prn) "if ((effectName == \"\") || (effectName == \"null\")) {effectName = translateKey(\"lblEffect\") + " " + index;}"
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

  #23
    incr prn
    if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
    append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
    append HTML_PARAMS(separate_$prn) "\${description_notActive}"
    append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

    append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
