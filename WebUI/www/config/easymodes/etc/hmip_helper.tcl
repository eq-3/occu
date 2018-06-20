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

      "eventDelay" {
        append s [getPanelA $prn $pref $specialElement]
      }

      "eventRandomTime" {
        append s [getPanelA $prn $pref $specialElement]
      }

      "txMinDelay" {
        append s [getPanelA $prn $pref $specialElement]
      }
      "delay0To20M_step2M" {
        append s [getDelay0to20M_step2M $prn $pref $specialElement]
      }

      "timeMin_10_15_20_25_30" {
        append s [getMin_10_15_20_25_30 $prn $pref $specialElement]
      }

      "timeOnOff" {
        append s [getTimeOnOff $prn $pref $specialElement]
      }

      "timeOnOffShort" {
        append s [getTimeOnOffShort $prn $pref $specialElement]
      }


      "rampOnOff" {
        append s [getRampOnOff $prn $pref $specialElement]
      }

      "switchingInterval" {
        append s [getSwitchingInterval $prn $pref $specialElement]
      }

      "switchingIntervalOnTime" {
        append s [getSwitchingIntervalOnTime $prn $pref $specialElement]
      }

      "blindRunningTime" {
        append s [getBlindRunningTime $prn $pref $specialElement]
      }

      "slatRunningTime" {
        append s [getSlatRunningTime $prn $pref $specialElement]
      }

      "alarmTimeMax10Min" {
        append s [getAlarmTimeMax10Min $prn $pref $specialElement]
      }

      "blink" {
        append s [getBlink $prn $pref $specialElement]
      }

    }

    return $s
}

proc getPanelA {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setPanelAValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit300MS}</option>"
        append s "<option value=\"3\">\${optionUnit500MS}</option>"
        append s "<option value=\"4\">\${optionUnit1500MS}</option>"
        append s "<option value=\"5\">\${optionUnit1S}</option>"
        append s "<option value=\"6\">\${optionUnit3S}</option>"
        append s "<option value=\"7\">\${optionUnit30S}</option>"
        append s "<option value=\"8\">\${optionUnit1M}</option>"
        append s "<option value=\"9\">\${optionUnit2M}</option>"
        append s "<option value=\"10\">\${optionUnit15M}</option>"
        append s "<option value=\"11\">\${optionUnit1H}</option>"
        append s "<option value=\"12\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayShortOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"03\"\] = 2;"
          append s "optionMap\[\"05\"\] = 3;"
          append s "optionMap\[\"010\"\] = 5;"
          append s "optionMap\[\"015\"\] = 4;"
          append s "optionMap\[\"11\"\] = 5;"
          append s "optionMap\[\"030\"\] = 6;"
          append s "optionMap\[\"13\"\] = 6;"
          append s "optionMap\[\"130\"\] = 7;"
          append s "optionMap\[\"41\"\] = 8;"
          append s "optionMap\[\"42\"\] = 9;"
          append s "optionMap\[\"415\"\] = 10;"
          append s "optionMap\[\"71\"\] = 11;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 12;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 12) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setPanelAValues = function(elmID, prn, pref, specialElement) {"
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
              # 300 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
           append s "case 4:"
              # 1.5 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 5:"
              # 1 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 6:"
              # 3 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 7:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 8:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 2 min
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 10:"
              # 15 min
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 11:"
              # 1 hour
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 12:"
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

proc getDelayShort {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelayShortValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit300MS}</option>"
        append s "<option value=\"3\">\${optionUnit500MS}</option>"
        append s "<option value=\"4\">\${optionUnit1500MS}</option>"
        append s "<option value=\"5\">\${optionUnit1S}</option>"
        append s "<option value=\"6\">\${optionUnit3S}</option>"
        append s "<option value=\"7\">\${optionUnit30S}</option>"
        append s "<option value=\"8\">\${optionUnit1M}</option>"
        append s "<option value=\"9\">\${optionUnit2M}</option>"
        append s "<option value=\"10\">\${optionUnit15M}</option>"
        append s "<option value=\"11\">\${optionUnit1H}</option>"
        append s "<option value=\"12\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayShortOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"03\"\] = 2;"
          append s "optionMap\[\"05\"\] = 3;"
          append s "optionMap\[\"010\"\] = 5;"
          append s "optionMap\[\"015\"\] = 4;"
          append s "optionMap\[\"11\"\] = 5;"
          append s "optionMap\[\"030\"\] = 6;"
          append s "optionMap\[\"13\"\] = 6;"
          append s "optionMap\[\"130\"\] = 7;"
          append s "optionMap\[\"41\"\] = 8;"
          append s "optionMap\[\"42\"\] = 9;"
          append s "optionMap\[\"415\"\] = 10;"
          append s "optionMap\[\"71\"\] = 11;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 12;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 12) {"
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
              # 300 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
           append s "case 4:"
              # 1.5 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 5:"
              # 1 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 6:"
              # 3 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 7:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 8:"
              # 1 min
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 10:"
              # 15 min
              append s "baseElem.val(4);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 11:"
              # 1 hour
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 12:"
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

proc getDelay0to20M_step2M {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelay0to20M_step2MValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit2M}</option>"
        append s "<option value=\"2\">\${optionUnit4M}</option>"
        append s "<option value=\"3\">\${optionUnit6M}</option>"
        append s "<option value=\"4\">\${optionUnit8M}</option>"
        append s "<option value=\"5\">\${optionUnit10M}</option>"
        append s "<option value=\"6\">\${optionUnit12M}</option>"
        append s "<option value=\"7\">\${optionUnit14M}</option>"
        append s "<option value=\"8\">\${optionUnit16M}</option>"
        append s "<option value=\"9\">\${optionUnit18M}</option>"
        append s "<option value=\"10\">\${optionUnit20M}</option>"

        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setDelay0to20M_step2MOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"40\"\] = 0;"
          append s "optionMap\[\"42\"\] = 1;"
          append s "optionMap\[\"44\"\] = 2;"
          append s "optionMap\[\"46\"\] = 3;"
          append s "optionMap\[\"48\"\] = 4;"
          append s "optionMap\[\"410\"\] = 5;"
          append s "optionMap\[\"412\"\] = 6;"
          append s "optionMap\[\"414\"\] = 7;"
          append s "optionMap\[\"416\"\] = 8;"
          append s "optionMap\[\"418\"\] = 9;"
          append s "optionMap\[\"420\"\] = 10;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 11;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 11) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setDelay0to20M_step2MValues = function(elmID, prn, pref, specialElement) {"
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
              # keine Einschaldauer
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 2:"
              # 4 min
              append s "baseElem.val(4);"
              append s "factorElem.val(4);"
              append s "break;"
            append s "case 3:"
              # 6 min
              append s "baseElem.val(4);"
              append s "factorElem.val(6);"
              append s "break;"
            append s "case 4:"
              # 8 min
              append s "baseElem.val(4);"
              append s "factorElem.val(8);"
              append s "break;"
            append s "case 5:"
              # 10 min
              append s "baseElem.val(4);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 6:"
              # 12 min
              append s "baseElem.val(4);"
              append s "factorElem.val(12);"
              append s "break;"
            append s "case 7:"
              # 14 min
              append s "baseElem.val(4);"
              append s "factorElem.val(14);"
              append s "break;"
            append s "case 8:"
              # 16 min
              append s "baseElem.val(4);"
              append s "factorElem.val(16);"
              append s "break;"
            append s "case 9:"
              # 18 min
              append s "baseElem.val(4);"
              append s "factorElem.val(18);"
              append s "break;"
            append s "case 10:"
              # 20 min
              append s "baseElem.val(4);"
              append s "factorElem.val(20);"
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

        append s "setCurrentDelayOption = function(prn, pref, specialElement, baseValue, factorValue) {"
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

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 11;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

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

proc getTimeOnOffShort {prn pref specialElement {extraparam ""}} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeOnOff\_$prn\_$pref\" onchange=\"setTimeValuesShort(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit300MS}</option>"
        append s "<option value=\"3\">\${optionUnit1S}</option>"
        append s "<option value=\"4\">\${optionUnit3S}</option>"
        append s "<option value=\"5\">\${optionUnit30S}</option>"
        append s "<option value=\"6\">\${optionUnit1M}</option>"
        append s "<option value=\"7\">\${optionUnit2M}</option>"
        append s "<option value=\"8\">\${optionUnit1H}</option>"
        append s "<option value=\"9\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentTimeShortOption = function(prn, pref, specialElement, baseValue, factorValue) {"

          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"03\"\] = 2;"
          append s "optionMap\[\"11\"\] = 3;"
          append s "optionMap\[\"030\"\] = 4;"
          append s "optionMap\[\"130\"\] = 5;"
          append s "optionMap\[\"21\"\] = 6;"
          append s "optionMap\[\"22\"\] = 7;"
          append s "optionMap\[\"31\"\] = 8;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 9;"
          append s "jQuery(\"#timeOnOff_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"ONTIME baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 9) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"


        append s "setTimeValuesShort = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref),"
          append s "factorElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn + \"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
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
              # 300 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 1 s
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 3 s Standard for min delay
              append s "baseElem.val(0);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 5:"
              # 30 s
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 6:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 7:"
              # 2 min
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 8:"
              # 1 h
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
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

        append s "setCurrentTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"

          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
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
          append s "optionMap\[\"45\"\] = 8;" ;# 5 Minutes - floor terminal block 6 or 10 channels
          append s "optionMap\[\"51\"\] = 8;" ;# 5 Minutes - all other devices
          append s "optionMap\[\"61\"\] = 9;"
          append s "optionMap\[\"63\"\] = 10;"
          append s "optionMap\[\"71\"\] = 11;"
          append s "optionMap\[\"72\"\] = 12;"
          append s "optionMap\[\"73\"\] = 13;"
          append s "optionMap\[\"75\"\] = 14;"
          append s "optionMap\[\"78\"\] = 15;"
          append s "optionMap\[\"712\"\] = 16;"
          append s "optionMap\[\"724\"\] = 17;"
          append s "optionMap\[\"731\"\] = 18;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() :jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"


          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 19;"
          append s "jQuery(\"#timeOnOff_\" + prn + \"_\" + pref).val(optionVal).change();"

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
          append s "factorElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn + \"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
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

proc getRampOnOff {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setRampOnOffValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit200MS}</option>"
        append s "<option value=\"2\">\${optionUnit500MS}</option>"
        append s "<option value=\"3\">\${optionUnit1S}</option>"
        append s "<option value=\"4\">\${optionUnit2S}</option>"
        append s "<option value=\"5\">\${optionUnit5S}</option>"
        append s "<option value=\"6\">\${optionUnit10S}</option>"
        append s "<option value=\"7\">\${optionUnit20S}</option>"
        append s "<option value=\"8\">\${optionUnit30S}</option>"
        append s "<option value=\"9\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentRampOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"02\"\] = 1;"
          append s "optionMap\[\"05\"\] = 2;"
          append s "optionMap\[\"010\"\] = 3;"
          append s "optionMap\[\"11\"\] = 3;"
          append s "optionMap\[\"020\"\] = 4;"
          append s "optionMap\[\"12\"\] = 4;"
          append s "optionMap\[\"15\"\] = 5;"
          append s "optionMap\[\"110\"\] = 6;"
          append s "optionMap\[\"120\"\] = 7;"
          append s "optionMap\[\"130\"\] = 8;"

          # append s "var baseVal = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          # append s "factorVal =   jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 9;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"RAMP baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 9) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setRampOnOffValues = function(elmID, prn, pref, specialElement) {"
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
              # 200 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 2:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 3:"
              # 1 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 2 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 5:"
              # 5 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 6:"
              # 10 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 7:"
              # 20 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(20);"
              append s "break;"
            append s "case 8:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 9:"
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

##

proc getSwitchingInterval {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setSwitchingIntervalValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit1D}</option>"
        append s "<option value=\"2\">\${optionUnit7D}</option>"
        append s "<option value=\"3\">\${optionUnit14D}</option>"
        append s "<option value=\"4\">\${optionUnit28D}</option>"

        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentSwitchingIntervalOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"70\"\] = 0;"
          append s "optionMap\[\"71\"\] = 1;"
          append s "optionMap\[\"77\"\] = 2;"
          append s "optionMap\[\"714\"\] = 3;"
          append s "optionMap\[\"728\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setSwitchingIntervalValues = function(elmID, prn, pref, specialElement) {"
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
              # 1 day
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 7 days
              append s "baseElem.val(7);"
              append s "factorElem.val(7);"
              append s "break;"
            append s "case 3:"
              # 14 days
              append s "baseElem.val(7);"
              append s "factorElem.val(14);"
              append s "break;"
            append s "case 4:"
              # 30 days
              append s "baseElem.val(7);"
              append s "factorElem.val(28);"
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


proc getSwitchingIntervalOnTime {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setSwitchingIntervalOnTimeValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit1M}</option>"
        append s "<option value=\"2\">\${optionUnit2M}</option>"
        append s "<option value=\"3\">\${optionUnit5M}</option>"
        append s "<option value=\"4\">\${optionUnit10M}</option>"

        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentSwitchingIntervalOnTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"41\"\] = 1;"
          append s "optionMap\[\"42\"\] = 2;"
          append s "optionMap\[\"45\"\] = 3;"
          append s "optionMap\[\"410\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setSwitchingIntervalOnTimeValues = function(elmID, prn, pref, specialElement) {"
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
              # keine Einschaldauer
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 1 min
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 3:"
              # 5 min
              append s "baseElem.val(4);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 4:"
              # 10 min
              append s "baseElem.val(4);"
              append s "factorElem.val(10);"
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


proc getBlindRunningTime {prn pref specialElement} {
      set helpRunningTime BLIND_REFERENCE_RUNNING_TIME

      set s ""
      append s "<td>"
        append s  "<select id=\"timeDelay\_$prn\_$pref\" name=\"presetsAutoCalibration\" onchange=\"setBlindRunningTimeValues(this.id, $prn, $pref, \'$specialElement\')\">"
          append s "<option value=\"0\">\${optionUnit30S}</option>"
          append s "<option value=\"1\">\${optionUnit45S}</option>"
          append s "<option value=\"2\">\${optionUnit60S}</option>"
          append s "<option value=\"3\">\${optionUnit90S}</option>"
          append s "<option value=\"4\">\${stringTableEnterValue}</option>"

        append s "/<select> "
        append s [getHelpIcon $helpRunningTime]
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentBlindRunningTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"230\"\] = 0;"
          append s "optionMap\[\"245\"\] = 1;"
          append s "optionMap\[\"260\"\] = 2;"
          append s "optionMap\[\"290\"\] = 3;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 4;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 4) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setBlindRunningTimeValues = function(elmID, prn, pref, specialElement) {"
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
              # 30 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 1:"
              # 45 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(45);"
              append s "break;"
            append s "case 2:"
              # 60 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(60);"
              append s "break;"
            append s "case 3:"
              # 90 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(90);"
              append s "break;"
            append s "case 4:"
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

proc getSlatRunningTime {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" name=\"presetsAutoCalibration\" onchange=\"setSlatRunningTimeValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionUnit1S}</option>"
        append s "<option value=\"1\">\${optionUnit2S}</option>"
        append s "<option value=\"2\">\${optionUnit3S}</option>"
        append s "<option value=\"3\">\${optionUnit4S}</option>"
        append s "<option value=\"4\">\${optionUnit5S}</option>"

        append s "<option value=\"5\">\${optionUnit10S}</option>"
        append s "<option value=\"6\">\${optionUnit15S}</option>"
        append s "<option value=\"7\">\${optionUnit20S}</option>"
        append s "<option value=\"8\">\${optionUnit25S}</option>"
        append s "<option value=\"9\">\${optionUnit30S}</option>"
        append s "<option value=\"10\">\${stringTableEnterValue}</option>"

      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentSlatRunningTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"21\"\] = 0;"
          append s "optionMap\[\"22\"\] = 1;"
          append s "optionMap\[\"23\"\] = 2;"
          append s "optionMap\[\"24\"\] = 3;"
          append s "optionMap\[\"25\"\] = 4;"
          append s "optionMap\[\"210\"\] = 5;"
          append s "optionMap\[\"215\"\] = 6;"
          append s "optionMap\[\"220\"\] = 7;"
          append s "optionMap\[\"225\"\] = 8;"
          append s "optionMap\[\"230\"\] = 9;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 10;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 10) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setSlatRunningTimeValues = function(elmID, prn, pref, specialElement) {"
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
              # 1 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 1:"
              # 2 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 2:"
              # 3 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 4 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(4);"
              append s "break;"
            append s "case 4:"
              # 5 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 5:"
              # 10 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 6:"
              # 15 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 7:"
              # 20 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(20);"
              append s "break;"
            append s "case 8:"
              # 25 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(25);"
              append s "break;"
            append s "case 9:"
              # 30 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 10:"
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

proc getMin_10_15_20_25_30 {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setMin_10_15_20_25_30Values(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionUnit10M}</option>"
        append s "<option value=\"1\">\${optionUnit15M}</option>"
        append s "<option value=\"2\">\${optionUnit20M}</option>"
        append s "<option value=\"3\">\${optionUnit25M}</option>"
        append s "<option value=\"4\">\${optionUnit30M}</option>"

        append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentTimeMin_10_15_20_25_30Option = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"210\"\] = 0;"
          append s "optionMap\[\"215\"\] = 1;"
          append s "optionMap\[\"220\"\] = 2;"
          append s "optionMap\[\"225\"\] = 3;"
          append s "optionMap\[\"230\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setMin_10_15_20_25_30Values = function(elmID, prn, pref, specialElement) {"
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
              # 10 min
              append s "baseElem.val(2);"
              append s "factorElem.val(10);"
              append s "break;"

            append s "case 1:"
              # 15 min
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 2:"
              # 20 min
              append s "baseElem.val(2);"
              append s "factorElem.val(20);"
              append s "break;"
            append s "case 3:"
              # 25 min
              append s "baseElem.val(2);"
              append s "factorElem.val(25);"
              append s "break;"
            append s "case 4:"
              # 30 min
              append s "baseElem.val(2);"
              append s "factorElem.val(30);"
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

proc getAlarmTimeMax10Min {prn pref specialElement} {
  set s ""
  append s "<td>"
  append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setAlarmTimeMax10MinValues(this.id, $prn, $pref, \'$specialElement\')\">"
    append s "<option value=\"0\">\${optionUnit1S}</option>"
    append s "<option value=\"1\">\${optionUnit5S}</option>"
    append s "<option value=\"2\">\${optionUnit10S}</option>"
    append s "<option value=\"3\">\${optionUnit30S}</option>"
    append s "<option value=\"4\">\${optionUnit1M}</option>"
    append s "<option value=\"5\">\${optionUnit2M}</option>"
    append s "<option value=\"6\">\${optionUnit4M}</option>"
    append s "<option value=\"7\">\${optionUnit5M}</option>"
    append s "<option value=\"8\">\${optionUnit6M}</option>"
    append s "<option value=\"9\">\${optionUnit8M}</option>"
    append s "<option value=\"10\">\${optionUnit10M}</option>"

    # Hide the next value because the max value should not exceed 10 minutes
    # append s "<option value=\"11\">\${stringTableEnterValue}</option>"
  append s "/<select>"
  append s "</td>"

  append s "<script type=\"text/javascript\">"

    append s "setCurrentAlarmTimeMax10MinOption = function(prn, pref, specialElement, baseValue, factorValue) {"
      append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
      append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
      append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

      append s "var optionMap = \[\];"
      append s "optionMap\[\"11\"\] = 0;"
      append s "optionMap\[\"15\"\] = 1;"
      append s "optionMap\[\"110\"\] = 2;"
      append s "optionMap\[\"130\"\] = 3;"
      append s "optionMap\[\"41\"\] = 4;"

      append s "optionMap\[\"42\"\] = 5;"
      append s "optionMap\[\"44\"\] = 6;"
      append s "optionMap\[\"45\"\] = 7;"
      append s "optionMap\[\"46\"\] = 8;"
      append s "optionMap\[\"48\"\] = 9;"
      append s "optionMap\[\"61\"\] = 10;"

      append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
      append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

      append s "currentVal = baseVal+factorVal,"
      append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 11;"
      append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

      # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

      # Enter user value
      append s "if (optionVal == 11) {"
        append s "timeBaseTRElem.show();"
        append s "timeFactorTRElem.show();"
        append s "spaceTRElem.show();"
      append s "}"

    append s "};"

    append s "setAlarmTimeMax10MinValues = function(elmID, prn, pref, specialElement) {"
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
          # 1 s
          append s "baseElem.val(1);"
          append s "factorElem.val(1);"
          append s "break;"

        append s "case 1:"
          # 5 sec
          append s "baseElem.val(1);"
          append s "factorElem.val(5);"
          append s "break;"
        append s "case 2:"
          # 10 sec
          append s "baseElem.val(1);"
          append s "factorElem.val(10);"
          append s "break;"
        append s "case 3:"
          # 30 sec
          append s "baseElem.val(1);"
          append s "factorElem.val(30);"
          append s "break;"
        append s "case 4:"
          # 1 min
          append s "baseElem.val(4);"
          append s "factorElem.val(1);"
          append s "break;"
        append s "case 5:"
          # 2 min
          append s "baseElem.val(4);"
          append s "factorElem.val(2);"
          append s "break;"
        append s "case 6:"
          # 4 min
          append s "baseElem.val(4);"
          append s "factorElem.val(4);"
          append s "break;"
        append s "case 7:"
          # 5 min
          append s "baseElem.val(4);"
          append s "factorElem.val(5);"
          append s "break;"
        append s "case 8:"
          # 6 min
          append s "baseElem.val(4);"
          append s "factorElem.val(6);"
          append s "break;"
        append s "case 9:"
          # 8 min
          append s "baseElem.val(4);"
          append s "factorElem.val(8);"
          append s "break;"
        append s "case 10:"
          # 10 min
          append s "baseElem.val(6);"
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

proc getBlink {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setBlinkOptions(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionUnit100MS}</option>"
        append s "<option value=\"1\">\${optionUnit500MS}</option>"
        append s "<option value=\"2\">\${optionUnit1S}</option>"
        append s "<option value=\"3\">\${optionUnit2S}</option>"
        append s "<option value=\"4\">\${optionUnit5S}</option>"
        append s "<option value=\"5\">\${stringTableEnterValue}</option>"

        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentBlinkOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"01\"\] = 0;"
          append s "optionMap\[\"05\"\] = 1;"
          append s "optionMap\[\"11\"\] = 2;"
          append s "optionMap\[\"12\"\] = 3;"
          append s "optionMap\[\"15\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setBlinkOptions = function(elmID, prn, pref, specialElement) {"
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
              # 100ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"

            append s "case 1:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 2:"
              # 1 s
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 3:"
              # 2 s
              append s "baseElem.val(1);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 4:"
              # 5 s
              append s "baseElem.val(1);"
              append s "factorElem.val(5);"
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

##

proc trimParam {param} {
  set s [string trimleft $param ']
  set s [string trimright $s ']
  return $s
}

proc getTimeUnitComboBox {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
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
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnitComboBoxB {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit1S}</option>"
        append s "<option value='1'>\${optionUnit5S}</option>"
        append s "<option value='2'>\${optionUnit10S}</option>"
        append s "<option value='3'>\${optionUnit1M}</option>"
        append s "<option value='4'>\${optionUnit5M}</option>"
        append s "<option value='5'>\${optionUnit10M}</option>"
        append s "<option value='6'>\${optionUnitH}</option>"
        append s "<option value='7'>\${optionUnit1D}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}


proc getTimeUnitComboBoxShort {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set trName ""
  set specialVal0 ""
  set specialVal1 ""

  if {[string equal $extraparam ""] != 1} {
    set specialVal0 [lindex [split $extraparam =] 0]
    set specialVal1 [lindex [split $extraparam =] 1]

    if {[string equal $specialVal0 "trNAME"] != -1 } {
      set trName name=$specialVal1
    }
  }

  set s "<tr $trName id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnitS}</option>"
        append s "<option value='2'>\${optionUnitM}</option>"
        append s "<option value='3'>\${optionUnitH}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnit10ms_100ms_1s_10s {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit10MS}</option>"
        append s "<option value='1'>\${optionUnit100MS}</option>"
        append s "<option value='2'>\${optionUnitS}</option>"
        append s "<option value='3'>\${optionUnit10S}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getDescription {param {extraparam ""}} {
  set result $param
  set desc(REPEATED_LONG_PRESS_TIMEOUT_UNIT) "stringTableKeyLongPressTimeOutUnit"
  set desc(EVENT_DELAY_UNIT) "stringTableEventDelayUnit"
  set desc(EVENT_RANDOMTIME_UNIT) "stringTableEventRandomTimeUnit"
  set desc(POWERUP_ONDELAY_UNIT) "stringTableOnDelayUnit"
  set desc(POWERUP_OFFDELAY_UNIT) "stringTableOffDelayUnit"
  set desc(POWERUP_ONTIME_UNIT) "stringTableOnTimeUnit"
  set desc(POWERUP_OFFTIME_UNIT) "stringTableOffTimeUnit"
  set desc(ON_TIME_BASE) "stringTableOnTimeUnit"
  set desc(SWITCHING_INTERVAL_BASE) "stringTableSwitchingIntervalBase"
  set desc(TX_MINDELAY_UNIT) "stringTableTxMinDelayUnit"
  set desc(REFERENCE_RUNNING_TIME_BOTTOM_TOP_UNIT) "stringTableTimeBottomTopUnit"
  set desc(REFERENCE_RUNNING_TIME_TOP_BOTTOM_UNIT) "stringTableTimeTopBottomUnit"
  set desc(REFERENCE_RUNNING_TIME_SLATS_UNIT) "stringTableTimeSlatsUnit"
  set desc(BLOCKING_PERIOD_UNIT) "stringTableBlockingPeriodUnit"

  # Special handling of parameters
  if {[string equal $extraparam 'rainDrop'] != 1} {
    set desc(EVENT_BLINDTIME_BASE) "stringTableEventBlindTimeBase"
  } else {
    # special for rain recognition
    set desc(EVENT_BLINDTIME_BASE) "eventTimeoutBaseRainDrop"
  }

  if {[string equal $extraparam 'rainCounter'] != 1} {
    set desc(EVENT_TIMEOUT_BASE) "stringTableEventTimeoutBase"
  } else {
    # special for rain counter
    set desc(EVENT_TIMEOUT_BASE) "eventTimeoutBaseRainCounter"
  }

  if {[catch {set result $desc($param)}]} {
   return $result
  }
  return $result
}

proc getCondTXThresholdUnit {devType chn} {
   switch $devType {
        PSM  {return "mW"}
        BSM  {return "mW"}
        STHO  {
          if {$chn == "2"} {return "°C"}
          if {$chn == "3"} {return "%"}
        }
      default {return ""}
    }
}

proc getMaintenanceAddress {channelAddress} {
  set parentAddress [lindex [split $channelAddress :] 0]
  return "$parentAddress:0"
}

proc getChannel {special_input_id} {
  return [lindex [split $special_input_id _] 1]
}

proc getSpecialID {special_input_id} {
    return "[lindex [split $special_input_id _] 0]"
}

proc isLongKeypressAvailable {sender sender_address url} {

  # Here we check for certain device types without a long keypress.
  set devWithoutLongKeyPress {
    HmIP-ASIR HmIP-DRI16 HmIPW-DRI32
  }

  foreach item $devWithoutLongKeyPress {
    if {$item == $sender} {return false}
  }

  # Here we test for all devices with a long keypress available, if the config parameter LONG_PRESS_TIME is set to a value == 0.
  # If true, the long keypress doesn't work and should not be available for easymode profiles.
  set result true
  catch {
    array set sender_ch_ps [xmlrpc $url getParamset $sender_address MASTER]
    if {$sender_ch_ps(LONG_PRESS_TIME) == 0.000000} {
      set result false
    }
  }
  return $result
}

proc getDevFirmware {} {
  global dev_descr
  return $dev_descr(FIRMWARE)
}

proc getDevFwMajorMinorPatch {} {
  global dev_descr

  # Firmware = x.y.z
  set firmWare $dev_descr(FIRMWARE)
  set fwMajorMinorPatch [split $firmWare .]

  set fw {}

  lappend fw [expr [lindex $fwMajorMinorPatch 0] * 1]
  lappend fw [expr [lindex $fwMajorMinorPatch 1] * 1]
  lappend fw [expr [lindex $fwMajorMinorPatch 2] * 1]

  return $fw
}


# This can be used to return the original parameter name of a translation key
proc extractParamFromTranslationKey {key} {

  # A parameter key looks like ${thisIsTheKey}
  # Here we remove the leading '${' and the trailing '}' so that we have the clean key
  set key [string trim [string trim $key "\$\{"] "\}"]

  set ret ""
  switch $key {
    "channelModeTactileSwitch" {set ret TACTILE_SWITCH_INPUT}
  }
  return $ret
}

# Some wall thermostats don't have a humidity sensor.
# We have to consider this in some easymodes.
# With this function you can maintain a list of such devices.
proc hasSenderHumiditySensor {} {
  global dev_descr_sender
  set senderType $dev_descr_sender(PARENT_TYPE)
  set result true

  # List with thermostats without a humidity sensor
  set devHasNoHumiditySensor {ALPHA-IP-RBGa}

  foreach val $devHasNoHumiditySensor {
    if {$val == $senderType} {
      set result false
    }
  }
  return $result
}