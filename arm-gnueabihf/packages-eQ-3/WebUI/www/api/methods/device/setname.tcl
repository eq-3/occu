##
# Device.setName
# Legt den Namen eines Geräts fest.
# 
# Parameter:
#   id: [string] Id des Geräts
#   name: [string] Neuer Name des Geräts
#
# Rückgabewer: [string]
#  Neuer Name des Geräts.*
#
#  *: Gerätenamen müssen immer eindeutig sein. Falls der neue Gerätename dies nicht
#     ist, wird er entsprechend angepasst.
##

set script {
  var device = dom.GetObject(id);
  if (device)
  {
    device.Name(name);
    Write(device.Name());
  }
}

jsonrpc_response [json_toString [hmscript $script args]]
