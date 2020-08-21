source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

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

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    append HTML_PARAMS(separate_1) "<col style=\"width:50%;\" >"
    append HTML_PARAMS(separate_1) "<col style=\"width:39%;\">"
    append HTML_PARAMS(separate_1) "<col style=\"width:1%;\">"
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>"

        append HTML_PARAMS(separate_1) "<table>"
          set prn 1
          set param TRANSMIT_TRY_MAX
          append HTML_PARAMS(separate_1) "<tr>"
            append HTML_PARAMS(separate_1) "<td>\${stringTableTransmitTryMax}</td>"
            append HTML_PARAMS(separate_1)  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
          append HTML_PARAMS(separate_1) "</tr>"

          incr prn
          set param DATA_TRANSMISSION_CONDITION
          append HTML_PARAMS(separate_1) "<tr>"
            append HTML_PARAMS(separate_1) "<td>\${stringTableTransmitterDataTransmissionCondition}</td>"
            array_clear options
            set options(0) "\${stringTableTransmitterDataTransmissionCondition0}"
            set options(1) "\${stringTableTransmitterDataTransmissionCondition1}"
            set options(2) "\${stringTableTransmitterDataTransmissionCondition2}"
            set options(3) "\${stringTableTransmitterDataTransmissionCondition3}"
            set options(4) "\${stringTableTransmitterDataTransmissionCondition4}"
            set options(5) "\${stringTableTransmitterDataTransmissionCondition5}"
            set options(6) "\${stringTableTransmitterDataTransmissionCondition6}"
            append HTML_PARAMS(separate_1)  "<td>[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"showDataTransmissionOptionHelp(this.id);\""]</td>"
          append HTML_PARAMS(separate_1) "</tr>"

          incr prn
          set param DATA_STABILITY_FILTER_TIME
          append HTML_PARAMS(separate_1) "<tr>"
            append HTML_PARAMS(separate_1) "<td>\${stringTableTransmitterDataStabilityFilterTime}</td>"
            append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
          append HTML_PARAMS(separate_1) "</tr>"

          append HTML_PARAMS(separate_1) "[getHorizontalLine]"
          append HTML_PARAMS(separate_1) "<tr><td>\${lblTransmitterDataInputPropertie}</td></tr>"

          for {set loop 0} {$loop <= 7} {incr loop} {
            incr prn
            set param DATA_INPUT_PROPERTIE_IN$loop
            append HTML_PARAMS(separate_1) "<tr>"
              append HTML_PARAMS(separate_1) "<td>\${stringTableTransmitterDataInputPropertie$loop}</td>"
              append HTML_PARAMS(separate_1)  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
            append HTML_PARAMS(separate_1) "</tr>"
          }
        append HTML_PARAMS(separate_1) "</table>"
      append HTML_PARAMS(separate_1) "</td>"

      append HTML_PARAMS(separate_1) "<td id=\"idHelpContainer\" class=\"hidden\" style=\"vertical-align:top;\">"
        append HTML_PARAMS(separate_1) "<div>\${lblHeaderHelpTransmitterTransmissionCondition}</div>"
        append HTML_PARAMS(separate_1) "<div><br/><span id=\"idHelp\"></span></div>"
      append HTML_PARAMS(separate_1) "</td>"
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "showDataTransmissionOptionHelp = function(elmID) {"
      append HTML_PARAMS(separate_1) "var selectedOption = jQuery('#'+elmID).val();"
      append HTML_PARAMS(separate_1) "jQuery('#idHelp').html(translateKey('descriptionTransmitterDataTransmissionCondition'+selectedOption));"
    append HTML_PARAMS(separate_1) "};"

    append HTML_PARAMS(separate_1) "window.setTimeout(function() {"
      append HTML_PARAMS(separate_1) "showDataTransmissionOptionHelp('separate_CHANNEL_3_2');"
      append HTML_PARAMS(separate_1) "jQuery('#idHelpContainer').show();"
    append HTML_PARAMS(separate_1) "},250);"

  append HTML_PARAMS(separate_1) "</script>"

}

constructor


