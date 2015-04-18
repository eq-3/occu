array set paramDescrActType $ps_descr(SHORT_ACT_TYPE)
set minActType $paramDescrActType(MIN)
set maxActType $paramDescrActType(MAX)

array set paramDescrActNum $ps_descr(SHORT_ACT_NUM)
set minActNum $paramDescrActNum(MIN)
set maxActNum $paramDescrActNum(MAX)

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
#set options(0)	"No MSG"
set options(1)	"\${signal_short}"
set options(2)	"\${signal_long}"
#append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ACT_TYPE|LONG_ACT_TYPE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ACT_TYPE]
set id "separate_${special_input_id}_$prn\_$pref"
append HTML_PARAMS(separate_$prn) "<tr><td>\${sound_nr}($minActType - $maxActType)</td><td>"
append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"$id\" name=\"SHORT_ACT_TYPE|LONG_ACT_TYPE\" value=\"$ps(SHORT_ACT_TYPE)\" size=5 onchange=\"ProofFreeValue(\'$id\', $minActType, $maxActType);\">"
append HTML_PARAMS(separate_$prn) "</td></tr>"

incr pref
set id "separate_${special_input_id}_$prn\_$pref"
append HTML_PARAMS(separate_$prn) "<tr><td>\${iterations}($minActNum - $maxActNum)</td><td>"
append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"$id\" name=\"SHORT_ACT_NUM|LONG_ACT_NUM\" value=\"$ps(SHORT_ACT_NUM)\" size=5 onchange=\"ProofFreeValue(\'$id\', $minActNum, $maxActNum);\">"
append HTML_PARAMS(separate_$prn) "</td></tr>"

incr pref
set id "separate_${special_input_id}_$prn\_$pref"
append HTML_PARAMS(separate_$prn) "<tr><td>\${volume}</td><td>"

set options(0) "100%"
set options(1) "90%"
set options(2) "80%"
set options(3) "70%"
set options(4) "60%"
set options(5) "50%"
set options(6) "40%"
set options(7) "30%"
set options(8) "20%"
set options(9) "10%"
set options(10) "0%"

append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ACT_INTENS|LONG_ACT_INTENS separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ACT_INTENS]

#append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"$id\" name=\"SHORT_ACT_INTENS|LONG_ACT_INTENS\" value=\"$ps(SHORT_ACT_INTENS)\" size=5 onchange=\"ProofFreeValue(\'$id\', $min, $max);\">"
append HTML_PARAMS(separate_$prn) "</td></tr>"
