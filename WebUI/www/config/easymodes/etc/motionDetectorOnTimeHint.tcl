#!/bin/tclsh

proc getMotionDetectorOnTimeHint {} {

  global url dev_descr_sender sender_address

  set senderAvailable 0

  catch {array set sender_ch_ps [xmlrpc $url getParamset $sender_address MASTER]}

  if { ! [catch {set minInterval $sender_ch_ps(MIN_INTERVAL)}]  } {
    set senderAvailable 1
    array set timeUnits {
      0 "15 \${seconds}"
      1 "30 \${seconds}"
      2 "1 \${minute}"
      3 "2 \${minutes}"
      4 "4 \${minutes}"
      5 "8 \${minutes}"
      6 "16 \${minutes}"
    }
  }

  set html ""

  append html "<tr><td colspan=\"2\"><hr></td></tr>"
  append html "<tr>"
    append html "<td colspan=\"2\">"
      append html "<div>"
        if {$senderAvailable} {
          append html "\${helpBtnChannelConfigurationMotionDetectorA} $timeUnits($minInterval) \${helpBtnChannelConfigurationMotionDetectorB} $timeUnits($minInterval) \${helpBtnChannelConfigurationMotionDetectorC} $timeUnits($minInterval) \${helpBtnChannelConfigurationMotionDetectorD} \${helpBtnChannelConfigurationMotionDetectorE}"
          append html "\${helpGotoChannelConfiguration}"
        } else {
          append html "\${helpBtnChannelConfigurationMotionDetectorGeneric} \${helpBtnChannelConfigurationMotionDetectorE}"
          append html "\${helpGotoChannelConfiguration}"
        }
      append html "</div>"
    append html "</td>"
  append html "</tr>"

  append html "<tr>"
    append html "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
    append html "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append html "</tr>"

}
