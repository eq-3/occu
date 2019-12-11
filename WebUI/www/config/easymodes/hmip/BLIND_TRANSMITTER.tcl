#!/bin/tclsh

#Kanal-EasyMode!

source [file join /www/config/easymodes/em_common.tcl]

proc hasLinks {chn} {
  global iface dev_descr

  set result 0

  set parentAddress $dev_descr(ADDRESS)
  set addressVirtA "$parentAddress:[expr $chn + 1]"
  set addressVirtB "$parentAddress:[expr $chn + 2]"
  set addressVirtC "$parentAddress:[expr $chn + 3]"

  set linksVirtA [getLinkCountByAddress $iface $addressVirtA]
  set linksVirtB [getLinkCountByAddress $iface $addressVirtB]
  set linksVirtC [getLinkCountByAddress $iface $addressVirtC]

  if {($linksVirtA != 0) || ($linksVirtB != 0) || ($linksVirtC != 0)} {
    set result 1
  }

  return $result
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set url $iface_url($iface)

  set addressID modeSelector_[string map {: _} $address]

  set chn [getChannel $special_input_id]

  set devType $dev_descr(TYPE)
  set devIface [lindex [split $devType -] 0]

  set devMode ""

  set chnHasLinks [hasLinks $chn]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    # A wired blind cannot only be a blind but a shutter as well!!
    if {([string equal $devIface HmIPW] == 1) || ([string equal $devType HmIP-DRBLI4] == 1)} {

      # Determine the current channelMode
      set devMode [xmlrpc $url getMetadata [list string $address] channelMode]
      # When the metadata channelMode isn't set yet (after teach-in) set the metadata to the default value blind
      if {[string equal $devMode ""] == 1} {
        set devAddress [lindex [split $address :] 0]
        set chn [lindex [split $address :] 1]
        set virtChAddressA "$devAddress:[expr $chn + 1]"
        set virtChAddressB "$devAddress:[expr $chn + 2]"
        set virtChAddressC "$devAddress:[expr $chn + 3]"

        set devMode "blind"
        puts "[xmlrpc $url setMetadata [list string $address] channelMode $devMode]"
        puts "[xmlrpc $url setMetadata [list string $virtChAddressA] channelMode $devMode]"
        puts "[xmlrpc $url setMetadata [list string $virtChAddressB] channelMode $devMode]"
        puts "[xmlrpc $url setMetadata [list string $virtChAddressC] channelMode $devMode]"
      }

      append HTML_PARAMS(separate_1) "<tr>"
        append HTML_PARAMS(separate_1) "<td style=\"width:50%\">\${lblJalousieBlind}</td>"
        append HTML_PARAMS(separate_1) "<td>"
          append HTML_PARAMS(separate_1) "<select id='$addressID' onchange='storeChangedModeElms(\"$address\",\"$chn\")'>"
          append HTML_PARAMS(separate_1) "<option value='blind'>\${optionBlind}</option>"
          append HTML_PARAMS(separate_1) "<option value='shutter'>\${optionShutter}</option>"
          append HTML_PARAMS(separate_1) "</select>"

        append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      append HTML_PARAMS(separate_1) "<tr id='modeChangedHint_$chn' class=\"hidden\">"
         append HTML_PARAMS(separate_1) "<td colspan=\"2\" class='attention'>\${hintBlindModeChanged}</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      append HTML_PARAMS(separate_1) "<tr>"
        append HTML_PARAMS(separate_1) "<td colspan=\"2\">"
          append HTML_PARAMS(separate_1) "<div id=\"hintLinksProgramsAvailable_$chn\" class=\"attention\"></div>"
        append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"
      append HTML_PARAMS(separate_1) "<tr id=\"hintLinksProgramsHR_$chn\" class=\"hidden\"><td colspan=\"2\"><hr></td></tr>"

      puts "<script type=\"text/javascript\">"

        puts "initBlind = function(address, fromInbox, newDevice) \{"
          puts "if (fromInbox) \{"
            puts "homematic(\"Interface.getMetadata_crRFD\", \{\"interface\" : \"HmIP-RF\",\"objectId\": address,\"dataId\": \"channelMode\"\},"
            puts "function(result) {window.setTimeout(function() \{jQuery('#modeSelector_' + address.replace(\":\",\"_\")).val(result).prop('selected',true);\},500);});"

            puts "if (newDevice) \{"
              set devAddress [lindex [split $address :] 0]
              puts "var oDevice = DeviceList.getDeviceByAddress('$devAddress');"
              puts "oDevice.inInbox = true;"
              puts "DeviceList.updateDevice(oDevice);"
            puts "\}"

          puts "\}"

          puts "var oChannel = DeviceList.getChannelByAddress('$address');"

          puts "var hintIndicator = 0;"

          puts "var virChnAddressA = oChannel.device.address + \":\" + (oChannel.index + 1),"
          puts "virChnAddressB = oChannel.device.address + \":\" + (oChannel.index + 2),"
          puts "virChnAddressC = oChannel.device.address + \":\" + (oChannel.index + 3),"

          puts "oChannelVirtA = DeviceList.getChannelByAddress(virChnAddressA),"
          puts "oChannelVirtB = DeviceList.getChannelByAddress(virChnAddressB),"
          puts "oChannelVirtC = DeviceList.getChannelByAddress(virChnAddressC);"

          puts "if (0 != $chnHasLinks) {"
             puts "hintIndicator += 1;"
          puts "}"

          puts "if ((oChannel.hasProgramIds()) || (oChannelVirtA.hasProgramIds()) || (oChannelVirtB.hasProgramIds()) || (oChannelVirtC.hasProgramIds())) {"
            puts "hintIndicator += 2;"
          puts "}"

          puts "if (hintIndicator > 0) {"
            puts "var arHints = \['', 'hintWiredBlindLinksAvailable', 'hintWiredBlindProgramsAvailable', 'hintWiredBlindLinksAndProgramsAvailable'\]"

            puts "if (oChannel.hasProgramIds()) \{"
              puts "var hintAffectedChannels = (oChannel.index) + ', ' + (oChannel.index + 1) + ', ' + (oChannel.index + 2) + ', ' + (oChannel.index + 3);"
            puts "\} else \{"
              puts "var hintAffectedChannels = (oChannel.index + 1) + ', ' + (oChannel.index + 2) + ', ' + (oChannel.index + 3);"
            puts "\}"

            puts "jQuery(\"#hintLinksProgramsAvailable_$chn\").html(translateKey(arHints\[hintIndicator\]) + translateKey(\"hintCheckChannels\") + hintAffectedChannels);"
            puts "jQuery(\"#hintLinksProgramsHR_$chn\").show();"
            puts "jQuery(\"#modeSelector_\"+oChannel.device.address+\"_$chn\").prop(\"disabled\", true);"
          puts "}"

          # When the metadata channelMode isn't set yet (after teach-in) set the metadata to the default value blind

          puts "var devMode = oChannel.multiMode;"

          puts "if ((devMode == '--') || (devMode == 'null') || (typeof devMode == 'undefined')) \{"

            puts "var devAddress = oChannel.device.address,"
            puts "devMode = 'blind',"
            puts "ch = oChannel.index,"
            puts "isChannelMultiModeSet = false,"
            puts "chnAddress;"

            puts "for(var x = 0; x<=3; x++) \{"
              puts "chnAddress = devAddress+\":\"+(parseInt(ch) + x);"
              puts "homematic(\"Interface.setMetadata_crRFD\", \{"
                puts "\"interface\": \"HmIP-RF\","
                puts "\"objectId\": chnAddress,"
                puts "\"dataId\": \"channelMode\","
                puts "\"value\": \"blind\""
              puts "\});"

              puts "homematic(\"Interface.setMetadata\", \{"
                puts "\"objectId\": chnAddress,"
                puts "\"dataId\": \"channelMode\","
                puts "\"value\": \"blind\""
              puts "\}, function() \{"
                puts "if (! isChannelMultiModeSet) \{"
                  puts "oChannel.setMultiMode('blind');"
                  puts "oChannelVirtA.setMultiMode('blind');"
                  puts "oChannelVirtB.setMultiMode('blind');"
                  puts "oChannelVirtC.setMultiMode('blind');"
                  puts "DeviceList.beginUpdateDevice(oChannel.device.id);"
                  puts "isChannelMultiModeSet = true;"
                puts "\}"
              puts "\});"
            puts "\}"

          puts "\}"

          puts "var tmpChannelMode = \"blind\";"
          puts "if (typeof arRealChannelElms != 'object') {arRealChannelElms = \[\];}"
          puts "if (typeof arModeElms != 'object') {arModeElms = \[\];}"

          puts "window.setTimeout(function() {jQuery(\"\#$addressID\").val(devMode).prop('selected',true);},50);"

        puts "\}"


        # Nur, wenn im Posteingang
        puts "if (typeof devToConfigure != 'undefined') \{"
         puts "var oDevice = DeviceList.getDeviceByAddress('$devAddress');"
         puts "if (typeof oDevice != 'object') \{"
             puts "DeviceList.beginUpdateDevice(devToConfigure, function() \{initBlind('$address', true, true);\});"
          puts "\} else \{"
            puts "initBlind('$address',true, false);"
          puts "\}"
          puts "window.setTimeout(function() \{delete devToConfigure\},500);"
        puts "\} else \{"
          puts "initBlind('$address',false, false);"
        puts "\}"

        puts "storeChangedModeElms = function(address, chn) \{"
          # arModeElms contains all changed mode elements
          puts "jQuery(\"\#modeChangedHint_\"+ chn).show();"

          puts "var devAddress = address.split(\":\")\[0\],"
          puts "chnAddress;"

          puts "arRealChannelElms.push(address);"

          puts "for(var x = 0; x <= 3; x++) \{"
            puts "chAddress = devAddress + \":\" + (parseInt(chn) + x);"
            puts "if (jQuery.inArray(chAddress, arModeElms) == -1) {arModeElms.push(chAddress);}"
          puts "\}"

        puts "\};"

        puts "setMetaData = function() \{"
          puts "jQuery.each(arModeElms, function(index, chAddress) \{"
            puts "var elmID = \"#modeSelector_\" + chAddress.replace(\":\",\"_\"),"
            puts "elmVal = jQuery(elmID).val();"

            puts "tmpChannelMode = (typeof elmVal != \"undefined\") ? elmVal : tmpChannelMode;"
            puts "elmVal = tmpChannelMode;"
            puts "var oChannel = DeviceList.getChannelByAddress(chAddress);"
            puts "var device = oChannel.device;"

            puts "homematic(\"Interface.setMetadata_crRFD\", \{"
              puts "\"interface\": \"HmIP-RF\","
              puts "\"objectId\": oChannel.address,"
              puts "\"dataId\": \"channelMode\","
              puts "\"value\": elmVal"
            puts "\});"

            puts "homematic(\"Interface.setMetadata\", \{"
              puts "\"objectId\": oChannel.address,"
              puts "\"dataId\": \"channelMode\","
              puts "\"value\": elmVal"
            puts "\}, function() {
              oChannel.changeChannelDescription();
              oChannel.setMultiMode(elmVal);
              DeviceList.beginUpdateDevice(device.id);
            });"
          puts "\});"
        puts "\}"

        puts "setReferenceRunningTimeSlatsValue = function() \{"
          puts "jQuery.each(arRealChannelElms, function(index, chAddress) \{"
            puts "var elmID = \"#modeSelector_\" + chAddress.replace(\":\",\"_\"),"
            puts "elmVal = jQuery(elmID).val();"

            puts "if (elmVal === \"shutter\") \{"
              puts "homematic(\"Interface.putParamset\", {'interface': 'HmIP-RF', 'address': chAddress, 'paramsetKey' : 'MASTER', 'set' : \[\{name:'REFERENCE_RUNNING_TIME_SLATS_UNIT', type : 'integer', value : 0\}\,\{name:'REFERENCE_RUNNING_TIME_SLATS_VALUE', type : 'integer', value : 0\}\] }, function() \{\});"
            puts "\} else \{"
              puts "homematic(\"Interface.putParamset\", {'interface': 'HmIP-RF', 'address': chAddress, 'paramsetKey' : 'MASTER', 'set' : \[\{name:'REFERENCE_RUNNING_TIME_SLATS_UNIT', type : 'integer', value : 2\}\,\{name:'REFERENCE_RUNNING_TIME_SLATS_VALUE', type : 'integer', value : 2\}\] }, function() \{\});"
            puts "\}"
          puts "\});"

          puts "delete arRealChannelElms;"
          puts "delete arModeElms;"

        puts "\}"

        # Extend the footer buttons
         puts "window.setTimeout(function() \{"
           puts "var elm = jQuery('#footerButtonOK');"
           puts "elm.off('click').click(function() {setMetaData();setReferenceRunningTimeSlatsValue();});"
         puts "\},1200);"
      puts "</script>"
    }

    set prn 1
    if {[string equal $devMode blind] != 0} {
      append HTML_PARAMS(separate_1) "[getBlindTransmitter $chn ps psDescr $address]"
    } elseif {[string equal $devMode shutter] == 1} {
      append HTML_PARAMS(separate_1) "[getShutterTransmitter $chn ps psDescr $address]"
    } else {
      append HTML_PARAMS(separate_1) "[getBlindTransmitter $chn ps psDescr $address]"
    }

  append HTML_PARAMS(separate_1) "</table>"
}

constructor