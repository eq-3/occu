##
# User.getUserPWD
# Ermittelt das Passwort des Anwenders
#
# Parameter:
#   userID: [string] Id des Anwenders
#
# Rückgabewert: [string]
#    Userpasswort
##

set script {
  var user = dom.GetObject(userID);
  if (user)
  {
    Write("PWD {" # user.UserPwd() # "}");
  }
  else
  {
    Write(false);
  }
}

array set user [hmscript $script args]

set result "\{"
append result "\"UserPWD\" : [json_toString $user(PWD)]"
append result "\}"

jsonrpc_response $result.UserPWD
