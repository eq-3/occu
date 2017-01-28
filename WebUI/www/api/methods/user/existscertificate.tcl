##
# User.existsCertificate
# Prüft, ob ein Zertifikat zur Verwendung von https vorhanden ist
#
# Parameter:
#   keine
#
# Rückgabewert: 0/1

set result false;

if {[file exists /etc/config/server.pem] == 1} {
  set result true;
}

jsonrpc_response $result