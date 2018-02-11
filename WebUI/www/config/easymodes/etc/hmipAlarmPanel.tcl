#!/bin/tclsh

proc getAlarmPanel {p} {
  upvar $p ps
  upvar prn prn
  upvar special_input_id special_input_id

  puts "<script type=\"text/javascript\">getLangInfo_Special('ALARM_PANEL.txt');</script>"
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"

  set specialID "[getSpecialID $special_input_id]"

  set html ""
  
  set param ALARM_MODE_ZONE_1
  if { ! [catch {set tmp $ps($param)}]  } {

   append html "[getHorizontalLine]"

   append html "<tr><td colspan=\"3\"><div class=\"CLASS06336\">\${alarmPanelHeader}</div></td></tr>"

    # This is for the parameter ALARM_ZONE_1..8
   append html "<tr>"
     append html "<td>\${paramAlarmModeZone}</td>"
     append html "<td>"
       append html "<table><tr>"
          for {set loop 1} {$loop < 8} {incr loop} {
            incr prn
            set zoneActive ""
            set checked ""
            set zoneActive "$ps(ALARM_MODE_ZONE_$loop)"
            if {[string equal $zoneActive "1"] == 1} {
              set checked "checked"
            }
           append html "<td>"
             append html "<label for=\"separate\_${special_input_id}_$prn\">$loop</label>"
             append html "<input type=\"checkbox\" id=\"separate\_${special_input_id}_$prn\" name=\"ALARM_MODE_ZONE_$loop\" $checked></td>"
           append html "</td>"
          }
       append html "</tr></table>"
     append html "<td>"
   append html "</tr>"
  }

  set param ALARM_MODE_TYPE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    set hlpBoxWidth 450
    set hlpBoxHeight 80
    array_clear options
    set options(0) "\${ALARM_FOR_ZONES}"
    set options(1) "\${DISARM_FOR_ZONES}"
   append html "<tr>"
     append html "<td>\${paramAlarmModeType}</td>"
     append html  "<td>[get_ComboBox options $param separate_${special_input_id}_$prn ps $param]&nbsp;[getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
   append html "</tr>"
  }

  return $html
}