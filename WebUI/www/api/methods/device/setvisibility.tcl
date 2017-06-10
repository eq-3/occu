##
# Device.setVisiblity
# Legt fest, ob das Gerät für normale Anwender sichbar ist
#
# Parameter:
#   id:        [string] Id des Gerätes
#   isVisible: [bool]   Gerät ist sichtbar (true) oder nicht (false)
##

set script {
  var bIsVisible = false;
  if (isVisible == "true") { bIsVisible = true; }

  var dev = dom.GetObject(id);
  if (dev)
  {
    dev.Visible(bIsVisible);  
    Write(dev.Visible());
  }
}

set result [hmscript $script args]

if {("true" == $result) || ("false" == $result)} then {
  jsonrpc_response $result
} else {
  jsonrpc_error 500 "homematic script error"
}
