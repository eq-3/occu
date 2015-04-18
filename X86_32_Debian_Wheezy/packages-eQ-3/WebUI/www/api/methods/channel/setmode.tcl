##
# Channel.setMode
# Legt den Übertragungsmodus eines Kanals fest.
#
# Parameter:
#   id:   [string] Id des Kanals
#   mode: [string] Modus
##

set script {
  var MODE_DEFAULT = "MODE_DEFAULT";
  var MODE_AES     = "MODE_AES";

  var bIsAesActive = false;
  if (mode == "MODE_AES") { bIsAesActive = true; }

  var channel = dom.GetObject(id);
  if (channel)
  {
    channel.ChnAESActive(bIsAesActive);
  
    mode = MODE_DEFAULT;
    if (channel.ChnAESActive() == true) 
    {
      mode = MODE_AES;
    }
    Write(mode);
  }
}

set result [hmscript $script args]

if {("MODE_DEFAULT" == $result) || ("MODE_AES" == $result)} then {
  jsonrpc_response [json_toString $result]
} else {
  jsonrpc_error 500 "homematic script error"
}
