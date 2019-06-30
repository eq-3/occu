##
# Device.getRFAddressOfAllDevices
# Gibt die Funk-Addresse aller Geräte zurück
# 
# Parameter:
#   keine
#
# Rückgabewer: [string]
# Funkaddresse
#
##

set script {

  string sDevId;
  string data;
  string metaData;
  string result = "";

  foreach(sDevId, root.Devices().EnumUsedIDs())
  {
    var dev= dom.GetObject(sDevId);
    if ( true == dev.ReadyConfig() )
    {
      metaData = dev.MetaData("DEVDESC");
      foreach (data, metaData.Split(",")) {
        if (data.Substr(0,10) == "RF_ADDRESS") {
          result = result # data#"\t"#dev.Address()#"\t"#dev.Name()#"\n";
        }
      }
    }
  }
  Write(result);
}

jsonrpc_response [json_toString [hmscript $script]]
