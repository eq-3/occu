#!/bin/tclsh

sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS

  if {[string first "-FALMOT" $dev_descr(TYPE)] != -1} {
    set chn [getChannel $special_input_id]

    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
      append HTML_PARAMS(separate_1) "<tr>"
         append HTML_PARAMS(separate_1) "<td>"
             append HTML_PARAMS(separate_1) "\${lblErrorMessageActive}"
         append HTML_PARAMS(separate_1) "</td>"
         append HTML_PARAMS(separate_1) "<td>"
             append HTML_PARAMS(separate_1) "<input id='valveAvailable_$chn' type='checkbox' onchange='valveActive(this, \"$address\");'>[getHelpIcon CHANNEL_ACTIVE_CLIMATECONTROL 450 100]"
         append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "</table>"

    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"

      append HTML_PARAMS(separate_1) "var channel = DeviceList.getChannelByAddress('$address'),"
        append HTML_PARAMS(separate_1) "channel = DeviceList.getChannelByAddress('$address'),"
        append HTML_PARAMS(separate_1) "metaChnActive = homematic('Interface.getMetadata', {'objectId': channel.id, 'dataId': 'chnActive'});"

        append HTML_PARAMS(separate_1) "if (metaChnActive == 'true') {"
          append HTML_PARAMS(separate_1) "jQuery('#valveAvailable_' + channel.index).prop('checked', true);"
        append HTML_PARAMS(separate_1) "}"

      append HTML_PARAMS(separate_1) "valveActive = function(elm, address) {"
        append HTML_PARAMS(separate_1) "var active = jQuery(elm).prop('checked'),"
        append HTML_PARAMS(separate_1) "channel = DeviceList.getChannelByAddress(address);"
        append HTML_PARAMS(separate_1) "var res = homematic('Interface.setMetadata', {'objectId': channel.id, 'dataId': 'chnActive', 'value': active});"
      append HTML_PARAMS(separate_1)  "}"
    append HTML_PARAMS(separate_1) "</script>"
  } else {
    append HTML_PARAMS(separate_1) ""
  }
}

constructor