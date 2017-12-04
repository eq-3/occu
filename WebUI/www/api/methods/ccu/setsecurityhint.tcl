##
# CCU.setSecurityHint
# Die Datei wird beim ersten Start der CCU2 angelegt, wenn der User bestätigt, dass er ihn gelesen hat.
#
# Parameter:
#  kein
#
# Rückgabewert: immer true
##


catch {exec touch /etc/config/userAckSecurityHint}

jsonrpc_response true


