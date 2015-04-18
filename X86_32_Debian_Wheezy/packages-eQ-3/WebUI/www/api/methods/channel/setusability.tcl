##
# Channel.setUsability
# Legt fest, ob der Kanal für normale Anwender bedienbar ist
#
# Parameter:
#   id:       [string] Id des Kanals
#   isUsable: [bool]   Kanal ist bedienbar (true) oder nicht (false)
##

set script {
  var iAccessRights = iarRead;
  if (isUsable == "true") { iAccessRights = iarFullAccess; }

  var channel = dom.GetObject(id);
  if (channel)
  {
    channel.UserAccessRights(iulOtherThanAdmin, iAccessRights);
  
    if (channel.UserAccessRights(iulOtherThanAdmin) == iarFullAccess)
    {
      Write("true");
    }
    else { Write("false"); }
  }
}


set result [hmscript $script args]

if {("true" == $result) || ("false" == $result)} then {
  jsonrpc_response $result
} else {
  jsonrpc_error 500 "homematic script error"
}
