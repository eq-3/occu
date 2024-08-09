#!/bin/tclsh

puts "<script type=\"text/javascript\">"
  puts "if(typeof origRemoteModEM8Val == 'undefined'){origRemoteModEM8Val = {};}"

  puts "onChangeChannelFunction = function(id) \{"
    puts "var ch = id.split('_')\[2\];"
    puts "var value = jQuery(\"#\"+id).val();"
    puts "var transTryMaxElm = jQuery('#CHANNEL_'+ch+'_tryMax');"
    puts "var jName = 'CHANNEL_'+ch+'_specialVal';"
    puts "var nameElm = jQuery(\"\[name='\"+jName+\"'\]\");"
    puts "var hintElm = jQuery('#CHANNEL_'+ch+'_specialValHint');"

    puts "if (origRemoteModEM8Val\[ch\] != value) \{"
      puts "nameElm.hide();"
      puts "if (value != '3') {hintElm.show();}"
    puts "\} else \{"
      puts "nameElm.show();"
      puts "hintElm.hide();"
    puts "\}"

    puts "if (value == '3') \{"
      puts "transTryMaxElm.hide();"
      puts "hintElm.hide();"
    puts "\} else \{"
      puts "if (origRemoteModEM8Val\[ch\] == '3') \{"
        puts "hintElm.show();"
      puts "\}"
      puts "transTryMaxElm.show();"
    puts "\}"

  puts "\};"
puts "</script>"

proc getUnit {param} {
  global psDescr
  array_clear param_descr
  array set param_descr $psDescr($param)
  set unit $param_descr(UNIT)
  return "$unit"
}

proc getMinMaxValueDescr {param} {
	global psDescr
  array_clear param_descr
	array set param_descr $psDescr($param)
  set min $param_descr(MIN)
  set max $param_descr(MAX)

  # Limit float to 2 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.2f} $min]
    set max [format {%1.2f} $max]
  }
  return "($min - $max)"
}

proc getTextField {param inputId} {
  upvar ps ps
  set elemId 'separate_$inputId'
  set value $ps($param)
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param>"
  return $s
}

proc getChannelFunction {param prn special_input_id} {
	  upvar ps ps
    set ch [expr [lindex  [split $special_input_id "_"] 1]]

	  array_clear options
    set options(0) "\${stringTableKeyButtonBehavior}"
    set options(1) "\${stringTableKeySwitchBehavior}"
    set options(2) "\${stringTableKeyBinaryBehavior}"
    set options(3) "\${stringTableKeyInactive}"
    append s "[get_ComboBox options $param separate_${special_input_id}_$prn ps $param onchange=\"onChangeChannelFunction(this.id)\";]"
    # puts "<script type=\"text/javascript\">origRemoteModEM8Val\[$ch\] = $ps($param);jQuery('#separate_${special_input_id}_$prn').prop('disabled', true);</script>"
    puts "<script type=\"text/javascript\">origRemoteModEM8Val\[$ch\] = $ps($param);</script>"

    return $s
}

proc getMsg4Pos {param prn special_input_id} {
	  upvar ps ps
	  array_clear options

	  # keine Meldung
    set options(0) "\${stringTableShutterContactMsgPosA2}"
    # zu
    set options(1) "\${stringTableShutterContactMsgPosA1}"
    # offen
    set options(2) "\${stringTableShutterContactMsgPosA3}"

    append s "[get_ComboBox options $param separate_${special_input_id}_$prn ps $param]"

    return $s
}

proc getSpecialValueHint {} {
  return "\${remoteModeEM8SpecialValHint}"
}

proc getPlaceholder {} {
  return "<tr><td><div style=\"width:250px;\"></div></td></tr>"
}

proc getButtonHTML {special_input_id} {
  upvar ps ps
  set html ""
  set transTryMax "${special_input_id}_tryMax"
  set mode "${special_input_id}_specialVal"
  set hint "${special_input_id}_specialValHint"

 	append html "<table class=\"ProfileTbl\">"
    append html [getPlaceholder]
    set prn 1
    set param CHANNEL_FUNCTION
    append html "<tr>"
      append html "<td>\${stringTableKeyChannelFunction}</td>"
      append html "<td>[getChannelFunction $param $prn $special_input_id]</td>"
    append html "</tr>"

    incr prn
    set param TRANSMIT_TRY_MAX
    append html "<tr id=\"$transTryMax\">"
      append html "<td>\${stringTableTransmitTryMax}</td>"
      append html "<td>[getTextField $param ${special_input_id}_$prn][getUnit $param]&nbsp;&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"

    incr prn
    set param LONG_PRESS_TIME
    append html "<tr name=\"$mode\">"
      append html "<td>\${stringTableCentralKeyLongPressTime}</td>"
      append html "<td>[getTextField $param ${special_input_id}_$prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
 	append html "</table>"

  append html "<div id=\"$hint\" class=\"hidden attention\" style=\"padding:2px;\">[getSpecialValueHint]</div>"
  append html "<script type=\"text/javascript\">translatePage('#' + '$hint');</script>"

  return $html
}

proc getSwitchInterfaceHTML {special_input_id} {
  upvar ps ps
  set html ""
  set transTryMax "${special_input_id}_tryMax"
  set mode "${special_input_id}_specialVal"
  set hint "${special_input_id}_specialValHint"

  append html "<table class=\"ProfileTbl\">"
    append html [getPlaceholder]
    set prn 1
    set param CHANNEL_FUNCTION
    append html "<tr>"
     append html "<td>\${stringTableKeyChannelFunction}</td>"
       append html "<td>[getChannelFunction $param $prn $special_input_id]</td>"
    append html "</tr>"

    incr prn
    set param TRANSMIT_TRY_MAX
    append html "<tr id=\"$transTryMax\">"
     append html "<td>\${stringTableTransmitTryMax}</td>"
     append html "<td>[getTextField $param ${special_input_id}_$prn][getUnit $param]&nbsp;&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"

  append html "</table>"

  append html "<div id=\"$hint\" class=\"hidden attention\" style=\"padding:2px;\">[getSpecialValueHint]</div>"
  append html "<script type=\"text/javascript\">translatePage('#' + '$hint');</script>"

  return $html
}

proc getShutterContactHTML {special_input_id} {
  upvar ps ps
  set html ""
  set transTryMax "${special_input_id}_tryMax"
  set mode "${special_input_id}_specialVal"
  set hint "${special_input_id}_specialValHint"

 	append html "<table class=\"ProfileTbl\">"
    append html [getPlaceholder]
    set prn 1
    set param CHANNEL_FUNCTION
    append html "<tr>"
     append html "<td>\${stringTableKeyChannelFunction}</td>"
       append html "<td>[getChannelFunction $param $prn $special_input_id]</td>"
    append html "</tr>"

    incr prn
    set param TRANSMIT_TRY_MAX
    append html "<tr id=\"$transTryMax\">"
     append html "<td>\${stringTableTransmitTryMax}</td>"
     append html "<td>[getTextField $param ${special_input_id}_$prn][getUnit $param]&nbsp;&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"

    incr prn
    set param MSG_FOR_POS_A
    append html "<tr name=$mode>"
     append html "<td>\${stringTableShutterContactMsgPosA0}</td>"
     append html "<td>[getMsg4Pos $param $prn ${special_input_id}]</td>"
    append html "</tr>"

    incr prn
    set param MSG_FOR_POS_B
    append html "<tr name=$mode>"
     append html "<td>\${stringTableShutterContactMsgPosB0}</td>"
     append html "<td>[getMsg4Pos $param $prn ${special_input_id}]</td>"
    append html "</tr>"

  append html "</table>"
  append html "<div id=\"$hint\" class=\"hidden attention\" style=\"padding:2px;\">[getSpecialValueHint]</div>"
  append html "<script type=\"text/javascript\">translatePage('#' + '$hint');</script>"

  return $html
}

proc getInactiveHTML {special_input_id} {
  upvar ps ps
  set html ""
  set hint "${special_input_id}_specialValHint"

 	append html "<table class=\"ProfileTbl\">"
    append html [getPlaceholder]
    set prn 1
    set param CHANNEL_FUNCTION
    append html "<tr>"
     append html "<td>\${stringTableKeyChannelFunction}</td>"
       append html "<td>[getChannelFunction $param $prn $special_input_id]</td>"
    append html "</tr>"
  append html "</table>"

  append html "<div id=\"$hint\" class=\"hidden attention\" style=\"padding:2px;\">[getSpecialValueHint]</div>"
  append html "<script type=\"text/javascript\">translatePage('#' + '$hint');</script>"

  return $html
}