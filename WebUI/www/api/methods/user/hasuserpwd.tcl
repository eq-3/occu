##
# User.hasUserPWD
# Ermittelt ob der Anwender ein Passwort gesetzt hat.
#
# Parameter:
#   userID: [string] Id des Anwenders
#
# Rückgabewert: [string]
#    true / false
##

set script {
  var user = dom.GetObject(userID);
  if ( user )
  {
    if ( user.UserPwd() == "" )
    {
      Write("VAL { false } ");
    }
    else
    {
      Write("VAL { true } ");
    }
  }
  else
  {
    Write(false);
  }
}


array set user [hmscript $script args]

set result "\{"
append result "\"UserPWD\" : $user(VAL)"
append result "\}"

jsonrpc_response $result.UserPWD
