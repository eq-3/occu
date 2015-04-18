##
# User.isNoExpert
# Ermittelt, ob ein Anwender Experte ist
#
# Parameter:
#   id: [string] Id des Anwenders
#
# Rückgabewert: [bool]
#    true, falls der Anwender kein Experte ist
##

set script {
  var user = dom.GetObject(id);
  if (user)
  {
          Write(user.UserEasyLinkMode());
  }
  else
  {
          Write("false");
  }
}

jsonrpc_response [hmscript $script args]
