##
# Interface.getLogLevel
# Ermittelt die Stufe der Fehlerprotokollierung.
#
# Parameter:
#   interface: [string]  Bezeichnung der Schnittstelle
#
# Rückgabewert: [integer]
#   Stufe der Fehlerprotokollierung:
#     0 alles 
#     1 Debugmeldungen, Infomeldungen, Notizmeldungen, normale Fehler, schwere Fehler
#     2 Infomeldungen, Notizmeldungen, normale Fehler, schwere Fehler
#     3 Notizmeldungen, Warnungen, normale Fehler, schwere Fehler
#     4 Warnungen, normale Fehler, schwere Fehler
#     5 normale Fehler, schwere Fehler
#     6 schwere Fehler
##

checkXmlRpcStatus [catch { set level [xmlrpc $interface(URL) logLevel] }]

jsonrpc_response $level
