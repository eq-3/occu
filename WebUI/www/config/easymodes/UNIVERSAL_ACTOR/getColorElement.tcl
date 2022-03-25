puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"

proc getSelectColorElement {p special_input_id param} {
  upvar $p PROFILE
  upvar prn prn
  upvar pref pref

  set html "<tr><td>\${OUTPUT_BEHAVIOUR_color}</td><td>"
  array_clear options
  set options(0) "\${BLACK}"
  set options(1) "\${BLUE}"
  set options(2) "\${GREEN}"
  set options(3) "\${TURQUOISE}"
  set options(4) "\${RED}"
  set options(5) "\${PURPLE}"
  set options(6) "\${YELLOW}"
  set options(7) "\${WHITE}"
  append html [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE $param]
  append html "</td></tr>"
  return $html
}

proc getRepetitionSelector {p special_input_id param} {
  upvar $p PROFILE
  upvar prn prn
  upvar pref pref

  set html "<tr><td>\${REPETITION}</td><td>"
    array_clear options
    set options(0) "\${noRepetitions}"
    set options(255) "\${infiniteRepetitions}"
    for {set loop 1} {$loop <= 254} {incr loop} {
      set options($loop) $loop
    }

    append html "[get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE $param]&nbsp;[getHelpIcon repetitionOffTimeDimmer 450 100]"
  append html "</td></tr>"
  return $html
}

proc getSelectBehaviourElement {p special_input_id param} {
  upvar $p PROFILE
  upvar prn prn
  upvar pref pref

  set html "<tr><td>\${OUTPUT_BEHAVIOUR_blink}</td><td>"
  array_clear options
  set options(0) "\${optionColorOFF}"
  set options(1) "\${optionColorON}"
  set options(2) "\${blinkSlow}"
  set options(3) "\${blinkMiddle}"
  set options(4) "\${blinkFast}"
  set options(5) "\${blinkFlashSlow}"
  set options(6) "\${blinkFlashMiddle}"
  set options(7) "\${blinkFlashFast}"
  set options(8) "\${blinkBillowSlow}"
  set options(9) "\${blinkBillowMiddle}"
  set options(10) "\${blinkBillowFast}"
  set options(11) "\${blinkBehaviourOldValue}"
  set options(12) "\${blinkBehaviourDoNotCare}"
  append html [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE $param]
  append html "</td></tr>"
  return $html
}