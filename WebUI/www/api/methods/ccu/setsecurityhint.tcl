##
# CCU.setSecurityHint
# Legt die Datei /etc/config/userAckSecurityHint an
#
# Parameter:
#  kein
#
# Rückgabewert: immer true
##


catch {exec touch /etc/config/userAckSecurityHint}

jsonrpc_response true


