#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_RGB(W)/profiles.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/UNIVERSAL_LIGHT_RECEIVER_RGB(W)/getColorElement.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${dimmer_on}"
set PROFILES_MAP(2)  "\${dimmer_off}"
set PROFILES_MAP(3)  "\${dimmer_on_off}"
set PROFILES_MAP(4)  "\${color_a}"
set PROFILES_MAP(5)  "\${color_b}"
set PROFILES_MAP(6)  "\${color_a_b}"
set PROFILES_MAP(7)  "\${saturation_a}"
set PROFILES_MAP(8)  "\${saturation_b}"
set PROFILES_MAP(9)  "\${saturation_a_b}"

# Effect
set PROFILES_MAP(10)  "\${Effect}"

set PROFILES_MAP(11)  "\${not_active}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

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

  set longKeypressAvailable 0

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
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  append HTML_PARAMS(separate_$prn) "[getColorPicker ps SHORT]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#2
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
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

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0
  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
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

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
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
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
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
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps ON "" A]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_RAMPTIME ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps OFF "" B]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#6
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0
  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector COLOR_CHANGE_RAMPTIME_ON ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps ON true A]"
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
    append HTML_PARAMS(separate_$prn) "[getHueSlider ps OFF true B]"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#7
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector SATURATION_CHANGE_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"


  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_DELAY ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  # append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_ON_LEVEL_A}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#8
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector SATURATION_CHANGE_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"


  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_OFFTIME_CHANGE_DELAY ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  # OFF_TIME
  # append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_OFF_LEVEL_A}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param _SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectEffectElement PROFILE_$prn ${special_input_id} $param]
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#9
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_ON_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_ON_LEVEL_A}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_DELAY ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMP_ONTIME_CHANGE_OFF_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SATURATION_OFF_LEVEL_A}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_SATURATION separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_SATURATION "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_SATURATION
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


  # 10 Effect
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
      append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
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

#11
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
