##
# Programm.get
# Liefert Detailinformationen zu einem Programm
#
# Parameter:
#   id: [string] Id des betreffenden Programms
#
# Rückgabewert: [object]
#  Folgende Felder sind definiert:
#    id             : [string] Id des Programms
#    name           : [string] Bezeichnung des Programms
#    isActive       : [bool]   true, falls das Programm aktiv ist
#    isInternal     : [bool]   true, falls es ein systeminteres Programm ist
#    lastExecuteTime: [string] Zeitpunkt der letzten Ausführung 
#                              (JJJJ-MM-DD HH:MM::SS)
##

set script {
  var program = dom.GetObject(id);
  if (program)
  {
    WriteLine("ID {" # program.ID() # "}");
    WriteLine("NAME {" # program.Name() # "}");
    WriteLine("TIME {" # program.ProgramLastExecuteTime() # "}");
    WriteLine("ACTIVE {" # program.Active() # "}");
    WriteLine("INTERNAL {" # program.Internal() # "}");
  }
}

array set _program_ [hmscript $script args]

set    result "\{"
append result "\"id\":[json_toString $_program_(ID)],"
append result "\"name\":[json_toString $_program_(NAME)],"
append result "\"isActive\":$_program_(ACTIVE),"
append result "\"isInternal\":$_program_(INTERNAL),"
append result "\"lastExecuteTime\":[json_toString $_program_(TIME)],"
append result "\}"
  
jsonrpc_response $result