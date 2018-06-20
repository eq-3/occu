 ##
# Interface.setMetadata
# Fügt einem Datenobjekt Metadaten hinzu.
#
# Parameter:
#   objectId: [string] ID des Metadaten-Objects. Üblicherweise die Seriennummer des Gerätes oder Kanals
#   dataId   : [string] Id des zu setzenden Metadatums. Diese ID kann frei gewählt werden
#   value    : [string] Wert, der gespeichert werden soll.
#

set script {
  var o = dom.GetObject(objectId);
  if (o)
  {
    o.RemoveMetaData(dataId);
    o.AddMetaData(dataId, value);
    Write(dataId#": "#o.MetaData(dataId));
  } else {
    Write("Not able to set the metadata");
  }
}

jsonrpc_response [json_toString [hmscript $script args]]
