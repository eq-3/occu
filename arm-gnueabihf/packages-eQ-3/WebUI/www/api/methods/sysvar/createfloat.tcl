 ##
 # SysVar.createFloat
 # Erzeugt eine Systemvariable vom Typ Number.
 #
 # Parameter:
 #   name: [string] Name der betreffenden Systemvariablen.
 #   minValue:  [number] minimaler Wert
 #   maxValue:  [number] maximaler Wert
 #   internal: [integer]  Variable sichtbar / Variable intern
 # Rückgabewert: [string]
 #   Objekt der Systemvariablen mit Name, ID, Wert.
 ##

 set script {
   object oSysVars = dom.GetObject( ID_SYSTEM_VARIABLES );
   object sv = dom.CreateObject(OT_VARDP);
   sv.ValueType( ivtFloat );
   sv.Name(name);
   sv.ValueMin(minValue);
   sv.ValueMax(maxValue);
   sv.State(0);
   sv.Internal(internal);

   oSysVars.Add(sv.ID());

   Write("{'name':'"#sv.Name()#"','id':'"#sv.ID()#"','value':'"#sv.Value()#"' }");
 }

 jsonrpc_response [hmscript $script args]

