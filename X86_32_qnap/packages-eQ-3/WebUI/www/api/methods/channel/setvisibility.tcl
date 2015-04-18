##
# Channel.setVisiblity
# Legt fest, ob der Kanal für normale Anwender sichbar ist
#
# Parameter:
#   id:        [string] Id des Kanals
#   isVisible: [bool]   Kanal ist sichtbar (true) oder nicht (false)
##

set script {
  var bIsVisible = false;
  if (isVisible == "true") { bIsVisible = true; }

  var channel = dom.GetObject(id);
  if (channel)
  {
    channel.Visible(bIsVisible);  
    Write(channel.Visible());
  }
}

set result [hmscript $script args]

if {("true" == $result) || ("false" == $result)} then {
  jsonrpc_response $result
} else {
  jsonrpc_error 500 "homematic script error"
}
