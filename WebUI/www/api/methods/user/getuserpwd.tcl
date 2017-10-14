##
# User.getUserPWD
# Ermittelt den Usernamen des Anwenders
#
# Parameter:
#   id: [string] Id des Anwenders
#
# Rückgabewert: [string]
#    Username
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
