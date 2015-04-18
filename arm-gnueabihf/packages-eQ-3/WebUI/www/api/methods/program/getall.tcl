##
# Program.getAll
# Liefert Detailinformationen aller Programme.
#
# Parameter:
#  <keine>
#
# Rückgabewerk: [array]
#  Jedes Element ist ein Object, das wie folgt aufgebaut ist:
#    id             : [string] Id des Programms
#    name           : [string] Bezeichnung des Programms
#    isActive       : [bool]   true, falls das Programm aktiv ist
#    isInternal     : [bool]   true, falls es ein systeminteres Programm ist
#    lastExecuteTime: [string] Zeitpunkt der letzten Ausführung 
#                              (JJJJ-MM-DD HH:MM::SS)
##

set script {
  string id;
  foreach(id, dom.GetObject(ID_PROGRAMS).EnumIDs())
  {
    var program = dom.GetObject(id);
    if (program)
    {
      WriteLine("{");
      WriteLine("ID {" # program.ID() # "}");
      WriteLine("NAME {" # program.Name() # "}");
      WriteLine("TIME {" # program.ProgramLastExecuteTime() # "}");
      WriteLine("ACTIVE {" # program.Active() # "}");
      WriteLine("INTERNAL {" # program.Internal() # "}");
      WriteLine("}");
    }
  }
}

set programs [hmscript_run script]

set result "\["
set first  1

foreach program $programs {
  if { 1 != $first } then { append result "," } else { set first 0 }
  array set _program_ $program
  
  append result "\{"
  append result "\"id\":[json_toString $_program_(ID)],"
  append result "\"name\":[json_toString $_program_(NAME)],"
  append result "\"isActive\":$_program_(ACTIVE),"
  append result "\"isInternal\":$_program_(INTERNAL),"
  append result "\"lastExecuteTime\":[json_toString $_program_(TIME)]"
  append result "\}"
}
append result "\]"


jsonrpc_response $result
