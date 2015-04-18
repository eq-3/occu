##
# User.getUserName
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
          Write("NAME {" # user.UserFirstName() # "}");
  }
  else
  {
          Write(false);
  }
}

array set user [hmscript $script args]

set result "\{"
append result "\"UserName\" : [json_toString $user(NAME)]"
append result "\}"

jsonrpc_response $result.UserName
