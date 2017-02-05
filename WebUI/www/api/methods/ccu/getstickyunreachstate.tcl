##
# CCU.getStickyUnreachState
# Prüft, ob die Datei /etc/config/hideStickyUnreach vorhanden ist
#
# Parameter: kein
#
# Rückgabewert: Zustand 0 (deaktiviert) oder 1 (aktiviert)
##

set file "/etc/config/hideStickyUnreach"

jsonrpc_response [file exists $file]