proc getSelectColorElement {p special_input_id param} {
  upvar $p PROFILE
  upvar prn prn
  upvar pref pref

  set html "<tr><td>\${OUTPUT_BEHAVIOUR}</td><td>"
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
