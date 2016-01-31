#!/bin/tclsh


# type = 'delay' or 'timeOnOff'
# base = Unit, factor = value
proc getComboBox {prn pref specialElement type} {
    global psDescr
    upvar ps ps
    set s ""

    switch $type {
      "delay" {
        append s [getDelay $prn $pref $specialElement]
      }

      "delayShort" {
        append s [getDelayShort $prn $pref $specialElement]
      }

      "timeOnOff" {
        append s [getTimeOnOff $prn $pref $specialElement]
      }

      "timeOnOffShort" {
        append s [getTimeOnOffShort $prn $pref $specialElement]
      }
    }

    return $s
}

proc getDelayShort {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelayShortValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit3S}</option>"
        append s "<option value=\"3\">\${optionUnit1M}</option>"
        append s "<option value=\"4\">\${optionUnit1H}</option>"
        append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayShortOption = function(prn, pref, specialElement) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"030\"\] = 2;"
          append s "optionMap\[\"21\"\] = 3;"
          append s "optionMap\[\"31\"\] = 4;"

          append s "var baseVal = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal =   jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"
          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setDelayShortValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 3 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 3:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 1 hour
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 5:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s

}

# Returns a option list with values for the ontime delay, offtime delay and so on

proc getDelay {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelayValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit5S}</option>"
        append s "<option value=\"3\">\${optionUnit10S}</option>"
        append s "<option value=\"4\">\${optionUnit30S}</option>"
        append s "<option value=\"5\">\${optionUnit1M}</option>"
        append s "<option value=\"6\">\${optionUnit2M}</option>"
        append s "<option value=\"7\">\${optionUnit5M}</option>"
        append s "<option value=\"8\">\${optionUnit10M}</option>"
        append s "<option value=\"9\">\${optionUnit30M}</option>"
        append s "<option value=\"10\">\${optionUnit1H}</option>"
        append s "<option value=\"11\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayOption = function(prn, pref, specialElement) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"21\"\] = 2;"
          append s "optionMap\[\"31\"\] = 3;"
          append s "optionMap\[\"33\"\] = 4;"
          append s "optionMap\[\"41\"\] = 5;"
          append s "optionMap\[\"42\"\] = 6;"
          append s "optionMap\[\"45\"\] = 7;"
          append s "optionMap\[\"61\"\] = 8;"
          append s "optionMap\[\"63\"\] = 9;"
          append s "optionMap\[\"71\"\] = 10;"

          append s "var baseVal = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal =   jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"
          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 11;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 11) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setDelayValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 5 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 3:"
              # 10 sec
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 30 sec
              append s "baseElem.val(3);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 5:"
              # 1 min
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 6:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 7:"
              # 5 min
              append s "baseElem.val(4);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 8:"
              # 10 min
              append s "baseElem.val(6);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 30 min
              append s "baseElem.val(6);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 10:"
              # 1h
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 11:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s

}

proc getTimeOnOffShort {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeOnOff\_$prn\_$pref\" onchange=\"setTimeValuesShort(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit3S}</option>"
        append s "<option value=\"3\">\${optionUnit1M}</option>"
        append s "<option value=\"4\">\${optionUnit1H}</option>"
        append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentTimeShortOption = function(prn, pref, specialElement) {"

          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"030\"\] = 2;"
          append s "optionMap\[\"21\"\] = 3;"
          append s "optionMap\[\"31\"\] = 4;"

          append s "var baseVal = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal =   jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"
          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "jQuery(\"#timeOnOff_\" + prn + \"_\" + pref).val(optionVal);"

          #append s "console.log(\"ONTIME baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"


        append s "setTimeValuesShort = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref),"
          append s "factorElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref + 1))),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn + \"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + parseInt(pref + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # not in use
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 3 s Standard for min delay
              append s "baseElem.val(0);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 3:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 1 h
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 5:"
              # Wert eingeben
               append s "timeBaseTRElem.show();"
               append s "timeFactorTRElem.show();"
               append s "spaceTRElem.show();"
              append s "break;"


            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"
      return $s
}

# Returns a option list with values for the ontime delay, offtime delay and so on
proc getTimeOnOff {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeOnOff\_$prn\_$pref\" onchange=\"setTimeValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit1S}</option>"
        append s "<option value=\"2\">\${optionUnit2S}</option>"
        append s "<option value=\"3\">\${optionUnit5S}</option>"
        append s "<option value=\"4\">\${optionUnit10S}</option>"
        append s "<option value=\"5\">\${optionUnit30S}</option>"
        append s "<option value=\"6\">\${optionUnit1M}</option>"
        append s "<option value=\"7\">\${optionUnit2M}</option>"
        append s "<option value=\"8\">\${optionUnit5M}</option>"
        append s "<option value=\"9\">\${optionUnit10M}</option>"
        append s "<option value=\"10\">\${optionUnit30M}</option>"
        append s "<option value=\"11\">\${optionUnit1H}</option>"
        append s "<option value=\"12\">\${optionUnit2H}</option>"
        append s "<option value=\"13\">\${optionUnit3H}</option>"
        append s "<option value=\"14\">\${optionUnit5H}</option>"
        append s "<option value=\"15\">\${optionUnit8H}</option>"
        append s "<option value=\"16\">\${optionUnit12H}</option>"
        append s "<option value=\"17\">\${optionUnit24H}</option>"
        append s "<option value=\"18\">\${stringTablePermanent}</option>"
        append s "<option value=\"19\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentTimeOption = function(prn, pref, specialElement) {"

          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + parseInt(pref) + 1),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"11\"\] = 1;"
          append s "optionMap\[\"12\"\] = 2;"
          append s "optionMap\[\"21\"\] = 3;"
          append s "optionMap\[\"31\"\] = 4;"
          append s "optionMap\[\"33\"\] = 5;"
          append s "optionMap\[\"41\"\] = 6;"
          append s "optionMap\[\"42\"\] = 7;"
          append s "optionMap\[\"51\"\] = 8;"
          append s "optionMap\[\"61\"\] = 9;"
          append s "optionMap\[\"61\"\] = 10;"
          append s "optionMap\[\"71\"\] = 11;"
          append s "optionMap\[\"72\"\] = 12;"
          append s "optionMap\[\"73\"\] = 13;"
          append s "optionMap\[\"75\"\] = 14;"
          append s "optionMap\[\"78\"\] = 15;"
          append s "optionMap\[\"712\"\] = 16;"
          append s "optionMap\[\"724\"\] = 17;"
          append s "optionMap\[\"731\"\] = 18;"

          append s "var baseVal = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal =   jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"
          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 19;"
          append s "jQuery(\"#timeOnOff_\" + prn + \"_\" + pref).val(optionVal);"

          #append s "console.log(\"ONTIME baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"


          # Enter user value
          append s "if (optionVal == 19) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"


        append s "setTimeValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref),"
          append s "factorElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref + 1))),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn + \"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + parseInt(pref + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # not in use
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 1 s
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 2 s
              append s "baseElem.val(1);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 3:"
              # 5 s
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 10 s
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 5:"
              # 30 s
              append s "baseElem.val(3);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 6:"
              # 1 m
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 7:"
              # 2 m
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 8:"
              # 5 m
              append s "baseElem.val(5);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 10 m
              append s "baseElem.val(6);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 10:"
              # 30 m
              append s "baseElem.val(6);"
              append s "factorElem.val(3);"
              append s "break;"

            append s "case 11:"
              # 1 h
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 12:"
              # 2 h
              append s "baseElem.val(7);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 13:"
              # 3 h
              append s "baseElem.val(7);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 14:"
              # 5 h
              append s "baseElem.val(7);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 15:"
              # 8 h
              append s "baseElem.val(7);"
              append s "factorElem.val(8);"
              append s "break;"
            append s "case 16:"
              # 12 h
              append s "baseElem.val(7);"
              append s "factorElem.val(12);"
              append s "break;"
            append s "case 17:"
              # 24 h
              append s "baseElem.val(7);"
              append s "factorElem.val(24);"
              append s "break;"
            append s "case 18:"
              # Unendlich
              append s "baseElem.val(7);"
              append s "factorElem.val(31);"
              append s "break;"
            append s "case 19:"
              # Wert eingeben
               append s "timeBaseTRElem.show();"
               append s "timeFactorTRElem.show();"
               append s "spaceTRElem.show();"
              append s "break;"

            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"
      return $s
}

proc getTimeUnitComboBox {param value chn prn special_input_id} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'
  #set s "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\">"

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnit1S}</option>"
        append s "<option value='2'>\${optionUnit5S}</option>"
        append s "<option value='3'>\${optionUnit10S}</option>"
        append s "<option value='4'>\${optionUnit1M}</option>"
        append s "<option value='5'>\${optionUnit5M}</option>"
        append s "<option value='6'>\${optionUnit10M}</option>"
        append s "<option value='7'>\${optionUnitH}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
  append s "</script>"
  return $s
}