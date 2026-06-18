 ##
 # SysVar.setString
 # Setzt den Wert einer Systemvariable vom Typ String
 #
 # Parameter:
 #   name: [string] Name der betreffenden Systemvariablen.
 #   value:  [string] Wert
 #
 #
 # Rueckgabewert: [string]
 #  Wert der Systemvariablen.
 ##

 set script {
   var sv = dom.GetObject(name);

   if (sv)
   {
     Write(sv.State(value));
   }
 }

 if {[hmscript $script args] } {
   jsonrpc_response $args(value)
 } else {
   jsonrpc_response -1
 }
