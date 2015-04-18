#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce common.tcl
loadOnce tclrega.so

set USERS_FILE "/etc/config/USERS.dat"

set ADMIN_NAME "admin"
set ADMIN_PWD  "elv"
set ADMIN_UPL  8

array set users_name ""
array set users_pwd  ""
array set users_upl  ""
array set users_eq3  ""

#=======================================================================
#Funktionen dieses Moduls
#=======================================================================
#proc user_name {uid} {
#proc user_upl {uid} {
#proc user_verify {name pwd} {
#proc user_adduser {name pwd upl} {
#proc user_getnewuid {} {
#proc write_users {} {
#proc read_users {} {
#=======================================================================

proc read_users {} {

    global USERS_FILE users_name users_pwd users_upl users_eq3 ADMIN_NAME ADMIN_PWD ADMIN_UPL
	set admininfile 0

	if { ! [catch {open $USERS_FILE RDONLY} f] } then {
	
		set count 0
		while {1} {
		
			gets $f zeile
			incr count

			if { [eof $f] || [string equal $zeile "<."] } break

			if { $count > 1 } then {
			
				if { [regexp {^([0-9]*);([A-Za-z0-9]*);([A-Za-z0-9]*);([0-9]*);([0-9])$} $zeile dummy uid name pwd upl eq3] } then {

					array set users_name [list $uid $name]
					array set users_pwd  [list $uid $pwd]
					array set users_upl  [list $uid $upl]
					array set users_eq3  [list $uid $eq3]

					if { [string equal $name "admin"] } then {
						set admininfile 1
					}
				}
			}
		}

		close $f

	} else {

		#puts "Could not open users file."
		#puts $f
	}
	
	#Admin vorhanden? Wenn nein, hinzufügen!
	#if { $admininfile != 1} then {

	#	#puts "Could not find administrator user, so i will create him."
	#	user_adduser $ADMIN_NAME $ADMIN_PWD $ADMIN_UPL
	#	write_users
	#}
}

proc write_users {} {
	
    global USERS_FILE users_name users_pwd users_upl users_eq3

	if { ! [catch {open $USERS_FILE w} f] } then {
	
		puts $f "UID;Name;Password;UPL;EQ3"
		
		foreach uid [array names users_name] {
			set name $users_name($uid)
			set pwd  $users_pwd($uid)
			set upl  $users_upl($uid)
			set eq3  $users_eq3($uid)

			puts $f "$uid;$name;$pwd;$upl;$eq3"
		}

		puts $f "<."

		close $f

	} else {

		puts "Could not open users file for writing."
		puts $f
	}
}

proc user_getnewuid {} {
	
	global users_name
	set tmp 0

    foreach uid [array names users_name] {

		set tmp [max $uid $tmp]
	}

	return [expr $tmp + 1]
}

#return: uid des neuen benutzers
proc user_adduser {name pwd upl} {

    global users_name users_pwd users_upl users_eq3

	set uid [user_getnewuid]

	array set users_name [list $uid $name]
	array set users_pwd  [list $uid $pwd]
	array set users_upl  [list $uid $upl]
	array set users_eq3  [list $uid 1]

	return $uid
}

# -1: Benutzer nicht bekannt, oder Passwort falsch
#>=0: Benutzer verifiziert. return: uid des Benutzers.
proc user_verify {name pwd} {

    global users_name users_pwd users_eq3
	
	set ret -1

	#foreach muss sein, weil der username nicht eindeutig ist.
    foreach uid [array names users_name] {

		if { [string equal $name $users_name($uid)] && [string equal $pwd $users_pwd($uid)] && $users_eq3($uid) == 1 } then {
			set ret $uid
			break
		}
	}

	return $ret
}

#   -1: upl zur übergebenen uid nicht gefunden
#>=  0: upl des users mit der übergebenen uid
proc user_upl {uid} {

	global users_upl users_eq3
	
	set upl -1

	catch {
		if {$users_eq3($uid) == 1} then {
			set upl $users_upl($uid)
		}
	}
	
	return $upl
}

#== "": user zur übergebenen uid nicht gefunden
#!= "": username zu der übergebenen uid
proc user_name {uid} {

	global users_name users_eq3
	
	set name ""
	catch {
		if {$users_eq3($uid) == 1} then {
			set name $users_name($uid)
		}
	}
	
	return $name
}

read_users

#puts [user_upl 4]

#foreach uid [array names users_name] {
	#puts $uid$users_name($uid)$users_pwd($uid)$users_upl($uid)
#}

#write_users

#======================================================================
#======================================================================
#======================================================================
#Funktionen fürs ise ReGa
#======================================================================
#======================================================================
#======================================================================

proc read_users_ise {} {

	set    cmd ""
	append cmd "string id;" 
	append cmd "object oUSERS = dom.GetObject(ID_USERS);"
	append cmd "Write(\"UID;Name;Password;UPL\n\");"
	append cmd "foreach(id, oUSERS.EnumUsedIDs())"
	append cmd "{"
	append cmd "  object obj = dom.GetObject(id);"
	append cmd "  if ( obj.Visible() )"
	append cmd "  {"
	append cmd "    if (obj.Enabled())"
	append cmd "    {"
	append cmd "      Write(obj.ID() #\";\"# obj.Name() #\";\"# \"blabla\" #\";\"# obj.UserLevel() #\"\n\");"
	append cmd "    }"
	append cmd "  }"
	append cmd "}"
	append cmd "Write(\"<.\n\");"

	array set result [rega_script "$cmd"]

	puts "$result(STDOUT)"
}

#   -1: upl zur übergebenen uid nicht gefunden
#>=  0: upl des users mit der übergebenen uid
proc user_upl_ise {uid} {

	set    cmd ""
	append cmd "integer upl = -1;"
	append cmd "object obj = dom.GetObject($uid);"
	append cmd "if (obj.Type() == OT_USER)"
	append cmd "{"
	append cmd "	if (obj.Enabled())"
	append cmd "	{"
	append cmd "		upl = obj.UserLevel();"
	append cmd "	}"
	append cmd "}"

	array set result [rega_script "$cmd"]

	return $result(upl)
}

#== "": user zur übergebenen uid nicht gefunden
#!= "": username zu der übergebenen uid
proc user_name_ise {uid} {
	
	set    cmd ""
	append cmd "string uname = \"\";"
	append cmd "object obj = dom.GetObject($uid);"
	append cmd "if (obj.Type() == OT_USER)"
	append cmd "{"
	append cmd "	if (obj.Enabled())"
	append cmd "	{"
	append cmd "		uname = obj.Name();"
	append cmd "	}"
	append cmd "}"

	array set result [rega_script "$cmd"]

	return $result(uname)
}

#-1: User zum übergebenen uname nicht vorhanden
#>0: uid des uname
proc user_uid_ise {uname} {
	
	set    cmd ""
	append cmd "object oUSERS = dom.GetObject(ID_USERS);"
	append cmd "object obj = oUSERS.Get(\"$uname\");"
	append cmd "integer uid = -1;"
	append cmd "if (obj)"
	append cmd "{"
	append cmd "  uid = obj.ID();"
	append cmd "}"

	array set result [rega_script "$cmd"]

	return $result(uid)
}

proc user_isExpert_ise {uid} {

	array set result [rega_script "var linkmode = dom.GetObject($uid).UserEasyLinkMode();"]

	set data $result(linkmode)

	if {$data == ""} then {return -1}

	#Logik umdrehen. ise: "vereinfachte Einstellungen", ELV: "Experte"
	set data [expr { $data == "false" ? 1 : 0 } ]

	return $data
}
#======================================================================
#======================================================================
#======================================================================
