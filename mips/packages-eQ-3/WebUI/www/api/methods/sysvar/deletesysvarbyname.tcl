 ##
 # SysVar.deleteSysVarByName
 # Löscht eine Systemvariable mit bestimmten Namen.
 #
 # Parameter:
 #   name: [string] Name der Systemvariablen
 #
 # Rückgabewert: true
 ##


 set script {
   object oSysVars = dom.GetObject( ID_SYSTEM_VARIABLES );

   object sysVar = dom.GetObject(name);

   oSysVars.Remove(sysVar.ID());
   Write("true");
 }

 jsonrpc_response [hmscript $script args]