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
option SHORT_LONG
append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ACT_TYPE|LONG_ACT_TYPE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ACT_TYPE]
append HTML_PARAMS(separate_$prn) "</td></tr>"

incr pref
set id "separate_${special_input_id}_$prn\_$pref"
append HTML_PARAMS(separate_$prn) "<tr><td>\${signal_kind_count} ($min - $max)</td><td>"
append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"$id\" name=\"SHORT_ACT_NUM|LONG_ACT_NUM\" value=\"$ps(SHORT_ACT_NUM)\" size=5 onchange=\"ProofFreeValue(\'$id\', $min, $max);\">"
append HTML_PARAMS(separate_$prn) "</td></tr>"

