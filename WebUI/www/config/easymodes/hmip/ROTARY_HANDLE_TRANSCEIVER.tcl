#!/bin/tclsh


sourceOnce [file join /www/config/easymodes/em_common.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
#sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipAlarmPanel.tcl]

#set PROFILES_MAP(0)  "Experte"
#set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr
  
 # upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
 # upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    psDescr
  upvar PROFILE_1     PROFILE_1

  set chn [getChannel $special_input_id]
  set specialID "[getSpecialID $special_input_id]"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelay}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "eventDelay"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param EVENT_DELAY_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_DELAY_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
      append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelayValue}</td>"
      append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

    set param MSG_FOR_POS_B
    if { [info exists ps($param)] == 1 } {
      incr prn
      append HTML_PARAMS(separate_1) "<tr>"
        array_clear options
        set options(0) "\${stringTableRHSMsgPosNoMsg}"
        set options(1) "\${stringTableRHSMsgPosClosed}"
        set options(2) "\${stringTableRHSMsgPosOpen}"
        set options(3) "\${stringTableRHSMsgPosTilted}"
        append HTML_PARAMS(separate_1) "<td>\${stringTableRHSMsgPosA}</td>"
        append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_${special_input_id}_$prn ps $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"
    }

    set param MSG_FOR_POS_A
    if { [info exists ps($param)] == 1 } {
      incr prn
      append HTML_PARAMS(separate_1) "<tr>"
        array_clear options
        set options(0) "\${stringTableRHSMsgPosNoMsg}"
        set options(1) "\${stringTableRHSMsgPosClosed}"
        set options(2) "\${stringTableRHSMsgPosOpen}"
        set options(3) "\${stringTableRHSMsgPosTilted}"
        append HTML_PARAMS(separate_1) "<td>\${stringTableRHSMsgPosB}</td>"
        append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_${special_input_id}_$prn ps $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"
    }

    set param MSG_FOR_POS_C
    if { [info exists ps($param)] == 1 } {
      incr prn
      append HTML_PARAMS(separate_1) "<tr>"
        array_clear options
        set options(0) "\${stringTableRHSMsgPosNoMsg}"
        set options(1) "\${stringTableRHSMsgPosClosed}"
        set options(2) "\${stringTableRHSMsgPosOpen}"
        set options(3) "\${stringTableRHSMsgPosTilted}"
        append HTML_PARAMS(separate_1) "<td>\${stringTableRHSMsgPosC}</td>"
        append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_${special_input_id}_$prn ps $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"
    }

set comment {
    set param ABORT_EVENT_SENDING_CHANNELS
    if { [info exists ps($param)] == 1  } {
       incr prn
       append HTML_PARAMS(separate_1) "<tr>"
         append HTML_PARAMS(separate_1) "<td>\${lblAbortEventSendingChannel}</td>"
         # Todo - When set to checkbox, it's not possible to transmit any parameter changes of this channel. This is, because the paramset description says, this parameter is a string instead of a boolean
         # append HTML_PARAMS(separate_1)  "<td>[getCheckBox $param $ps($param) $chn $prn]</td>"
         append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
       append HTML_PARAMS(separate_1) "</tr>"
    }
}
    # append HTML_PARAMS(separate_1) "[getAlarmPanel ps]"

  append HTML_PARAMS(separate_1) "</table>"
}

constructor