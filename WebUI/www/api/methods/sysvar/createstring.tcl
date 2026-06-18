##
# SysVar.createString
# Erzeugt eine Systemvariable vom Typ String.
#
# Parameter:
#   name: [string] Name der betreffenden Systemvariablen.
#   init_val: [string] Initialer Wert
#   internal: [integer]  Variable sichtbar / Variable intern
#   chnID: [integer] ID des Kanals, an dem die Variable gebunden werden soll. Wenn an kein Kanal gebunden werden soll, ist -1 zu uebergeben
#   Rueckgabewert: [string]
#   Objekt der Systemvariablen mit Name, ID, Wert.
##

set script {

  if (chnID != -1) {
   object channel = dom.GetObject(chnID);
  }

  object oSysVars = dom.GetObject( ID_SYSTEM_VARIABLES );
  object sv = dom.CreateObject(OT_VARDP);

  sv.Name(name);
  sv.ValueType( ivtString );
  sv.ValueSubType( istChar8859 );
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
