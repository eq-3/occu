##
# Allgemeine Hilfsfunktionen
##

##########
# Arrays #
##########

##
# Entfernt alle Elemente aus einem Array
##
proc array_clear {name} {
    upvar $name arr
    foreach key [array names arr] {
		unset arr($key)
    }
}

##
# Liefert einen Wert aus einem Array
# Ist der Wert nicht vorhanden, wird {} zurückgegeben
##
proc array_getValue { pArray name } {
  upvar $pArray arr

  set value {}
  catch { set value $arr($name) }

  return $value
}

###########
# Dateien #
###########

##
# Speichert den Inhalt einer Variablen in einer Datei
##
proc file_save { filename content } { 
  if { ![catch { set fd [open $filename w] }] } then {
    puts -nonewline $fd $content
    close $fd
  }
}

##
# Hängt Daten an eine existierende Datei an
##
proc file_append {filename content} {
	if { ![catch { set fd [open $filename a] }] } then {
		puts -nonewline $fd $content
		close $fd
	}
}

##
# Liest eine komplette Datei ein
##
proc file_load {filename} {
  set content ""
  set fd -1

  catch { set fd [open $filename r] }
  if { 0 <= $fd } then {
    set content [read $fd]
    close $fd
  }
  return $content
}

##
# Löscht den Inhalt einer Datei
##
proc file_clear {filename} {

		set fd [open $filename w]
		close $fd

}

###########
# Sperren #
###########

##
# Versucht, eine Sperre einzurichten
# -1: Fehler,
##
proc lock_tryget {filename} {
	set result 0
	
	catch {
		set fd [open $filename {WRONLY CREAT EXCL}]
		if { 0 <= $fd } then {
			close $fd
			set result true
		}
	}
	
	return 1
}

##
# Gibt eine Sperre frei
##
proc lock_release {filename} {
  if {[file exists $filename]} {
    catch {file delete -force -- $filename}
  }
}

############################
# Sonstige Hilfsfunktionen #
############################

##
# Entfernt Duplikate aus einer Liste
# Die Liste wird dabei sortiert
##
proc _lrmdups { _list_ } {
  if {[llength _list_] == 0} then { return "" }

  set _list_ [lsort $_list_]
  set value  [lindex $_list_ 0]
  set result $value
    
  foreach item $_list_ {
    if {$item > $value} then {
      set value $item
      lappend result $item
    }
  }
  
  return $result;
}

##
# Entfernt eventuell doppelt vorkommende Programm-Ids
##
proc rmDoublePrgIds { _list_ } {
  if {[llength _list_] == 0} then { return "" }
  set t {}
  foreach i $_list_ {
    if {[lsearch $t $i] == -1} {
      lappend t $i
    }
  }
  return $t;
}

