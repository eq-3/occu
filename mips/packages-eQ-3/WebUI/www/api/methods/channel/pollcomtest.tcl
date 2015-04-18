##
# Channel.pollComTest
# Prüft das Ergebnis eines Funktionstests
#
# Parameter:
#   id: [string] Id des Kanals
#   testId [string] Id des Funktionstests
#
# Rückgabewert [string/bool]
#   Zeitpunkt, zu dem der Test erfolgreich bestanden wurde oder false
##


set script {
  var channel   = dom.GetObject(id);
  var timestamp = testId;

  if (channel)
  {
    if (channel.TestCompletedTime() >= timestamp)
    {
      Write(channel.TestCompletedTime());
    }
    else
    {
      Write("false");
    }
  }
}

set result [hmscript $script args]

switch -exact -- $result {
  ""      { jsonrpc_error 500 "homematic script error" }
  "false" { jsonrpc_response "false" }
  default { jsonrpc_response [json_toString $result] }
}
