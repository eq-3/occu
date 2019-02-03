 ##
# Interface.removeMetadata
# Entfernt ein Metadatum eines Objects
#
# Parameter:
#   objectId: [string] ID des Metadaten-Objects.
#   dataId   : [string] Id des zu löschenden Metadatums.
#

set script {
  var o = dom.GetObject(objectId);
  if (o.MetaData(dataId) != null)
  {
    o.RemoveMetaData(dataId);
    Write(objectId#" - matadata "#dataId#" successfully deleted!");
  } else {
    Write(objectId#" - metadata "#dataId#" not found!");
  }
}

jsonrpc_response [json_toString [hmscript $script args]]
