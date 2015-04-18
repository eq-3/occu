##
# User.setLanguage
# Speichert die vom User gewählte Sprache
#
# Parameter:
#   userName: [string] userName des Anwenders
#
# Rückgabewert: kein
##

exec echo $args(userLang) > /etc/config/userprofiles/$args(userName).lang
