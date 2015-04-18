#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

#set PROFILE_0(UI_HINT)	0
#set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
#set PROFILE_0(UI_TEMPLATE) "Expertenprofil"

set PROFILE_0(FILL_LEVEL_UPPER_THRESHOLD) {0 range 0 - 255}
set PROFILE_0(FILL_LEVEL_LOWER_THRESHOLD) {0 range 0 - 255}
set PROFILE_0(UI_DESCRIPTION) ">" 
set PROFILE_0(UI_TEMPLATE)	""
set PROFILE_0(UI_HINT)	0

# Runded die Nachkommstelle auf 0 oder 5
proc setDecimalPlaces {val} {
  set splittedVal [split $val .]
  # Vorkommastelle
  set integerPlaces [lindex $splittedVal 0]
  # Nachkommastelle
  set decimalPlaces [lindex $splittedVal 1]
    
  if {$decimalPlaces > 0 && $decimalPlaces < 3 } {
    set decimalPlaces 0
  } elseif {$decimalPlaces >= 3 && $decimalPlaces <= 7} {
    set decimalPlaces 5
  } elseif {$decimalPlaces == 8 || $decimalPlaces == 9 } {
    incr integerPlaces
    set decimalPlaces 0
  }
  set percentVal $integerPlaces
  append percentVal "."
  append percentVal $decimalPlaces
  return $percentVal 
}

proc createCheckbox {name val loop} {
  set checked ""
  set html "<tr>"
    append html "<td class=\"stringtable_value\">$name</td>"
    set id "id=\"separate_sender_0_$loop\""
		set checked ""
		if { $val == 1 } then { set checked "checked=\"checked\"" }
    append html "<td><input type=\"checkbox\" $id value=\"dummy\" name=$name $checked></td>"
  append html "</tr>"
  return $html
}

proc createTextfield {name val devType loop} {
  set id "'separate_sender_0_$loop'"
  set idString "id=$id"
  set tmpId "'tmp_0_$loop'" 
  set percentVal 0      
  set checked "checked=\'checked\'"
  set disabled ""
   
  if {$val != 0} {
    set percentVal [setDecimalPlaces [format {%1.1f} [expr 100.0 / (200.0/$val)]]]

    if {$val == "255"} {
      set checked ""
      set disabled "disabled=\'disabled\'"
      set percentVal "0"
    }
  }

  set html "<tr>"
    append html "<td class=\"stringtable_value\">$devType|$name</td>"
    append html "<td><input type=\"text\" id=$tmpId value=$percentVal name=\"tmp_$name\" size=\"5\" $disabled onchange=\"setVal(this, \'linkSender\');\" ></td>"
    #append html "<td><input id=\"activateThreshold_$loop\" type=\"checkbox\" $checked onchange=\"setThresholdActiv(this, $tmpId, $id, $val, 'linkSender')\">aktiv</td>"
    append html "<td><input id=\"activateThreshold_$loop\" type=\"checkbox\" $checked onchange=\"setThresholdActiv(this, $tmpId, $id, $val, 'linkSender')\">\${lblActiv}</td>"
    append html "<td><input type=\"text\" $idString value=\"$val\" name=$name size=\"5\" style=\"display:none\"></td>"
  append html "</tr>"
  return $html 
}


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CapacitiveFillingLevelSensor.js');</script>"

	global dev_descr_sender dev_descr_receiver sender_address
	set ACTOR $dev_descr_receiver(TYPE) 
	# Kanal aus der Senderaddresse entfernen, aus EDD00001234:1 wird EDD00001234
	set sender_addr [string toupper [string range $sender_address 0 [expr [string first ":" $sender_address] -1] ]] 
	catch {puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$sender_addr\">"} 
		
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr
 	
	puts "<script type=\"text/javascript\">document.getElementById('sender_profiles').style.display = 'none';</script>"
		
	append HTML_PARAMS(separate_0) "<table class=\"ProfileTbl\">"
	  # append HTML_PARAMS(separate_0) "<thead><tr><td>Parametername</td><td>Wert</td></tr></thead>"
	  append HTML_PARAMS(separate_0) "<thead><tr><td>\${lblParameterName}</td><td>\${lblValue}</td></tr></thead>"
	  append HTML_PARAMS(separate_0) "<tbody>"
   
   
    set loop 0 
    foreach val [lsort [array names ps]] {
      array set descr $ps_descr($val)
      if {$descr(TYPE) == "BOOL"} {
        incr loop
        append HTML_PARAMS(separate_0) [createCheckbox $val $ps($val) $loop] 
      }
    }

    foreach val [lsort [array names ps]] {
      array set descr $ps_descr($val)
      if {$descr(TYPE) == "INTEGER"} {
        incr loop
        append HTML_PARAMS(separate_0) [createTextfield $val $ps($val) $dev_descr_sender(TYPE) $loop] 
      }
    }

	  append HTML_PARAMS(separate_0) "</tbody>"
  append HTML_PARAMS(separate_0) "</table>"

  puts "<script type=\"text/javascript\">translatePage('.SetProfLinkTbl');</script>"
	
}

constructor
