##
# Diagram.getDataSourceGroups
# Ermittelt alle bekannten Gruppen von Datenquellen
#
# Parameter:
#   <keine>
#
# Rückgabewert: [array]
# Array einer Liste der zur Verfügung stehenden Gruppen von Datenquellen
##

# funktioniert mit $interface(URL) noch nicht
#checkXmlRpcStatus [catch { set level [xmlrpc $interface(URL) logLevel [list int $level]] }]

proc convKey2Array {keys} {

  set length [llength $keys]
  set loop 1
  set result "\["

  foreach key $keys {
    append result "'$key'"
    if {$loop != $length} {append result ","}
    incr loop;
  }
  append result "\]"
  return $result
}

# TEST
# URL has to be set to the central or so....
set groupList [xmlrpc "172.25.50.140:54321" "listDataSourceGroups" ""]

 set result "\["

  set lengthList [llength $groupList]
  set loopList 1

 foreach group $groupList {
  set lengthGroup [llength $group]
  set loopGroup 0

  append result "\{"
  foreach {key val} $group {
    if {$key == "KEYS"} {
       set val [convKey2Array $val]
       append result "'$key':$val"

    } else {
      append result "'$key':'$val'"
    }
    if {$loopGroup < $lengthGroup - 2} {append result ,}
    incr loopGroup 2
  }
  append result "\}"

  if {$loopList < $lengthList} {append result ","}
  incr loopList
 }

 append result "\]"

 exec echo $result > /tmp/result.txt

jsonrpc_response $result


