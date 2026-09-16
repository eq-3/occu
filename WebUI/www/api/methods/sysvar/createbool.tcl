##
# SysVar.createBool
# Erzeugt eine Systemvariable vom Typ Boolean.
#
# Parameter:
#   name: [string] Name der betreffenden Systemvariablen.
#   init_val: [bool] Initialer Status
#   internal: [integer]  Variable sichtbar / Variable intern
#   chnID: [integer] ID des Kanals, an dem die Variable gebunden werden soll. Wenn an kein Kanal gebunden werden soll, ist -1 zu übergeben
# Rückgabewert: [string]
#   Objekt der Systemvariablen mit Name, ID, Wert.
##

if { ![regexp {^[A-Za-z0-9_\-\.:]+$} $args(name)] } then {
  jsonrpc_error 1 "Invalid name. Must match \[A-Za-z0-9_\-.:\]"
}
if {[catch { hmscript_assertBoolean $args(init_val)} err]} {
  jsonrpc_error 2 $err
}
if {[catch { hmscript_assertInteger $args(internal)} err]} {
  jsonrpc_error 3 $err
}
if {[catch { hmscript_assertInteger $args(chnID)} err]} {
  jsonrpc_error 4 $err
}

set script {
  if (chnID != -1) {
   object channel = dom.GetObject(chnID);
  }

  object oSysVars = dom.GetObject( ID_SYSTEM_VARIABLES );
  object sv = dom.CreateObject(OT_VARDP);

  sv.ValueType( ivtBinary );
  sv.ValueSubType( istBool );
  sv.Name(name);
  sv.ValueName0("false");
  sv.ValueName1("true");
  sv.State(init_val);

  sv.Internal(internal);

  if (channel) {
    sv.Channel(chnID);
    channel.DPs().Add(sv.ID());
  }

  oSysVars.Add(sv.ID());

  Write("{'name':'"#sv.Name()#"','id':'"#sv.ID()#"','value':'"#sv.Value()#"' }");
  }

jsonrpc_response [hmscript $script args]

