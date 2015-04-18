#!/bin/tclsh

proc array_clear {name} {
    upvar $name arr
    foreach key [array names arr] {
		unset arr($key)
    }
}

proc constructor {} {

	upvar PROFILES_MAP PROFILES_MAP
	upvar HTML_PARAMS HTML_PARAMS
	
	foreach pnr [array names PROFILES_MAP] {
		#Für HTML-Befehle, die die separaten Einstellungen vornehmen je Profil.
		set HTML_PARAMS(separate_$pnr) ""

		#Beschreibungs-Vorlage
		set arrname PROFILE_$pnr
		upvar $arrname PROFILE_X
		set HTML_PARAMS(descriptionTemplate_$pnr) ""
		catch {set HTML_PARAMS(descriptionTemplate_$pnr) $PROFILE_X(UI_TEMPLATE)}
		catch {set HTML_PARAMS(whitelist_$pnr) $PROFILE_X(UI_WHITELIST)}
		catch {set HTML_PARAMS(blacklist_$pnr) $PROFILE_X(UI_BLACKLIST)}
		#-----
	}

	#SUBSETs referenzieren
	set i 1
	catch {upvar SUBSET_$i SUBSET_$i}

	while { [array size SUBSET_$i] > 0  } {
		incr i
		catch {upvar SUBSET_$i SUBSET_$i}
	}
}

proc destructor {} {

	upvar PROFILE_PNAME PROFILE_PNAME
	upvar PROFILES_MAP PROFILES_MAP
	upvar HTML_PARAMS HTML_PARAMS
	upvar PROFILE_TMP PROFILE_TMP
	
	foreach pnr [array names PROFILES_MAP] {
		upvar PROFILE_$pnr PROFILE_$pnr
		array_clear PROFILE_$pnr
	}

	array_clear PROFILE_PNAME
	array_clear PROFILES_MAP
	array_clear HTML_PARAMS
	array_clear PROFILE_TMP

	#SUBSETS
	set i 1
	catch {upvar SUBSET_$i SUBSET_$i}

	while { [array size SUBSET_$i] > 0  } {
		array_clear SUBSET_$i
		incr i
		catch {upvar SUBSET_$i SUBSET_$i}
	}
}
