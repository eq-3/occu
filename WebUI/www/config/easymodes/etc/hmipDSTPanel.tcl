#!/bin/tclsh

puts "<script type=\"text/javascript\">getLangInfo_Special('DaylightSavingTime.txt');</script>"


proc getDSTTimeElem {param value chn prn} {
  set hr [expr {int([expr $value/60])}]
  set min [expr {int([expr {fmod($value,60)}])}]

  if {$hr < 10} {set hr "0$hr"}
  if {$min < 10} {set min "0$min"}

  set hrElm "<input id=\"hr\_$chn\_$prn\" type=\"text\" size=\"2\" value=$hr onchange=\"ConvertTimeToMin($chn, $prn, '$param')\">"
  #set minElm "<input id=\"min\_$chn\_$prn\" type=\"text\" size=\"2\" value=$min onchange=\"ConvertTimeToMin($chn, $prn)\" >"
  set minElm "<select id=\"min\_$chn\_$prn\" value=$min onchange=\"ConvertTimeToMin($chn, $prn, '$param')\">"
    set select ""
    array_clear options
    set options(0) 0
    set options(15) 15
    set options(30) 30
    set options(45) 45
    foreach val [lsort -real [array names options]] {
      if {$val == $min} {
        set select "selected=\"selected\""
      } else {
        set select ""
      }

      if {$val < 10} {
        set txt "0$val"
      } else {
        set txt "$val"
      }

      append minElm "<option value=$val $select>$txt</option>"
    }

  append minElm "</select>"


  set convertedValue [expr [expr $hr * 60] + $min]
  set tmpVal "<input id=\"separate_CHANNEL\_$chn\_$prn\" name=\"$param\" type=\"text\" size=\"5\" value=$convertedValue style=\"display:none; visibility:hidden;\" >"

  return "$hrElm : $minElm $tmpVal"

}

proc getDSTPanel {p descr} {

    upvar $p ps
    upvar $descr psDescr
    upvar prn prn
    set chn 0

    set param DAYLIGHT_SAVINGS_TIME
    set html "<tr>"
      append html "<td>\${DSTSwitchAutomatically}</td>"
      append html "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
      append html "<td><input id=\"btnShowDST\" type=\"button\" name=\"btnConfigureDST\" onclick=\"jQuery('.j_dstValue').toggle();scrollUp(this);\"></td>"
    append html "</tr>"

    # This values are only visible when clicking the above button (id configDST)
    append html "<tr class=\"j_dstValue hidden\"><td colspan=\"2\"><hr></td></tr>"
    append html "<tr class=\"j_dstValue hidden\"><td>\${DSTStartHeader}</td></tr>"
    incr prn
    set param DST_START_DAY_OF_WEEK
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${DSTStartDayOfWeek}</td>"
      set option(0) "\${timeModuleLblSelSerialPatternSunday}"
      set option(1) "\${timeModuleLblSelSerialPatternMonday}"
      set option(2) "\${timeModuleLblSelSerialPatternTuesday}"
      set option(3) "\${timeModuleLblSelSerialPatternWednesday}"
      set option(4) "\${timeModuleLblSelSerialPatternThursday}"
      set option(5) "\${timeModuleLblSelSerialPatternFriday}"
      set option(6) "\${timeModuleLblSelSerialPatternSaturday}"
      append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append html "</tr>"

    incr prn
    set param DST_START_MONTH
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${DSTStartMonth}</td>"
      array_clear option
      set option(1) 1
      set option(2) 2
      set option(3) 3
      set option(4) 4
      set option(5) 5
      set option(6) 6
      set option(7) 7
      set option(8) 8
      set option(9) 9
      set option(10) 10
      set option(11) 11
      set option(12) 12
      append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append html "</tr>"

    incr prn
    set param DST_START_WEEK_OF_MONTH
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${DSTStartWeekOfMonth}</td>"
        array_clear option
        set option(1) "\${firstWeek}"
        set option(2) "\${secondWeek}"
        set option(3) "\${thirdWeek}"
        set option(4) "\${forthWeek}"
        set option(5) "\${lastWeek}"
      append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append html "</tr>"

    incr prn
    set param DST_START_TIME
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${DSTStartTime}</td>"
    append html "<td>[getDSTTimeElem $param $ps($param) $chn $prn]</td>"
    append html "</tr>"

    append html "<tr id=\"scrollDSTAnchor\" class=\"j_dstValue hidden\"><td colspan=\"2\"><hr></td></tr>"

    append html "<tr class=\"j_dstValue hidden\"><td>\${DSTEndHeader}</td></tr>"
    incr prn
    set param DST_END_DAY_OF_WEEK
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${DSTEndDayOfWeek}</td>"
      set option(0) "\${timeModuleLblSelSerialPatternSunday}"
      set option(1) "\${timeModuleLblSelSerialPatternMonday}"
      set option(2) "\${timeModuleLblSelSerialPatternTuesday}"
      set option(3) "\${timeModuleLblSelSerialPatternWednesday}"
      set option(4) "\${timeModuleLblSelSerialPatternThursday}"
      set option(5) "\${timeModuleLblSelSerialPatternFriday}"
      set option(6) "\${timeModuleLblSelSerialPatternSaturday}"
      append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append html "</tr>"

    incr prn
    set param DST_END_MONTH
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${DSTEndMonth}</td>"
      array_clear option
      set option(1) 1
      set option(2) 2
      set option(3) 3
      set option(4) 4
      set option(5) 5
      set option(6) 6
      set option(7) 7
      set option(8) 8
      set option(9) 9
      set option(10) 10
      set option(11) 11
      set option(12) 12
      append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append html "</tr>"

    incr prn
    set param DST_END_WEEK_OF_MONTH
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${DSTStartWeekOfMonth}</td>"
        array_clear option
      set option(1) "\${firstWeek}"
      set option(2) "\${secondWeek}"
      set option(3) "\${thirdWeek}"
      set option(4) "\${forthWeek}"
      set option(5) "\${lastWeek}"
      append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append html "</tr>"

    incr prn
    set param DST_END_TIME
    append html "<tr class=\"j_dstValue hidden\">"
    append html "<td>\${DSTEndTime}</td>"
    append html "<td>[getDSTTimeElem $param $ps($param) $chn $prn]</td>"
    append html "</tr>"

    append html "<tr class=\"j_dstValue hidden\"><td colspan=\"2\"><hr></td></tr>"

    incr prn
    set param UTC_DST_OFFSET
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${UtcDSTOffset}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"

    incr prn
    set param UTC_OFFSET
    append html "<tr class=\"j_dstValue hidden\">"
      append html "<td>\${UtcOffset}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"

    append html "<script type=\"text/javascript\">"

      append html "translateButtons('btnConfigureDST');"

      # This converts the time
      append html "ConvertTimeToMin = function(chn, prn, param) \{"
        append html "var valHrElm = jQuery(\"#hr_\"+chn+\"_\"+prn),"
        append html "valMinElm = jQuery(\"#min_\"+chn+\"_\"+prn),"
        append html "valHr = parseInt(valHrElm.val()),"
        append html "valMin = parseInt(valMinElm.val()),"
        append html "tmpElm = jQuery(\"#separate_CHANNEL_\"+chn+\"_\"+prn);"

        append html "if ((valHr < 0) || (valHr > 23)) \{"
            append html "if (param == \"DST_START_TIME\") \{"
              append html "valHr = 2;"
            append html "\} else \{"
              append html "valHr = 3;"
            append html "\}"

        append html "\}"

        append html "var convertedVal = (valHr * 60) + valMin;"
        append html "tmpElm.val(convertedVal);"
        append html "valHr = (valHr < 10) ? \"0\"+ valHr : valHr;"
        append html "valMin = (valMin < 10) ? \"0\" +valMin : valMin;"

        append html "valHrElm.val(valHr);"
        append html "valMinElm.val(valMin);"
      append html "\};"

      append html "scrollUp = function(elm) \{"
        append html "if (jQuery(\"#scrollDSTAnchor\").is(\":visible\")) \{"
          append html "jQuery(\"#btnShowDST\").get(0).scrollIntoView(\{behavior:'smooth', block:'start'\});"
        append html "\} else \{"
          append html "var endOfView = jQuery(elm).parent().parent().parent().children(\"tr\").filter(\":visible\").first();"
          append html "jQuery(endOfView).get(0).scrollIntoView(\{behavior:'smooth', block:'start'\});"
        append html "\}"
      append html "\}"





    append html "</script>"

    return $html
}

