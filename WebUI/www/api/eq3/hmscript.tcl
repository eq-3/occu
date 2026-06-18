##
# hmscript.tcl
# Ausführen von HomeMatic Script.
#
# Autor: Falk Werner
##

package require HomeMatic

proc hmscript {script {p_args -}} {
  set _script_ ""
  
  if { "-" != $p_args } then {
    upvar $p_args args
    
    foreach name [array names args] {
      append _script_ "var $name = \"[hmscript_escapeString $args($name)]\";\n"
    }
  }
  
  append _script_ $script
 
  return [hmscript_run _script_]  
}

##
# Führt ein HomeMatic Script aus und liefert das Ergebnis
##
proc hmscript_run { p_script } {
  upvar $p_script script
  
  if { ![catch {array set result [rega_script $script]}] } then {
    return $result(STDOUT)
  }
  return ""
}

proc hmscript_runInline { script } {
  if { ![catch {array set result [rega_script $script]}] } then {
    return $result(STDOUT)
  }
  return ""    
}

proc hmscript_runFromFile { filename {p_args -}} {
	set script ""
	
	if { "-" != $p_args } then {
		upvar $p_args args
    
		foreach name [array names args] {
			append script "var $name = \"[hmscript_escapeString $args($name)]\";\n"
		}
	}
  append script [file_load $filename]
  
  return [hmscript_run script]
}

proc hmscript_escapeString { str } {
  # Backslash MUST be escaped first, otherwise a backslash placed directly
  # before a quote in user input would (after the quote is escaped to \")
  # be read by ReGa as an escaped backslash, closing the string literal
  # early and turning the rest of the input into executable HomeMatic Script.
  return [string map {
    "\\" "\\\\"
    "\'" "\\\'"
    "\"" "\\\""
    "\n" "\\n"
    "\r" "\\r"
    "\t" "\\t"
  } $str]
}