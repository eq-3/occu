 ##
 # ReGa.getAllDatapoints
 #
 # Privilegstufe: ADMIN
 # Parameter:     <keine>
 #
 # Rückgabewert: [string]
 #   Zeichenkette, welche die Ids und die Namen der Datenpunkte enthält.
 ##

 set script {

  string result = "";
  object obj;
  integer loop = 0;
  object device;

  while(loop < 65535)
  {
    obj = dom.GetObject(loop);
    if (obj) {
      if ((obj.TypeName() == "HSSDP") || (obj.TypeName() == "DEVICE") ||(obj.TypeName() == "CHANNEL")) {
        if (obj.TypeName() != "DEVICE") {device = dom.GetObject(obj.Device());} else {device = dom.GetObject(obj.ID());}
        if (device) {
          if (device.Address() != "") {
            if (obj.TypeName() == "HSSDP") {
              result = result #obj.ID()#"--"#obj.TypeName()#"--"#obj.Name()#"--"#device.Name()#"--"#device.Address()#"\n";
            } else {
              result = result #obj.ID()#"--"#obj.TypeName()#"--"#obj.Name()#"--"#device.Address()#"\n";
            }
          } else {
            result = result #obj.ID()#"--"#obj.TypeName()#"--"#obj.Name()#"--"#device.Name()#"\n";
          }
        } else {
          result = result #obj.ID()#"--"#obj.TypeName()#"--"#obj.Name()#"\n";
        }
      } else {
        result = result #obj.ID()#"--"#obj.TypeName()#"--"#obj.Name()#"\n";
      }
    }
    loop = loop + 1;
   }
   Write(result);
 }

 set ids [split [hmscript $script] "\n"]

 set result "\["
 set first 1

 foreach id $ids {
   if {$first != 1} then { append result ","} else { set first 0 }
   append result [json_toString $id ]
 }

 append result "\]"

 jsonrpc_response $result
