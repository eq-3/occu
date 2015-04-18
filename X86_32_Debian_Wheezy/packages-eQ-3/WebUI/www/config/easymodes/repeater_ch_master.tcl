#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]

# Gibt ein true zurück, wenn der übergebene Typ in der Liste 'broadcastOnlyTypes' vorhanden ist.
# Returns true if the parameter is contained in the list 'broadcastOnlyBroadcasting' 
proc isDeviceOnlyBroadcasting {devType} {
  set broadcastOnlyTypes [list "WEATHER"]
  set broadcastOnly "false"
  
  foreach val $broadcastOnlyTypes {
    if {$val == $devType} {
     set broadcastOnly "true"
     break
    }
  }
  return $broadcastOnly
}

# This doesn't work with the CFG-Lan-Adapter
proc _get_devicenames {arr_var} {
  upvar $arr_var arr
  array_clear arr
  catch {
    array set result [rega_script {
      string dev_id;
      string devs;
      foreach(dev_id, dom.GetObject(ID_DEVICES).EnumUsedIDs()){
        object dev=dom.GetObject(dev_id);
        if( (dev.Interface() != 65535) && (dev.Address() != "") && (dev.Address() != "BidCoS-RF") && (dev.Address() != "BidCoS-Wir") && (dev.Address() != "System") && dev.CreatingCompleted() ) {
          if ( dev.Interface() == 1007 ) {  
            devs = devs # " " # dev.Address() # " {" # dev.Name() # "} ";
          }
        }
      }
    }]
    array set arr $result(devs)
  }
}

# Returns the names of all devices except the repeater itself
proc get_devicenames {allDevices repeaterAddress} {
  global ise_CHANNELNAMES iface_url iface
  
  set url $iface_url($iface)
  
  # Set the parent address of the repeater. The repeater must not appear in the devicelist
  set repeaterAddr [lindex [split $repeaterAddress ":"] 0]  
  set _iface [string tolower $iface]
  array_clear result 

  # iterate through each device
  foreach val $allDevices {
    array set devDescr $val
    # Each device except the repeater itself AND no channels - we need only the parent address
    if {($devDescr(ADDRESS) != $repeaterAddr ) &&  ($devDescr(PARENT) == "") } {
      set name [string tolower $ise_CHANNELNAMES($iface;$devDescr(ADDRESS))]   
      
      ##array set dev_metadata [xmlrpc $url getAllMetadata [list string $devDescr(ADDRESS)]] 
      ##set name $dev_metadata(NAME)
      
      # Skip the CCU itself (BidCoS-RF)
      if { [string first $_iface $name] == -1} {
        set result($devDescr(ADDRESS)) $ise_CHANNELNAMES($iface;$devDescr(ADDRESS))
      }
    }
  }
  return [array get result]
}

proc createJSObject {ps} {
  set p ""  
  foreach val [array names ps] {
    lappend p "$val:$ps($val),"            
  }
  lappend p "end:0"
  return $p 
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/Repeater.js');</script>"
  
  global iface_url

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr  ps_descr
  
  set url $iface_url($iface)

  array set ccuDescr [xmlrpc $url getDeviceDescription [list string "BidCoS-RF"]]
  set ccuRF $ccuDescr(RF_ADDRESS)
  
  #set jsPS [createJSObject ps]
  set jsPS ""

  puts "<script type=\"text/javascript\">getLangInfo_Special('RF_REPEATER.txt');</script>"

  foreach val [array names ps] {
    lappend jsPS "'$val':$ps($val),"            
  }
  lappend jsPS "'end':0"

  #append HTML_PARAMS(separate_1) "<div> Das Ger&auml;t wird noch nicht unterst&uuml;tzt! </div>"

  # append HTML_PARAMS(separate_1) "<div id=\"param_1\"><textarea id=\"profile_1\" style=\"display:none\" >"
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

  #append HTML_PARAMS(separate_1) "<tr><td colspan=\"5\"><span name=\"linkHeader\">W&auml;hlen Sie die zu verst&auml;rkenden Verbindungen!</span></td></tr>"
  append HTML_PARAMS(separate_1) "<tr><td colspan=\"5\"><span id=\"param_3\" class=\"j_trans\" name=\"linkHeader\"><textarea id=\"profile_3\">\${REPEATER_chooseLinks}</textarea></span></td></tr>"

  #append HTML_PARAMS(separate_1) "<tr><td colspan=\"5\"><span id=\"noLinkAvailable\" style=\"visibility:hidden; display:none\">Es sind keine zu verst&auml;rkenden Verkn&uuml;pfungen vorhanden!</span></td></tr>"
  append HTML_PARAMS(separate_1) "<tr><td  colspan=\"5\"><span id=\"noLinkAvailable\" style=\"visibility:hidden; display:none\"><span id=\"param_1\" class=\"j_trans\"><textarea id=\"profile_1\">\$\{noLinksAvailable\}</textarea></span></span></td></tr>"


  #append HTML_PARAMS(separate_1) "<tr><td id=\"param_4\"><textarea id=\"profile_4\"><span name=\"linkHeader\">\${REPEATER_sender}</span></td><td><span name=\"linkHeader\">\${REPEATER_receiver}</span></td><td><span name=\"linkHeader\">\${REPEATER_description}</span></td><td><span name=\"linkHeader\">\${REPEATER_amplification}</span></td><td><span name=\"linkHeader\">\${REPEATER_broadcast}</span></textarea></td></tr>"
  append HTML_PARAMS(separate_1) "<tr><td><span name=\"linkHeader\"><span id=\"param_4\" class=\"j_trans\" ><textarea id=\"profile_4\">\${REPEATER_sender}</textarea></span></span></td><td><span name=\"linkHeader\"><span id=\"param_5\" class=\"j_trans\"><textarea id=\"profile_5\">\${REPEATER_receiver}</textarea></span></span></td><td><span name=\"linkHeader\"><span id=\"param_6\" class=\"j_trans\"><textarea id=\"profile_6\">\${REPEATER_description}</textarea></span></span></td><td><span name=\"linkHeader\"><span id=\"param_7\" class=\"j_trans\"><textarea id=\"profile_7\">\${REPEATER_amplification}</textarea></span></span></td><td><span name=\"linkHeader\"><span id=\"param_8\" class=\"j_trans\"><textarea id=\"profile_8\">\${REPEATER_broadcast}</textarea></span></span></td></tr>"

  set counter 0
  set idCounter 1
  set allLinks [xmlrpc $url getLinks]
  set allDevices [xmlrpc $url listDevices]
  
  puts "<input id=\"counter\" type=\"hidden\" value=\"0\">"

  foreach _link  $allLinks {
  
    set brokenLink 0
    array set link $_link
   
    # $link(FLAGS) & 0x01 = Sender broken
    # $link(FLAGS) & 0x02 = Receiver broken
    if { $link(FLAGS) & 0x01 || $link(FLAGS) & 0x02 } {
      set brokenLink 1
    } 
  
    # Zeige nur intakte Links
    if {$brokenLink == 0} {
    
      # Kanalbeschreibung des Senders 
      array set devDescrSender [xmlrpc $url getDeviceDescription $link(SENDER)]
      # Geraetebeschreibung des Senders
      array set devSenderParent [xmlrpc $url getDeviceDescription [list string $devDescrSender(PARENT)]]    
  
    
      # Kanalbeschreibung des Empfaengers
      array set devDescrReceiver [xmlrpc $url getDeviceDescription $link(RECEIVER)]
      # Geraetebeschreibung des Empfaengers
      array set devReceiverParent [xmlrpc $url getDeviceDescription [list string $devDescrReceiver(PARENT)]]    
    
      set senderRF $devSenderParent(RF_ADDRESS)
      set receiverRF $devReceiverParent(RF_ADDRESS)

      # Falls AES-verschlüsselte Verbindungen nicht repeated werden dürfen, muss auf == 0 geprüft werden.
      # Wenn sie repeated werden dürfen, kann die Prüfung auf AES_ACTICE entfallen.
      # Da es zur Zeit noch nicht feststand, habe ich hier schon mal vorbereitend eine Bedingung eingebaut, die immer true ist,
      # d. h., AES-verschlüsselte Verbindungen werden auch repeated.
      if {$devDescrSender(AES_ACTIVE) != -1} {
        append HTML_PARAMS(separate_1) "<tr id=\"$senderRF-$receiverRF\">"
        
          # durch Auskommentieren wird die Funkadresse der Geräte mit angezeigt, die nächsten 2 Zeilen müssen dann aber einkommentiert werden.
          #append HTML_PARAMS(separate_1) "<td>$link(SENDER)<br/>$senderRF</td>"
          #append HTML_PARAMS(separate_1) "<td>$link(RECEIVER)<br/>$receiverRF</td>"
          append HTML_PARAMS(separate_1) "<td>$link(SENDER)</td>"
          append HTML_PARAMS(separate_1) "<td>$link(RECEIVER)</td>"
          
          append HTML_PARAMS(separate_1) "<td>[cgi_quote_html $link(DESCRIPTION)]</td>"
          append HTML_PARAMS(separate_1) "<td><input type=\"checkbox\" class=\"link-$senderRF\_$receiverRF\" name=\"link-$senderRF\_$receiverRF\" onclick=\"setLinksOnly(this, $senderRF, $receiverRF)\"></td>"  
          append HTML_PARAMS(separate_1) "<td><input type=\"checkbox\" class=\"linkBroadcast-$senderRF\_$receiverRF\" name=\"linkBroadcast-$senderRF\_$receiverRF\" onclick=\"setLinkBroadcast(this, $senderRF, $receiverRF)\"></td>"
  
          if {! [info exists senderReceiver($senderRF-$receiverRF)]} {  
        
            set counter [expr $counter + 1]
        
            append HTML_PARAMS(separate_1) "<td id=\"storeContainer_$counter\" class=\"j_linkContainer j_storeContainer\" name=\"linkContainer\" style=\"display:none\">"  
            
            # stores the sender values
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_$idCounter\" name=\"ADDRESS_SENDER$counter\_HIGH_BYTE\" value=\"0\" class=\"j_input\">" 
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 1]\" name=\"ADDRESS_SENDER$counter\_MID_BYTE\" value=\"0\" class=\"j_input\">" 
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 2]\" name=\"ADDRESS_SENDER$counter\_LOW_BYTE\" value=\"0\" class=\"j_input\">" 
      
            # stores the receiver values
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 3]\" name=\"ADDRESS_RECEIVER$counter\_HIGH_BYTE\" value=\"0\" class=\"j_input\">" 
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 4]\" name=\"ADDRESS_RECEIVER$counter\_MID_BYTE\" value=\"0\" class=\"j_input\">" 
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 5]\" name=\"ADDRESS_RECEIVER$counter\_LOW_BYTE\" value=\"0\" class=\"j_input\">" 
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 6]\" name=\"BROADCAST_BEHAVIOR$counter\" value=\"0\" class=\"j_input\">" 
            append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 7]_temp\" name=\"tmp$counter\" class=\"tmp-$senderRF\_$receiverRF\" value=\"0\">" 

            append HTML_PARAMS(separate_1) "</td>"  
            set senderReceiver($senderRF-$receiverRF) "true"
            set idCounter [expr $idCounter + 7]
          }
        append HTML_PARAMS(separate_1) "</tr>"
      }
    } 
  }
 
  if {$counter == 0} {
    puts "<script type=\"text/javascript\">"
    puts "var linkHeader = document.getElementsByName(\"linkHeader\");"
    puts "for (var loop = 0; loop < linkHeader.length; loop++) {"
    puts "linkHeader\[loop\].style.display = \"none\";"
    puts "}"
    puts "document.getElementById(\"noLinkAvailable\").style.visibility = \"visible\";"
    puts "document.getElementById(\"noLinkAvailable\").style.display = \"block\";"
    puts "</script>"
  }  
  
  append HTML_PARAMS(separate_1) "</tr>"  
 
  # Hier werden die Geräte angezeigt, die beim Aufruf von 'isDeviceOnlyBroadcasting' ein 'true' zurückgeben.
  # Das sind z. B. Wettersensoren (Temperatur/Feuchte)
  #set headerText "Temperatur-/Feuchte - Sensoren, die nur Rundsendungen erlauben!"
  set headerText "\${REPEATER_broadcastOnly}"
  append HTML_PARAMS(separate_1) "<tr height=\"25\" ></tr>"
  append HTML_PARAMS(separate_1) "<tr id=\"broadcastOnlyTbl\"><td colspan=\"5\"><span id=\"broadcastOnlyHeader\" style=\"visibility:hidden;\"><span id=\"param_9\" class=\"j_trans\"><textarea id=\"profile_9\"><u>$headerText</u></textarea></span></td></tr>"
  
  foreach val $allDevices {
    array set devDescr $val
    if { [isDeviceOnlyBroadcasting $devDescr(TYPE)] == "true"} {
      array set parentDescr [xmlrpc $url getDeviceDescription [list string $devDescr(PARENT)]]
      set senderRF  $parentDescr(RF_ADDRESS)
      set receiverRF "000000"

      append HTML_PARAMS(separate_1) "<tr id=\"$senderRF\">"
        append HTML_PARAMS(separate_1) "<td>$devDescr(ADDRESS)</td>"
        append HTML_PARAMS(separate_1) "<td>$parentDescr(TYPE)</td><td></td>"

        append HTML_PARAMS(separate_1) "<td></td>"
        append HTML_PARAMS(separate_1) "<td><input type=\"checkbox\" id=\"broadcast-$senderRF\" class=\"broadcast-$senderRF-$receiverRF\" name=\"broadcast-$senderRF-$receiverRF\" onclick=\"setBroadcastOnly(this, $senderRF, $receiverRF)\"></td>" 
        set counter [expr $counter + 1]
        append HTML_PARAMS(separate_1) "<td id=\"storeContainer_$counter\" class=\"j_broadcastOnlyContainer j_storeContainer\" name=\"broadcastOnlyContainer\" style=\"display:none\">"
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_$idCounter\" name=\"ADDRESS_SENDER$counter\_HIGH_BYTE\" value=\"0\" class=\"j_input\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 1]\" name=\"ADDRESS_SENDER$counter\_MID_BYTE\" value=\"0\" class=\"j_input\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 2]\" name=\"ADDRESS_SENDER$counter\_LOW_BYTE\" value=\"0\" class=\"j_input\">" 
      
          # stores the receiver values
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 3]\" name=\"ADDRESS_RECEIVER$counter\_HIGH_BYTE\" value=\"0\" class=\"j_input\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 4]\" name=\"ADDRESS_RECEIVER$counter\_MID_BYTE\" value=\"0\" class=\"j_input\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 5]\" name=\"ADDRESS_RECEIVER$counter\_LOW_BYTE\" value=\"0\" class=\"j_input\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 6]\" name=\"BROADCAST_BEHAVIOR$counter\" value=\"0\" class=\"j_input\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 7]_temp\" name=\"tmp$counter\" class=\"tmp-$senderRF\" value=\"0\">" 
        append HTML_PARAMS(separate_1) "</td>"    
      append HTML_PARAMS(separate_1) "</tr>"
      
      set idCounter [expr $idCounter + 7]
      
      puts "<script type=\"text/javascript\">"
        puts "document.getElementById(\"broadcastOnlyHeader\").style.visibility = \"visible\";"
      puts "</script>"  
    }

  }

  
  
  # Some space  
  append HTML_PARAMS(separate_1) "<tr height=\"25\" ></tr>"
  
  # Next Row - Anzeige aller Geräte. 
  append HTML_PARAMS(separate_1) "<tr id=\"deviceSystemTbl\">"
    # append HTML_PARAMS(separate_1) "<td colspan=\"5\"><u>Verst&auml;rkende Verbindung zwischen Ger&auml;t und Zentrale</u></td>"
    append HTML_PARAMS(separate_1) "<td id=\"param_2\" class=\"j_trans\" colspan=\"3\"><textarea id=\"profile_2\">\${linksDeviceCCU}</textarea></td>"
    append HTML_PARAMS(separate_1) "<td id=\"param_10\" class=\"j_trans\"><textarea id=\"profile_10\">\${REPEATER_amplification}</textarea></td>"
    append HTML_PARAMS(separate_1) "<td id=\"param_11\" class=\"j_trans\"><textarea id=\"profile_11\">\${REPEATER_broadcast}</textarea></td>"
  append HTML_PARAMS(separate_1) "</tr>"

  #array set devnames ""
  #get_devicenames devnames
  
  array_clear devnames
  array set devnames [get_devicenames $allDevices $address] 
    
  foreach name [lsort [array names devnames]] {
    array set parentDescr [xmlrpc $url getDeviceDescription [list string $name]]
    set senderRF  $parentDescr(RF_ADDRESS)
    if {$senderRF != $ccuRF} {  
      append HTML_PARAMS(separate_1) "<tr id=\"$senderRF-$ccuRF\">" 
        #append HTML_PARAMS(separate_1) "<td colspan=\"3\">$devnames($name)</td>"
        append HTML_PARAMS(separate_1) "<td>$parentDescr(ADDRESS)</td><td colspan=\"2\">$parentDescr(TYPE)</td>"
      
        append HTML_PARAMS(separate_1) "<td><input type=\"checkbox\" id=\"devSystem-$senderRF\_$ccuRF\" onclick=\"setDeviceCCU(this, $senderRF, $ccuRF)\"></td>"
        append HTML_PARAMS(separate_1) "<td><input type=\"checkbox\" class=\"ccuBroadcast-$senderRF\_$ccuRF\" name=\"ccuBroadcast-$senderRF\_$ccuRF\" onclick=\"setCCUBroadcast(this, $senderRF, $ccuRF)\"></td>"
        set counter [expr $counter + 1]
        append HTML_PARAMS(separate_1) "<td id=\"storeContainer_$counter\" class=\"j_deviceSystemContainer j_storeContainer\" name=\"deviceSystemContainer\" style=\"display:none\">"
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_$idCounter\" name=\"ADDRESS_SENDER$counter\_HIGH_BYTE\" class=\"SENDER-$senderRF\_$ccuRF-HIGH_BYTE j_input\" value=\"0\" >" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 1]\" name=\"ADDRESS_SENDER$counter\_MID_BYTE\" class=\"SENDER-$senderRF\_$ccuRF-MID_BYTE j_input\" value=\"0\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 2]\" name=\"ADDRESS_SENDER$counter\_LOW_BYTE\" class=\"SENDER-$senderRF\_$ccuRF-LOW_BYTE j_input\" value=\"0\">" 
      
          # stores the receiver values
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 3]\" name=\"ADDRESS_RECEIVER$counter\_HIGH_BYTE\"  class=\"RECEIVER-$senderRF\_$ccuRF-HIGH_BYTE j_input\" value=\"0\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 4]\" name=\"ADDRESS_RECEIVER$counter\_MID_BYTE\"  class=\"RECEIVER-$senderRF\_$ccuRF-MID_BYTE j_input\" value=\"0\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 5]\" name=\"ADDRESS_RECEIVER$counter\_LOW_BYTE\"  class=\"RECEIVER-$senderRF\_$ccuRF-LOW_BYTE j_input\" value=\"0\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 6]\" name=\"BROADCAST_BEHAVIOR$counter\" class=\"BROADCAST-$senderRF\_$ccuRF j_input\" value=\"0\">" 
          append HTML_PARAMS(separate_1)  "<input size=\"3\" type=\"text\" id=\"separate_CHANNEL_1_[expr $idCounter + 7]_temp\" name=\"tmp$counter\" class=\"tmp-$senderRF\_$ccuRF\" value=\"0\">" 
        
        append HTML_PARAMS(separate_1) "</td>"    
      
      append HTML_PARAMS(separate_1) "</tr>"
  
      set idCounter [expr $idCounter + 7]
    }
  }
   
  append HTML_PARAMS(separate_1) "</table>"

  # translate the page
  puts "<script type=\"text/javascript\">"
    puts "var elems = jQuery(\".j_trans\");"
    puts "elems.each(function(index){var loop = index + 1; translate(loop.toString(), '$special_input_id'); });"
  puts "</script>"


  # By entering the page this will initialize all checkboxes 
  puts "<script type=\"text/javascript\">initAllCheckBoxes({$jsPS},$ccuRF);</script>"
}

constructor
