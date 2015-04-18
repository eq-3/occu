##
# CCU.getSSHState
# Prüft, ob die Datei /etc/config/sshEnabled vorhanden ist
#
# Parameter: kein
#
# Rückgabewert: Zustand 0 (deaktiviert) oder 1 (aktiviert)
##

set file "/etc/config/sshEnabled"

jsonrpc_response [file exists $file]