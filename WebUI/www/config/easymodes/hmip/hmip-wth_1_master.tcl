#!/bin/tclsh

#Kanal-EasyMode!

#source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join /www/config/easymodes/em_common.tcl]

#Namen der EasyModes tauchen nicht mehr auf. Der Durchg�ngkeit werden sie hier noch definiert.
set PROFILES_MAP(0)  "Experte"
set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"

proc getCheckBox {type param value prn} {
  set checked ""
  if { $value } then { set checked "checked=\"checked\"" }
  set s "<input id='separate_$type\_$prn' type='checkbox' $checked value='dummy' name=$param/>"
  return $s
}

proc getMinValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min [format {%1.1f} $param_descr(MIN)]
  return "$min"
}

proc getMaxValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set max [format {%1.1f} $param_descr(MAX)]
  return "$max"
}

proc getTextField {type param value prn} {
  set elemId 'separate_$type\_$prn'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param>"
  return $s
}

proc getUnit {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)

  if {$unit == "minutes"} {
   set unit "\${lblMinutes}"
  }

  # TODO ??C and °C
  if {($unit == "K") || ($unit == "??C") || ($unit == "°C")} {
    set unit "&#176;C"
  }

  return "$unit"
}

proc getMinMaxValueDescr {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min $param_descr(MIN)
  set max $param_descr(MAX)

  # Limit float to 2 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.2f} $min]
    set max [format {%1.2f} $max]
  }
  return "($min - $max)"
}

proc getHelpIcon {topic x y} {
  set ret "<img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:18px; height:18px; position:relative; top:2px\" onclick=\"showParamHelp('$topic', '$x', '$y')\">"
  return $ret
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url
  
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN_HELP.js');</script>"

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    psDescr
  
  #upvar PROFILE_0     PROFILE_0
  upvar PROFILE_1     PROFILE_1

  set CHANNEL $special_input_id

  set hlpBoxWidth 450
  set hlpBoxHeight 160

  foreach val [array names psDescr] {
    #puts "$val: $psDescr($val)\n"
  }

  puts "<script type=\"text/javascript\">"
    puts "ShowActiveWeeklyProgram = function(activePrg) {"
      puts " for (var i = 1; i <= 3; i++) {"
        puts "jQuery('#P' + i + '_Timeouts_Area').hide();"
      puts " }"
      puts " jQuery('#P' + activePrg + '_Timeouts_Area').show();"
    puts "};"

    puts "setDisplayMode = function(elem) {"
      puts "var mode = jQuery(elem).val();"
      puts "modeElem = jQuery(\".j_showHumidity\");"
      puts "if (mode == 0) {"
        puts "jQuery(modeElem).show();"
      puts "} else {jQuery(modeElem).hide();}"
    puts "};"
  puts "</script>"

  set prn 0

  set param WEEK_PROGRAM_POINTER
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    append HTML_PARAMS(separate_1) "<td class='hidden'><input type='text' id='separate_$CHANNEL\_$prn' name='$param'></td>"
    append HTML_PARAMS(separate_1) "</tr>"

    # left
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">\${stringTableWeekProgramToEdit}</td>"
      #append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param "onchange=\"ShowActiveWeeklyProgram(parseInt(\$(this).value)+1);\""][getHelpIcon $param [expr $hlpBoxWidth * 0.8] [expr $hlpBoxHeight / 2]]</td>"
      append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">"
        append HTML_PARAMS(separate_1) "<select id=\"editProgram\" onchange=\"ShowActiveWeeklyProgram(parseInt(\$(this).value)+1);\">"
          append HTML_PARAMS(separate_1) "<option value='0'>\${stringTableWeekProgram1}</option>"
          append HTML_PARAMS(separate_1) "<option value='1'>\${stringTableWeekProgram2}</option>"
          append HTML_PARAMS(separate_1) "<option value='2'>\${stringTableWeekProgram3}</option>"
      append HTML_PARAMS(separate_1) "</select>[getHelpIcon $param [expr $hlpBoxWidth * 0.8] [expr $hlpBoxHeight / 2]]"
      append HTML_PARAMS(separate_1) "</td>"
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  ## Create 3 Weekly Programs ##

  for {set loop 1} {$loop <=3} {incr loop} {
    set pNr "P$loop";
    append HTML_PARAMS(separate_1) "<div id=\"$pNr\_Timeouts_Area\" style=\"display:none\">"
    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {
      append HTML_PARAMS(separate_1) "<div id=\"$pNr\_temp_prof_$day\"></div>"
    }
    append HTML_PARAMS(separate_1) "</div>"

    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "$pNr\_tom = new TimeoutManager('$iface', '$address', false, '$pNr\_');"
    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {

      for {set i 1} {$i <= 13} {incr i} {

        set timeout     $ps($pNr\_ENDTIME_${day}_$i)
        set temperature $ps($pNr\_TEMPERATURE_${day}_$i)
        append HTML_PARAMS(separate_1) "$pNr\_tom.setTemp('$day', $timeout, $temperature);"

        if {$timeout == 1440} then {
          break;
        }
      }

      append HTML_PARAMS(separate_1) "$pNr\_tom.setDivname('$day', '$pNr\_temp_prof_$day');"
      append HTML_PARAMS(separate_1) "$pNr\_tom.writeDay('$day');"
    }
    append HTML_PARAMS(separate_1) "</script>"
  }

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">ShowActiveWeeklyProgram(1);</script>"

  append HTML_PARAMS(separate_1) "<hr>"

  # *************** #

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    # left
    incr prn
    set param SHOW_SET_TEMPERATURE
    array_clear options
    set options(0) "\${stringTableClimateControlRegDisplayTempInfoActualTemp}"
    set options(1) "\${stringTableClimateControlRegDisplayTempInfoSetPoint}"

    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">\${stringTableClimateControlRegDisplayTempInfo}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param onchange=\"setDisplayMode(this)\"]</td>"

    array_clear options
    set options(0) "\${stringTableClimateControlRegDisplayTempHumT}"
    set options(1) "\${stringTableClimateControlRegDisplayTempHumTH}"

    # right
    incr prn
    set param SHOW_HUMIDITY
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"hidden j_showHumidity\">\${stringTableClimateControlRegDisplayTempHum}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"hidden j_showHumidity\">[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    # left
    incr prn
    set param BUTTON_RESPONSE_WITHOUT_BACKLIGHT
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableButtonResponseWithoutBacklight}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">"
    append HTML_PARAMS(separate_1) "[getCheckBox $CHANNEL '$param' $ps($param) $prn]"
    append HTML_PARAMS(separate_1) "</td>"
    append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<hr>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

  set comment {

    # The parameter TEMPERATURE_COMFORT and TEMPERATURE_LOWERING are not in use with the HmIP WTH
    # They are available for historical reasons but cannot be used. So we don't show them.
    # left
    incr prn
    set param TEMPERATURE_COMFORT
    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureComfort}</td>"
    append HTML_PARAMS(separate_1)  "<td>[getTextField $CHANNEL $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
    append HTML_PARAMS(separate_1) "</script>"

    # right
    incr prn
    set param TEMPERATURE_LOWERING
    append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureLowering}</td>"
    append HTML_PARAMS(separate_1)  "<td>[getTextField $CHANNEL $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]<input id=\"ecoOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
    append HTML_PARAMS(separate_1) "</script>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<tr id=\"errorRow\" class=\"hidden\"> <td></td> <td colspan=\"2\"><span id=\"errorComfort\" class=\"attention\"></span></td> <td colspan=\"2\"><span id=\"errorEco\" class=\"attention\"></span></td> </tr>"
  }
    # left
    incr prn
    set param TEMPERATURE_MINIMUM
    array_clear options
    set i 0
    for {set val [getMinValue $param]} {$val <= [getMaxValue $param]} {set val [expr $val + 0.5]} {
      set options($i) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureMinimum}</td>"
    append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$CHANNEL\_$prn ps $param onchange=setMinMaxTemp('tmp_$CHANNEL\_$prn','separate_$CHANNEL\_$prn')]</span> <span class='hidden'>[getTextField $CHANNEL '$param' $ps($param) $prn]</span></td>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "setMinMaxTempOption('tmp_$CHANNEL\_$prn', 'separate_$CHANNEL\_$prn' );"
    append HTML_PARAMS(separate_1) "</script>"

    # right
    incr prn
    set param TEMPERATURE_MAXIMUM
    array_clear options
    set i 0
    for {set val [getMinValue $param]} {$val <= [getMaxValue $param]} {set val [expr $val + 0.5]} {
      set options($i) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureMaximum}</td>"
    append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$CHANNEL\_$prn ps $param onchange=setMinMaxTemp('tmp_$CHANNEL\_$prn','separate_$CHANNEL\_$prn')]</span> <span class='hidden'>[getTextField $CHANNEL '$param' $ps($param) $prn]</span></td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "setMinMaxTempOption('tmp_$CHANNEL\_$prn', 'separate_$CHANNEL\_$prn' );"
    append HTML_PARAMS(separate_1) "</script>"
    append HTML_PARAMS(separate_1) "<tr>"

    set param MIN_MAX_VALUE_NOT_RELEVANT_FOR_MANU_MODE
    if { ! [catch {set tmp $ps($param)}]  } {
      # In older versions this parameter is not available
      incr prn
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableMinMaxNotRelevantForManuMode}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">"
      append HTML_PARAMS(separate_1) "[getCheckBox $CHANNEL '$param' $ps($param) $prn]"
      append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"
    }

    append HTML_PARAMS(separate_1) "</table>"

    append HTML_PARAMS(separate_1) "<hr>"

    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    # left
    incr prn
    set param TEMPERATURE_OFFSET
    array_clear options
    set i 0
    for {set val -3.5} {$val <= 3.5} {set val [expr $val + 0.5]} {
      set options($val) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureOffset}</td>"
    append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    #left
    incr prn
    set param TEMPERATURE_WINDOW_OPEN
    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureFallWindowOpen}</td>"
    append HTML_PARAMS(separate_1)  "<td>[getTextField $CHANNEL $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
    append HTML_PARAMS(separate_1) "</script>"
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<hr>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    # left
    incr prn
    set param BOOST_TIME_PERIOD
    array_clear options
    set i 0
    for {set val 0} {$val <= 30} {incr val 5} {
        set options($val) "$val min"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableBoostTimePeriod}</td>"
    append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
    append HTML_PARAMS(separate_1) "</td>"

  set comment {
    # right
    incr prn
    set param BOOST_POSITION
    array_clear options
    set i 0
    for {set val 0} {$val <= 100} {incr val 10} {
        set options($val) "$val %"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableBoostPosition}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
    append HTML_PARAMS(separate_1) "</td>"
  }
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  if {[session_is_expert]} {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").show();"
      append HTML_PARAMS(separate_1) "setDisplayMode(jQuery(\"\[name='SHOW_SET_TEMPERATURE'\]\").first());"
    append HTML_PARAMS(separate_1) "</script>"
  } else {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").hide();"
    append HTML_PARAMS(separate_1) "</script>"
  }
  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setDisplayMode(jQuery(\"\[name='SHOW_SET_TEMPERATURE'\]\").first());</script>"

}

constructor
