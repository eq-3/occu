##
# Channel.getName
# Liefert den Namen des Kanals.
#
# Paramter:
#   address: [string] Adresse des Kanals
#
# Rückgabewert: [string]
#   Kanalname
##

set script {
  object obj = dom.GetObject(ID_DEVICES);
  if ( obj )
  {
    string tmp = "";
    foreach( tmp, obj.EnumEnabledIDs() )
    {
       ! Device
       object dev = dom.GetObject(tmp);
       string s1;
       ! Channels of the device
       foreach( s1, dev.Channels().EnumEnabledVisibleIDs() )
       {
          object oCH = dom.GetObject(s1);
          if (address == oCH.Address())
          {
            Write(oCH.Name());
          }
       }
    }
  }
}


jsonrpc_response [json_toString [hmscript $script args]]

