proc getOutputBehaviourElement {valOutputBehaviour p special_input_id} {
  upvar $p PROFILE
  upvar prn prn
  upvar pref pref

  set html "<tr>"

    append html "<td>"
      append html "\${wsmLinkOutputBehaviour}"
    append html "</td>"

    append html "<td>"
      append html "<input id='wsmLtr_$prn\_$pref' type='text' size='4' class='alignCenter' value='0' onblur='setLinkWSMOutputBehaviour2Send(\"$prn\", \"$pref\");'> x "

      append html "<select id='wsmUnit_$prn\_$pref' onchange='setLinkWSMOutputBehaviour2Send(\"$prn\", \"$pref\");'>"
        append html "<option value='0'>\${optionUnit1Ltr}</option>"
        append html "<option value='64'>\${optionUnit10Ltr}</option>"
        append html "<option value='128'>\${optionUnit100Ltr}</option>"
        append html "<option value='192'>\${optionUnit1000Ltr}</option>"
      append html "</select>"

      append html "&nbsp;&nbsp;[getHelpIcon helpConditionWaterFlow 500 75]"
      append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_OUTPUT_BEHAVIOUR' type='text' size='4' class='alignCenter hidden' value='$valOutputBehaviour' >"
    append html "</td>"

  append html "</tr>"
  append html "<script type='text/javascript'>"
    append html "window.setTimeout(function() {setLinkWSMOutputBehaviourElms('$valOutputBehaviour', '$prn', '$pref');},50);"
  append html "</script>"

  return $html
}