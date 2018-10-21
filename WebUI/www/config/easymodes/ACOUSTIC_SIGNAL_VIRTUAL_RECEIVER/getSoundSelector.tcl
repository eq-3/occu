proc getSoundSelector {p special_input_id param} {
  upvar $p PROFILE
  upvar prn prn
  upvar pref pref

  set html "<tr><td>\${OUTPUT_BEHAVIOUR_mp3}</td><td>"
  array_clear options
  set options(0) "\${internalSystemSound}"
  set options(253) "\${randomPlayback}"
  set options(254) "\${soundOldValue}"
  set options(255) "\${dontCare}"

  for {set loop 1} {$loop <= 252} {incr loop} {
    set options($loop) $loop
  }

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

    append html "[get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE $param]&nbsp;[getHelpIcon repetitionOffTimeSound 450 100]"
  append html "</td></tr>"
  return $html
}