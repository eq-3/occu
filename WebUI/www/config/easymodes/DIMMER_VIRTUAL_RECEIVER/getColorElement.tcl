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

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"

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
