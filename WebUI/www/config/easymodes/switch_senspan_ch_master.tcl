#!/bin/tclsh

#Kanal-EasyMode!

source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join /www/config/easymodes/em_common.tcl]

proc getComboBox {arOptions chn prn attrID} {
  upvar $arOptions options

  set s "<select id=$attrID onchange=\"calculateSoundID($chn);\">"
  foreach value [lsort -real [array names options]] {
    append s "<option value=$value>$options($value)</option>"
  }
  append s "</select>"
  return $s
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    psDescr

  upvar PROFILE_1     PROFILE_1
  set chn [lindex [split $special_input_id _] 1]

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_SEC_SIR_WM.js');</script>"


  # Available parameters
  #TRANSMIT_TRY_MAX
  #STATUSINFO_MINDELAY
  #STATUSINFO_RANDOM
  #SOUND_ID


  append HTML_PARAMS(separate_1) "<table id=\"table\_$chn\" class=\"ProfileTbl\">"

    set prn 1
    set param TRANSMIT_TRY_MAX
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableTransmitTryMax}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr prn
    set param STATUSINFO_MINDELAY
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableStatusInfoMinDelay}</td>"

      append HTML_PARAMS(separate_1) "<td>"
        append HTML_PARAMS(separate_1) "<select id=\"selectStatusInfoMinDelay_$chn\" onchange=\"setStatusInfoMinDelay($chn, $prn);\">"
          append HTML_PARAMS(separate_1) "<option value=\"0\">\${stringTableNotUsed}</option>"
          append HTML_PARAMS(separate_1) "<option value=\"1\">\${optionEnterValue}</option>"
        append HTML_PARAMS(separate_1) "</select>"
      append HTML_PARAMS(separate_1) "</td>"

      append HTML_PARAMS(separate_1) "<td id=\"enterStatusInfoMinDelay_$chn\" class=\"hidden\">[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"

      append HTML_PARAMS(separate_1) "initStatusInfoMinDelay = function(chn, elmNr) \{"
        append HTML_PARAMS(separate_1) "var enterStatusInfoElm = jQuery(\"#separate_CHANNEL_\"+chn+\"_\"+elmNr),"
        append HTML_PARAMS(separate_1) "tdStatusInfoElm = jQuery(\"#enterStatusInfoMinDelay_\"+chn),"
        append HTML_PARAMS(separate_1) "valStatusInfoMinDelay = parseFloat(enterStatusInfoElm.val()),"
        append HTML_PARAMS(separate_1) "selectBoxElm = jQuery(\"#selectStatusInfoMinDelay_\"+chn);"

        append HTML_PARAMS(separate_1) "if (valStatusInfoMinDelay > 0) \{"
          append HTML_PARAMS(separate_1) "selectBoxElm.val(1);"
          append HTML_PARAMS(separate_1) "tdStatusInfoElm.show();"
        append HTML_PARAMS(separate_1) "\} else \{"
          append HTML_PARAMS(separate_1) "selectBoxElm.val(0);"
          append HTML_PARAMS(separate_1) "tdStatusInfoElm.hide();"
        append HTML_PARAMS(separate_1) "\}"

      append HTML_PARAMS(separate_1) "\};"

      append HTML_PARAMS(separate_1) "setStatusInfoMinDelay = function(chn, elmNr) \{"
        append HTML_PARAMS(separate_1) "var enterStatusInfoElm = jQuery(\"#separate_CHANNEL_\"+chn+\"_\"+elmNr),"
        append HTML_PARAMS(separate_1) "selectBoxElm = jQuery(\"#selectStatusInfoMinDelay_\"+chn);"

      append HTML_PARAMS(separate_1) "if (selectBoxElm.val() == 0) \{"
        append HTML_PARAMS(separate_1) "enterStatusInfoElm.val(\"0.0\");"
      append HTML_PARAMS(separate_1) "\} else \{"
        append HTML_PARAMS(separate_1) "enterStatusInfoElm.val([getMinValue STATUSINFO_MINDELAY]);"
      append HTML_PARAMS(separate_1) "\}"

         append HTML_PARAMS(separate_1) "initStatusInfoMinDelay(chn, elmNr);"
      append HTML_PARAMS(separate_1) "\};"


      append HTML_PARAMS(separate_1) "window.setTimeout(initStatusInfoMinDelay($chn, $prn),100);"

    append HTML_PARAMS(separate_1) "</script>"

    incr prn
    set param STATUSINFO_RANDOM
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableStatusInfoRandom}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr prn
    set param SOUND_ID
    append HTML_PARAMS(separate_1) "<tr class=\"hidden\">"
      append HTML_PARAMS(separate_1) "<td>\${stringTableSoundID}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<tr>"
      array_clear options
      for {set i 1} {$i <= 9} {incr i} {
        set options($i) "\${signal} $i"
      }
      append HTML_PARAMS(separate_1) "<td>\${soundID}</td>"
      append HTML_PARAMS(separate_1) "<td>[getComboBox options $chn $prn 'sound\_$chn']&nbsp<input id=\"btnHelp\_$chn\" type=\"button\" onclick=\"showHelp($chn);\"></td>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<tr>"
      array_clear options
      set options(0) "\${stringTableSignalToneLow}"
      set options(1) "\${stringTableSignalToneMid}"
      set options(2) "\${stringTableSignalToneHigh}"
      set options(3) "\${stringTableSignalToneVeryHigh}"

      append HTML_PARAMS(separate_1) "<td>\${pitch}</td>"
      append HTML_PARAMS(separate_1) "<td>[getComboBox options $chn $prn 'pitch\_$chn']</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<tr>"
      array_clear options
      set options(0) "\${speedSlow}"
      set options(1) "\${speedFast}"
      append HTML_PARAMS(separate_1) "<td>\${speed}</td>"
      append HTML_PARAMS(separate_1) "<td>[getComboBox options $chn $prn 'speed\_$chn']</td>"
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl hidden j_help\" id=\"alarmHelp\_$chn\">"
  append HTML_PARAMS(separate_1) "<tr><td><img src='/ise/img/lang/de/hm-sen-sir-wm_800.png'></td></tr>"
  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"

    append HTML_PARAMS(separate_1) "jQuery(\"#alarmHelp\_$chn img\").attr(\"src\",\"/ise/img/lang/\"+getLang()+\"/hm-sen-sir-wm_800.png\");"

    append HTML_PARAMS(separate_1) "showHelp = function(chn) {"
      append HTML_PARAMS(separate_1) "var tmpCounter = 0;"
      # $chn is a tcl value and contains the number of channels
      append HTML_PARAMS(separate_1) "var numberOfChannels = $chn;"
      append HTML_PARAMS(separate_1) "var contentElm = jQuery(\"#content\");"
      append HTML_PARAMS(separate_1) "var tableElm = jQuery(\"#table_\"+chn);"
      append HTML_PARAMS(separate_1) "var tableAlarmElm = jQuery(\"#alarmHelp_\"+chn);"

      append HTML_PARAMS(separate_1) "if (tableAlarmElm.is( \":visible\" )) {"
          append HTML_PARAMS(separate_1) "contentElm.animate({scrollTop: (parseInt(chn) * parseInt(tableElm.height()))},1000, function() {"
          append HTML_PARAMS(separate_1)  "tableAlarmElm.fadeOut();"
        append HTML_PARAMS(separate_1) "});"
      append HTML_PARAMS(separate_1) "} else {"

       append HTML_PARAMS(separate_1) "jQuery(\".j_help\").fadeOut(400, function() \{"
        append HTML_PARAMS(separate_1) "tmpCounter++;"
        append HTML_PARAMS(separate_1) "if (tmpCounter == numberOfChannels) \{"
          append HTML_PARAMS(separate_1) "tableAlarmElm.fadeIn();"
          append HTML_PARAMS(separate_1) "contentElm.animate({scrollTop: ((parseInt(chn)) * parseInt(tableElm.height())) + parseInt(tableAlarmElm.height())},1000);"
        append HTML_PARAMS(separate_1) "\}"
       append HTML_PARAMS(separate_1) "\});"

      append HTML_PARAMS(separate_1) "}"
    append HTML_PARAMS(separate_1) "};"

    append HTML_PARAMS(separate_1) "calculateSoundID = function(ch) {"
      append HTML_PARAMS(separate_1) "var soundIDElm = jQuery(\"\[name='SOUND_ID'\]\")\[parseInt(ch) - 1\];"
      append HTML_PARAMS(separate_1) "var selectedSound = parseInt(jQuery(\"#sound_\" + ch).val());"
      append HTML_PARAMS(separate_1) "var selectedPitch = parseInt(jQuery(\"#pitch_\" + ch).val());"
      append HTML_PARAMS(separate_1) "var selectedSpeed = parseInt(jQuery(\"#speed_\" + ch).val());"
      append HTML_PARAMS(separate_1) "var valSoundID = selectedSound + (9 * selectedPitch) + (36 * selectedSpeed);"
      append HTML_PARAMS(separate_1) "jQuery(soundIDElm).val(valSoundID);"
    append HTML_PARAMS(separate_1) "};"

    append HTML_PARAMS(separate_1) "initSoundIDElements = function() {"
      append HTML_PARAMS(separate_1) "var soundIDElm,selectedSound,selectedPitch,selectedSpeed,valSoundID,currentSound,ch;"

      append HTML_PARAMS(separate_1) "for (var i = 0; i < 3; i++) {"

        append HTML_PARAMS(separate_1) "ch = parseInt(i) + 1;"
        append HTML_PARAMS(separate_1) "jQuery(\"#btnHelp_\" + ch).val(translateKey(\"genericBtnTxtHelp\"));"

        append HTML_PARAMS(separate_1) "soundIDElm = jQuery(\"\[name='SOUND_ID'\]\")\[i\];"
        append HTML_PARAMS(separate_1) "currentSound = jQuery(soundIDElm).val();"
        append HTML_PARAMS(separate_1) "selectedSoundElm = jQuery(\"#sound_\" + ch);"
        append HTML_PARAMS(separate_1) "selectedPitchElm = jQuery(\"#pitch_\" + ch);"
        append HTML_PARAMS(separate_1) "selectedSpeedElm = jQuery(\"#speed_\" + ch);"

        append HTML_PARAMS(separate_1) "selectedSoundElm.val(parseInt( ((currentSound - 1)%9) + 1 ));"
        append HTML_PARAMS(separate_1) "selectedPitchElm.val(parseInt( ((currentSound - 1)%36) / 9));"
        append HTML_PARAMS(separate_1) "selectedSpeedElm.val(parseInt( ((currentSound - 1) / 36 )));"

      append HTML_PARAMS(separate_1) "}"

    append HTML_PARAMS(separate_1) "};"

    append HTML_PARAMS(separate_1) "initSoundIDElements();"

   append HTML_PARAMS(separate_1) "</script>"

}

constructor

