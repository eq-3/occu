source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

proc extractParamFromTranslationKey {key} {
  return ""
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr

  #upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  #upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set chn [lindex [split $special_input_id _] 1]

  #puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/ALARMACTUATOR/function.js');</script>"
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/DualWhiteController.js');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"


  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    set param "LOGIC_COMBINATION"
    append HTML_PARAMS(separate_1) "<tr name=\"expertParam\">"
      append HTML_PARAMS(separate_1) "<td style=\"width:10%\">\${stringTableLogicCombination}</td>"
      option LOGIC_COMBINATION
      append HTML_PARAMS(separate_1) "<td style=\"width:25%\">[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
      append HTML_PARAMS(separate_1) "<td>&nbsp<input class=\"j_helpBtn\" id=\"virtual_help_button_$chn\" type=\"button\" value=\"Hilfe\" onclick=\"VirtualChannel_help($chn);\"></td>"
      append HTML_PARAMS(separate_1) "<td style=\"25%\"></td>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<tr id=\"virtual_ch_help_$chn\" style=\"display:none\"><td colspan=\"3\">\${virtualHelpTxtDimmer}</td></tr>"
    append HTML_PARAMS(separate_1) "<tr><td colspan=\"4\"><hr></td></tr>"
  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    incr prn
    set param POWERUP_ACTION
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableDimmerPowerUpAction}</td>"
      array_clear options
      set options(0) "\${stringTablePowerUpOFF}"
      set options(1) "\${stringTablePowerUpON}"
      append HTML_PARAMS(separate_1)  "<td colspan=\"2\">[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
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

      append HTML_PARAMS(separate_1) "<td id=\"enterStatusInfoMinDelay_$chn\" class=\"hidden\">[getTextField $param $ps($param) $chn $prn]</td><td>[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
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
        append HTML_PARAMS(separate_1) "enterStatusInfoElm.val($ps($param));"
      append HTML_PARAMS(separate_1) "\}"
         append HTML_PARAMS(separate_1) "initStatusInfoMinDelay(chn, elmNr);"
      append HTML_PARAMS(separate_1) "\};"
      append HTML_PARAMS(separate_1) "window.setTimeout(initStatusInfoMinDelay($chn, $prn),100);"
    append HTML_PARAMS(separate_1) "</script>"

    incr prn
    set param STATUSINFO_RANDOM
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableStatusInfoRandom}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $param $ps($param) $chn $prn]</td><td>[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr prn
    set param TRANSMIT_TRY_MAX
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableTransmitTryMax}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $param $ps($param) $chn $prn]</td><td>[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<tr><td colspan=\"4\"><hr></td></tr>"

      append HTML_PARAMS(separate_1) "<tr>"
        append HTML_PARAMS(separate_1) "<td>"
          append HTML_PARAMS(separate_1) "<table>"
            incr prn
            set param CHARACTERISTIC_BASETYPE
            append HTML_PARAMS(separate_1) "<tr>"
              append HTML_PARAMS(separate_1) "<td>\${stringTableCharacteristicBaseType}</td>"
              array_clear options
              set options(0) "\${stringTableCharacteristicCrossfade}"
              set options(1) "\${stringTableCharacteristicDim2Warm}"
              set options(2) "\${stringTableCharacteristicDim2Hot}"
              append HTML_PARAMS(separate_1)  "<td colspan=\"2\">[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"setDiagram();\"" ]</td>"
            append HTML_PARAMS(separate_1) "</tr>"

            incr prn
            set param CHARACTERISTIC_COLOURASSIGNMENT
            append HTML_PARAMS(separate_1) "<tr>"
              append HTML_PARAMS(separate_1) "<td>\${stringTableCharacteristicColorAssignment}</td>"
              array_clear options
              set options(0) "\${stringTableCharacteristicLowIsWarm}"
              set options(1) "\${stringTableCharacteristicLowIsCold}"
              append HTML_PARAMS(separate_1)  "<td colspan=\"2\">[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"setDiagram();\""]</td>"
            append HTML_PARAMS(separate_1) "</tr>"

            incr prn
            set param CHARACTERISTIC_LEVELLIMIT
            append HTML_PARAMS(separate_1) "<tr>"
              append HTML_PARAMS(separate_1) "<td>\${stringTableCharacteristicLevelLimit}</td>"
              array_clear options
              set options(0) "\${stringTableCharacteristicHalfConstant}"
              set options(1) "\${stringTableCharacteristicMaximum}"
              append HTML_PARAMS(separate_1)  "<td colspan=\"2\">[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"setDiagram();\""]</td>"
            append HTML_PARAMS(separate_1) "</tr>"

            incr prn
            set param CHARACTERISTIC_LINSQUARETYPE
            append HTML_PARAMS(separate_1) "<tr>"
              append HTML_PARAMS(separate_1) "<td>\${stringTableCharacteristicLinSquareType}</td>"
              array_clear options
              set options(0) "\${stringTableCharasteristicLinear}"
              set options(1) "\${stringTableCharasteristicSquare}"
              append HTML_PARAMS(separate_1)  "<td colspan=\"2\">[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"setDiagram();\""]</td>"
            append HTML_PARAMS(separate_1) "</tr>"
          append HTML_PARAMS(separate_1) "</table>"
        append HTML_PARAMS(separate_1) "</td>"

        append HTML_PARAMS(separate_1) "<td>"
          append HTML_PARAMS(separate_1) "<img id='diagram$address' name='imgDualWhiteController' src='' width=100px; height=100px />"
        append HTML_PARAMS(separate_1) "</td>"

      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"


  if {[session_is_expert]} {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").show();"
    append HTML_PARAMS(separate_1) "</script>"
  } else {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").hide();"
    append HTML_PARAMS(separate_1) "</script>"
  }

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "setDiagram();"

    append HTML_PARAMS(separate_1) "jQuery(\".j_helpBtn\").val(translateKey(\"helpBtnTxt\"));"

    append HTML_PARAMS(separate_1) "VirtualChannel_help = function(ch) {"
      append HTML_PARAMS(separate_1) "jQuery('#virtual_ch_help_'+ch).toggle('fast', function() {"
        append HTML_PARAMS(separate_1) "var btnElm = jQuery('#virtual_help_button_'+ch);"
        append HTML_PARAMS(separate_1) "if (btnElm.val() == translateKey(\"genericBtnTxtHelp\")) {"
          append HTML_PARAMS(separate_1) "btnElm.val(translateKey(\"genericBtnTxtHelpOff\"));"
        append HTML_PARAMS(separate_1) "} else {"
          append HTML_PARAMS(separate_1) "btnElm.val(translateKey(\"genericBtnTxtHelp\"));"
        append HTML_PARAMS(separate_1) "}"
      append HTML_PARAMS(separate_1) "});"
    append HTML_PARAMS(separate_1) "}"
  append HTML_PARAMS(separate_1) "</script>"



}

constructor


