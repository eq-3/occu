 ##
# Interface.getMetadata_crRFD
# Liest Metadaten eines Datenobjects, welche vom crRFD gespeichert wurden
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   objectId: [string] ID des Metadaten-Objects. Üblicherweise die Seriennummer des Gerätes oder Kanals
#   dataId   : [string] Id des zu setzenden Metadatums. Diese ID kann frei gewählt werden


set objectId $args(objectId)
set dataId $args(dataId)

set result [xmlrpc $interface(URL) getMetadata [list string $objectId] [list string $dataId]]

jsonrpc_response [json_toString $result]