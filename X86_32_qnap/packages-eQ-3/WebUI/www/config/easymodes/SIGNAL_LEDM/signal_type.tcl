array set param_descr $ps_descr(SHORT_ACT_NUM)
set min 1
set max $param_descr(MAX)

global dev_descr_sender

# Beim Rauchmelder gibt es keine Einschaltverzögerung.
# Das Profil enthält nur die Signalart und die Anzahl der Signale.
# Daher gibt es keine horizontale Begrenzungslinie
if {$dev_descr_sender(TYPE) != "SMOKE_DETECTOR_TEAM"} { 
	append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\"><hr></td></tr>"
}

incr pref
append HTML_PARAMS(separate_$prn) "<tr><td>\${signal_kind}</td><td>"
array_clear options

#set options(1)	"Rot Kurz" 
#set options(2)	"Rot Lang"
#set options(3)	"Gr&uuml;n Kurz"
#set options(4)	"Gr&uuml;n Lang"
#set options(5)	"Orange Kurz"
#set options(6)	"Orange Lang"

set options(1)	"\${signal_option_red_short}" 
set options(2)	"\${signal_option_red_long}"
set options(3)	"\${signal_option_green_short}"
set options(4)	"\${signal_option_green_long}"
set options(5)	"\${signal_option_orange_short}"
set options(6)	"\${signal_option_orange_long}"

append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ACT_TYPE|LONG_ACT_TYPE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ACT_TYPE]
append HTML_PARAMS(separate_$prn) "</td></tr>"

incr pref
set id "separate_${special_input_id}_$prn\_$pref"
append HTML_PARAMS(separate_$prn) "<tr><td>\${signal_count} ($min - $max)</td><td>"
append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"$id\" name=\"SHORT_ACT_NUM|LONG_ACT_NUM\" value=\"$ps(SHORT_ACT_NUM)\" size=5 onchange=\"ProofFreeValue(\'$id\', $min, $max);\">"
append HTML_PARAMS(separate_$prn) "</td></tr>"

