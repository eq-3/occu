#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

set PROFILES_MAP(0)	"Experte"
set PROFILES_MAP(1)	"TheOneAndOnlyEasyMode"

proc showKeyLabel {devType} {
  set validDevices {"HM-PB-4Dis-WM" "ZEL STG RM DWT 10" "263 155" "HM-PB-4Dis-WM-2"}
  set result "false"

  foreach val $validDevices {
    if {$val == $devType} {
      set result "true"
      break
    }
  }
  return $result
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global dev_descr

	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps
  upvar $pps_descr	ps_descr
	
	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/KEY_4Dis.js');</script>"

  set devType $dev_descr(TYPE)
  set keyPos ""
  set bckColor "white"
  set showKeyLabel [showKeyLabel $devType]

	# ch = Kanal  
	set ch [lindex [split $address ":"] 1]

  if {$showKeyLabel == "true"} {
    # "Untere Taste"
    set keyPos "\${lblLowerKey}"
    if {[expr $ch % 2] == 0 } {
      # "Obere Taste"
      set keyPos "\${lblUpperKey}"
    }

    set bckColor "silver"
    if {[expr $ch % 4 == 0 ] || [expr $ch % 4 == 3]} {
      set bckColor "gray"
    }
  }

	# "Hinweis zur Bezeichnung der Tasten!"
	set title "\${dialogHelpTitle}"

	# set helpText "Da nur ein eingeschr&auml;nkter Zeichensatz zur Verf&uuml;gung steht,<br />"
	# append helpText "stehen einige Zeichen nicht zur Verf&uuml;gung und werden vom<br />"
	# append helpText "Wandtaster durch andere Zeichen ausgetauscht (gemappt).<br /><br />"

	set helpText "\${dialogHelpContent}"

	append helpText "<table style=\\'color:black; text-align:center\\'><tbody>"
	#append helpText "<tr><td>Zeichen</td><td>ersetzt durch</td></tr>"
	append helpText "<tr><td>\${dialogHelpContentA}</td><td>\${dialogHelpContentB}</td></tr>"
	append helpText "<tr><td>\[</td><td>&Auml;</td></tr>"
	append helpText "<tr><td>\#</td><td>&Ouml;</td></tr>"
	append helpText "<tr><td>\$</td><td>&Uuml;</td></tr>"
	append helpText "<tr><td>\{</td><td>&auml;</td></tr>"
	append helpText "<tr><td>\|</td><td>&ouml;</td></tr>"
	append helpText "<tr><td>\}</td><td>&uuml;</td></tr>"
	append helpText "<tr><td>\~</td><td>&szlig;</td></tr>"
	append helpText "<tr><td>\]</td><td>\&</td></tr>"
	append helpText "<tr><td>\\'</td><td>\=</td></tr>"

	#append helpText "<tr><td>\;</td><td>Sanduhr</td></tr>"
	append helpText "<tr><td>\;</td><td>\${dialogHelpContentC}</td></tr>"
	append helpText "<tr><td>\@</td><td>&or;</td></tr>"
	append helpText "<tr><td>\></td><td>&and;</td></tr>"
	#append helpText "<tr><td>\<</td><td>Pfeil nach oben links</td></tr>"
	append helpText "<tr><td>\<</td><td>\${dialogHelpContentD}</td></tr>"

	append helpText "</tbody></table>"

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\"><tbody>"

	append HTML_PARAMS(separate_1) "<tr><td colspan=\"2\" style=\"text-align:center; background-color:$bckColor\">$keyPos</td></tr>"
	append HTML_PARAMS(separate_1) "<tr>"
	append HTML_PARAMS(separate_1) "<td><span class=\"stringtable_value\">KEY|TEXT1</span></td>"
	append HTML_PARAMS(separate_1) "<td><input type=\"text\" value=\"[string map {' = [ &Auml; # &Ouml; $ &Uuml; \{ &auml; | &ouml; \} &uuml; ~ &szlig; ] &amp;} $ps(TEXT1)]\" name=\"TEXT1\" size=\"12\" maxlength=\"12\" id=\"_separate_${special_input_id}_1\" onchange=\"encodeStringStatusDisplay('_separate_${special_input_id}_1', true);\" ></td>"
	
	append HTML_PARAMS(separate_1) "<td><input type=\"text\" value=\"$ps(TEXT1)\" name=\"TEXT1\" id=\"separate_${special_input_id}_1\" style=\"visibility:hidden\"></td>"
	

	append HTML_PARAMS(separate_1) "</tr>"
	
	append HTML_PARAMS(separate_1) "<tr><td colspan=\"2\"><hr></td></tr>"

	append HTML_PARAMS(separate_1) "<tr>"
	append HTML_PARAMS(separate_1) "<td><span class=\"stringtable_value\">KEY|TEXT2</span></td>"
	append HTML_PARAMS(separate_1) "<td><input type=\"text\" value=\"[string map {' = [ &Auml; # &Ouml; $ &Uuml; \{ &auml; | &ouml; \} &uuml; ~ &szlig; ] &amp;} $ps(TEXT2)]\" name=\"TEXT2\" size=\"12\" maxlength=\"12\" id=\"_separate_${special_input_id}_2\" onchange=\"encodeStringStatusDisplay('_separate_${special_input_id}_2', true);\" ></td>"
	
	if {[expr $ch % 2] == 0 && $showKeyLabel == "true"} {
		append HTML_PARAMS(separate_1) "<td><img src=\"/ise/img/help.png\"/ size=\"24\" width=\"24\" onclick=\"MessageBox.show('$title', '$helpText', '', 450, 320) ;\"></td>"
  } elseif {$showKeyLabel == "false"} {
		append HTML_PARAMS(separate_1) "<td><img src=\"/ise/img/help.png\"/ size=\"24\" width=\"24\" onclick=\"MessageBox.show('$title', '$helpText', '', 450, 320) ;\"></td>"
  }
	
	append HTML_PARAMS(separate_1) "<td><input type=\"text\" value=\"$ps(TEXT2)\" name=\"TEXT2\" id=\"separate_${special_input_id}_2\" style=\"visibility:hidden\" ></td>"
	

	append HTML_PARAMS(separate_1) "</tr>"

	append HTML_PARAMS(separate_1) "</tbody></table>"


	#append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">st_setStringTableValues();</script>"

}

constructor
