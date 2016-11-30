#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce session.tcl
sourceOnce ic_common.tcl
loadOnce tclrpc.so

#Datenbank der Gerätebeschreibungen fürs WebUI
sourceOnce devdescr/DEVDB.tcl 
  
set cmd ""

proc cmd_removeLink {} {

  global iface_url USERPROFILESPATH
  set sender_address ""
  set receiver_address ""
  set iface ""

  catch { import iface }
  catch { import sender_address }
  catch { import receiver_address }

  set url $iface_url($iface)
  set HmIPIdentifier "HmIP-RF"

  if { ![info exist env(IC_OPTIONS)] || ([string first NO_PROFILE_MAPPING $env(IC_OPTIONS)] < 0) } {

      # Verknuepfungen einlesen und in map_link ablegen
      if { ! [catch {open $USERPROFILESPATH/link.db RDONLY} fd] } then {
        while {![eof $fd]} {
            set map_link([gets $fd]) "true"
        }
        close $fd
      } 
  
      # Geloeschte Verknuepfung aus link.db entfernen
      if {[info exists map_link($sender_address-$receiver_address)]} {
            set fd [open $USERPROFILESPATH/link_tmp.db w+]
        foreach tmp [array names map_link] {
          if {$tmp != "$sender_address-$receiver_address" } {
                    puts $fd $tmp
          }
        }
        close $fd
        file rename -force $USERPROFILESPATH/link_tmp.db $USERPROFILESPATH/link.db
      } 
  }
    
  #cgi_debug -on

  set errorCode [catch {xmlrpc $url removeLink [list string $sender_address] [list string $receiver_address]}]

   if { (! $errorCode) || ($iface == $HmIPIdentifier) } then {
    #puts "<script type=\"text/javascript\">alert('Loeschen der Verknuepfung war erfolgreich!');</script>"
    cmd_ShowConfigPendingMsg
  } else {
    #puts "<script type=\"text/javascript\">alert('Loeschen der Verknuepfung war nicht erfolgreich!');</script>"
    puts "<script type=\"text/javascript\">alert(translateKey(\"dialogRemoveLinkFailed\"));</script>"
  }
}

proc cmd_setLinkInfo {} {

  global iface_url sid sidname

  set iface              ""
  set sender_address     ""
  set receiver_address   ""
  set name               ""
  set description        ""

  catch { import iface }
  catch { import sender_address }
  catch { import receiver_address }
  catch { import name }
  catch { import description }

  set url $iface_url($iface)

  if { [catch { xmlrpc $url setLinkInfo [list string $sender_address] [list string $receiver_address] [list string $name] [list string $description] } ] } then {
    #puts "<script type=\"text/javascript\">alert('Fehler beim Speichern des Verknüpfungsnamen von $sender_address mit $receiver_address.');</script>"
    puts "<script type=\"text/javascript\">alert(translateKey('dialogSetLinkNameErrorA') + ' $sender_address ' + translateKey('dialogSetLinkNameErrorB') + ' $receiver_address.');</script>"
  } else {
  }
  #puts "<script type=\"text/javascript\">if (ProgressBar) ProgressBar.IncCounter(\"Name und Beschreibung von Verknuepfung $sender_address mit $receiver_address gesetzt.\");</script>"
  puts "<script type=\"text/javascript\">if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogSetLinkInfoMsgSuccessA\")+\" $sender_address \"+translateKey(\"dialogSetLinkInfoMsgSuccessB\") + \" $receiver_address \" +translateKey(\"dialogSetLinkInfoMsgSuccessC\"));</script>"
}

proc cmd_addLink {} {

  global iface_url sid sidname

  #cgi_debug -on

  set iface              ""
  set sender_address     ""
  set sender_group       ""
  set receiver_address   ""
  set name               ""
  set description        ""
  set group_name         ""
  set group_description  ""
  set redirect_url       ""

  set HmIPIdentifier "HmIP-RF"

  catch { import iface }
  catch { import sender_address }
  catch { import sender_group }
  catch { import receiver_address }
  catch { import name }
  catch { import description }
  catch { import group_name }
  catch { import group_description }
  catch { import redirect_url }

  set url $iface_url($iface)

  set errorCode [catch { xmlrpc $url addLink [list string $sender_address] [list string $receiver_address] }]

  if { ! $errorCode } then {

    #Verknüpfung erfolgreich angelegt. Namen und Beschreibungen noch nicht gesetzt.
    set ret 1
    
    if { $description != "" || $name != "" } then {

      if { [catch { xmlrpc $url setLinkInfo [list string $sender_address] [list string $receiver_address] [list string $name] [list string $description] } ] } then {
        #Verknüpfung erfolgreich angelegt. Name und Beschreibung der ersten Verknüpfung konnte nicht gesetzt werden.
        set ret -2
      } else {
        #Verknüpfung erfolgreich angelegt. Name und Beschreibung der ersten Verknüpfung erfolgreich gesetzt.
        set ret 2
      }
    }

    if { $group_description != "" || $group_name != "" } then {

      if { [catch { xmlrpc $url setLinkInfo [list string $sender_group] [list string $receiver_address] [list string $group_name] [list string $group_description] } ] } then {
        #Verknüpfung erfolgreich angelegt. Name und Beschreibung der zweiten Verknüpfung konnte nicht gesetzt werden.
        set ret -3
      } else {
        #Verknüpfung erfolgreich angelegt. Name und Beschreibung der zweiten Verknüpfung erfolgreich gesetzt.
        set ret 3
      }
    }

  } else {
    set ret -1
  }

  #puts "<script type=\"text/javascript\">var ConfigPendingFrm = AddLinkSuccessForm('$iface', '$sender_address', '$receiver_address', '$sidname', '$sid', '$redirect_url');</script>"

  #puts "<script type=\"text/javascript\">if (ProgressBar) ProgressBar.IncCounter(\"Verknuepfung wurde angelegt.\");</script>"
  puts "<script type=\"text/javascript\">if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogCreateLinkSuccessProgressBar\"));</script>"
  cmd_ShowConfigPendingMsg
}
proc cmd_ShowConfigPendingMsg {} {

  global iface_url sid sidname dev_descr_sender  
  
  array set ise_CHANNELNAMES ""
  ise_getChannelNames ise_CHANNELNAMES

  set HmIPIdentifier "HmIP-RF"

  set iface            ""
  set sender_address   ""
  set receiver_address ""
  set redirect_url     ""
  set go_back          "false"
  
  catch { import iface }
  catch { import sender_address }
  catch { import receiver_address }
  catch { import redirect_url }
  catch { import go_back }

  set url $iface_url($iface)
  
  #SENDER================================================================
  set sender_has_configpending 0

    catch { 
    array set dev_descr_sender [xmlrpc $url getDeviceDescription [list string $sender_address]]

    if {$dev_descr_sender(PARENT) == ""} then {
      #Geräteadresse übergeben
      set sender_type $dev_descr_sender(TYPE)
      set sender_parent $sender_address
    
    } else {
      #Kanaladresse übergeben
      set sender_type $dev_descr_sender(PARENT_TYPE)
      set sender_parent $dev_descr_sender(PARENT)
    }

    if { [catch { set sendername $ise_CHANNELNAMES($iface;$sender_address)} ] } then {
      #ise kennt Gerät nicht. Das hat nur Auswirkung auf den vollen Namen.
      #set sendername "Unbenanntes Ger&auml;t"
      set sendername "\${lblUnknownDevice}"
    }

    array set valueset_sender [xmlrpc $url getParamset [list string $sender_parent:0] [list string VALUES]]
    set sender_configpending [expr {$valueset_sender(CONFIG_PENDING)?"1":"0"} ]

    set sender_has_configpending 1
  }
  #======================================================================

  #RECEIVER==============================================================
  set receiver_has_configpending 0
  
  catch {
    array set dev_descr_receiver [xmlrpc $url getDeviceDescription [list string $receiver_address]]
    
    if {$dev_descr_receiver(PARENT) == ""} then {
      #Geräteadresse übergeben
      set receiver_type $dev_descr_receiver(TYPE)
      set receiver_parent $receiver_address
    } else {
      #Kanaladresse übergeben
      set receiver_type $dev_descr_receiver(PARENT_TYPE)
      set receiver_parent $dev_descr_receiver(PARENT)
    }

    if { [catch { set receivername $ise_CHANNELNAMES($iface;$receiver_address)} ] } then {
      #ise kennt Gerät nicht. Das hat nur Auswirkung auf den vollen Namen.
      #set receivername "Unbenanntes Ger&auml;t"
      set receivername "\${lblUnknownDevice}"
    }

    array set valueset_receiver [xmlrpc $url getParamset [list string $receiver_parent:0] [list string VALUES]]
    set receiver_configpending [expr {$valueset_receiver(CONFIG_PENDING)?"1":"0"} ]

    set receiver_has_configpending 1
  }
  #======================================================================

  #puts "<script type=\"text/javascript\">if (ProgressBar) ProgressBar.IncCounter(\"ConfigPending-PopUp wird angezeigt.\");</script>"
  puts "<script type=\"text/javascript\">"
  if {$iface != "VirtualDevices"} {
    puts "try \{"
    puts "  ConfigPendingFrm.ResetTable();"
    puts "\} catch (e) \{"
    puts "  ConfigPendingFrm = new ConfigPendingMsgBox(800, 600);"
    puts "\}"

    if { $sender_has_configpending == 1 } then {
      puts "ConfigPendingFrm.ShowConfigPending('$iface', '$sender_address',   '[cgi_quote_html $sendername]',   '$sender_type',   parseInt($sender_configpending),   parseInt(-1), ConfigPendingFrm.CONFIGPENDING_SENDER);"
    } else {
      puts "ConfigPendingFrm.SetDevice('$iface', '$sender_address', ConfigPendingFrm.CONFIGPENDING_SENDER);"
    }

    if { $receiver_has_configpending == 1 } then {
      puts "ConfigPendingFrm.ShowConfigPending('$iface', '$receiver_address', '[cgi_quote_html $receivername]', '$receiver_type', parseInt($receiver_configpending), parseInt(-1), ConfigPendingFrm.CONFIGPENDING_RECEIVER);"
    } else {
      puts "ConfigPendingFrm.SetDevice('$iface', '$receiver_address', ConfigPendingFrm.CONFIGPENDING_RECEIVER);"
    }

    puts "ConfigPendingFrm.setReturnURL('$sidname', '$sid', '$redirect_url', $go_back);"
    puts "ConfigPendingFrm.show();"
  } else {
      puts "var data = '{ \"virtualDeviceSerialNumber\" : \"$sender_address\" }';"
      puts "CreateCPPopup(\"/pages/jpages/group/configureDevices\", data);"
  }
  puts "</script>"
}

proc cmd_activateLinkParamset {} {

  global iface_url

  set sender_address ""
  set receiver_address ""
  set iface ""

  catch { import iface }
  catch { import sender_address }
  catch { import receiver_address }

  set url $iface_url($iface)
  
  if { [catch { xmlrpc $url activateLinkParamset [list string $receiver_address] [list string $sender_address] [list bool 0] }  ] } then {
    #puts "<script type=\"text/javascript\">ShowErrorMsg(\"[cgi_quote_html "Das Profil konnte nicht ausgelöst werden. Sorgen Sie dazu bitte dafür, dass sich das Gerät innerhalb der Funkreichweite befindet und aktiv ist."]\");</script>"
    puts "<script type=\"text/javascript\">ShowErrorMsg(translateKey(\"dialogActivateLinkParamsetError\"));</script>"
  } else {
    #puts "<script type=\"text/javascript\">ShowInfoMsg(\"[cgi_quote_html "Das Profil wurde erfolgreich ausgelöst."]\");</script>"
    puts "<script type=\"text/javascript\">ShowInfoMsg(translateKey(\"dialogActivateLinkParamsetSuccess\"));</script>"
  }
}

proc getFwUpdateError {errorKey result} {

  # result looks like the following:
    # Fault received on xmlrpc call updateFirmware({"XYZ0004711"})
    # faultCode=-1
    # faultString=Bootloader in device XYZ0004711 didn't start

  # this will extract the given errorKey (faultCode or faultString)
  set errorCode [string range $result [expr [string first $errorKey $result]+ [string length $errorKey]] [string length $result]]
  set lineFeedPos [string first "\n" $errorCode ]
  if {$lineFeedPos == -1} {
    set lineFeedPos [string length $errorCode]
  }
  return [string range $errorCode 0 $lineFeedPos]
}

proc cmd_firmware_update {} {

  global iface_url

  set iface   ""
  set address ""

  set HmIPIdentifier "HmIP-RF"

  catch { import iface }
  catch { import address }

  set url $iface_url($iface)

  if {$iface != $HmIPIdentifier} {
    catch {xmlrpc $url updateFirmware [list string $address]} result
  } else {
    # HmIP device
    catch {xmlrpc $url installFirmware [list string $address]} result
  }

  puts "<script type=\"text/javascript\">if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogFirmwareUpdateCheckSuccess\"));</script>"
  
  if { $result == 1 } then {
    puts "<script type=\"text/javascript\">"
      puts "ShowInfoMsg(translateKey(\"dialogFirmwareUpdateSuccess\"));"
      puts "if (InfoMsg) InfoMsg.OnOK = function () {InfoMsg.remove(); location.reload(); }"
    puts "</script>"
  } else {
    # The errorCode is the error as an integer as returned from the xmlrpc call 'updateFirmware' and can be -1, -2 and so on
    set errorCode [getFwUpdateError "faultCode=" $result]
    set userHint ""
    if {$errorCode == -1 || $errorCode == -10} {
      set userHint "fwUpdatePressConfigKey"
    }
    # The errorString is the error in plain text as returned from the xmlrpc call 'updateFirmware'
    set errorString [getFwUpdateError "faultString=" $result]
    puts "<script type=\"text/javascript\">ShowErrorMsg(\"$errorString\" + \"<br/><br/>\" + translateKey(\"dialogFirmwareUpdateFailed\") +\"<br/><br/>\"+ translateKey(\"$userHint\"));</script>"
  }
}

proc set_internalKeys {status address iface pnr} {
  
  # status must be 0 or 1 
  # 0 = internal keys not visible
  # 1 = internal keys visible
  
  global iface_url 
  set url $iface_url($iface)
  set master_addr [string toupper [string range $address 0 [expr [string first ":" $address] -1] ]] 
  
  set internal_keys_visible "{INTERNAL_KEYS_VISIBLE {bool $status}}"
  puts "[xmlrpc $url putParamset [list string $master_addr] [list string MASTER] [list struct $internal_keys_visible]]"
    
  set ui_hint "{UI_HINT {string $pnr}}"
  puts "[xmlrpc $url putParamset [list string $address] [list string $address] [list struct $ui_hint]]"
}

proc cmd_set_profile {} {

  global iface_url sender_address USERPROFILESPATH env  

  set iface   ""
  set address ""
  set peer    ""
  set ps_type ""
  set paramid ""
  set pnr     ""
  set HmIPIdentifier "HmIP-RF"

  catch { import iface }
  catch { import address }
  catch { import peer }
  catch { import ps_type }
  catch { import paramid }
  catch { import pnr }
  catch { import new_profilepath } ;# handelt es sich um die neue Profilstruktur?

  # wenn interne Gerätetaste?
  if {! [catch {import internalKey}] } then {
    ## set_internalKeys 1 $address $iface $pnr
    ## after 1500
  }
  
  if { $paramid != "" && [file exists easymodes/$paramid.tcl] } then {
    
    catch {source easymodes/$new_profilepath.tcl}
    
    # Kanal aus der Senderadresse entfernen, aus EDD0001234:1 wird EDD0001234
    set sender_ad [lindex [split $peer ":"] 0]
    set USERPROFILEFILE $USERPROFILESPATH/$new_profilepath-$sender_ad.tcl

    catch {source $USERPROFILEFILE}
  }

  set ret [base_put_profile $iface $address $pnr $peer $ps_type 0]
    
  puts "<script type=\"text/javascript\">"

  if {$ret == -1 && $iface != $HmIPIdentifier} then {
    
    #Kein ConfigPending anzeigen nach dem Laufbalken (sinnlos, weil keine Übertragung erfolgte):
    puts "ProgressBar.OnFinish = function () \{ return; \}"
    
    #puts "if (ProgressBar) ProgressBar.IncCounter(\"Fehler beim Speichern des Profils $address mit $peer.\");"
    puts "if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogSetProfileErrorProgressBarA\") + \"$address\" + translateKey(\"dialogSetProfileErrorProgressBarB\") + \"$peer.\");"
    #puts "ShowErrorMsg(\"[cgi_quote_html "Das Profil konnte nicht gespeichert werden."]\");"
    puts "ShowErrorMsg(translateKey(\"dialogSetProfileMsgError\"));"

  } else {
    #puts "if (ProgressBar) ProgressBar.IncCounter(\"Profil gespeichert von $address mit $peer.\");"
    puts "if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogSetProfileSuccessProgressBarA\")+ \" $address \" +translateKey(\"dialogSetProfileSuccessProgressBarB\") + \" $peer.\");"
  }
  puts "</script>"

  # wenn interne Gerätetaste?
  if {! [catch {import internalKey}] } then {
    #after 1500
    ## set_internalKeys 0 $address $iface $pnr
    ## after 3000
  }
}

proc cmd_set_team {} {
  
  global iface_url
  
  catch {import iface}
  catch {import address}
  catch {import TEAM}
  
  set url $iface_url($iface)  
  
  if {$TEAM == "_RESET_"} then {set TEAM ""}
  
  puts "<script type=\"text/javascript\">"
  
  xmlrpc $url setTeam [list string $address] [list string $TEAM]
  
  puts "if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogSetTeamSuccessProgressBar\"));"
  
  puts "</script>"
}


proc cmd_determineParameter {} {
  
  #cgi_debug -on 

  global iface_url

  set iface    ""
  set address  ""
  set ps_id    ""
  set param_id ""

  catch { import iface }
  catch { import address }
  catch { import ps_id }
  catch { import param_id }
  catch { import html_inputelem_id }

  puts "<script type=\"text/javascript\">"
  if { [catch { xmlrpc $iface_url($iface) determineParameter [list string $address] [list string $ps_id] [list string $param_id] }] } then {
    #puts "if (ProgressBar) ProgressBar.IncCounter(\"Parameter konnte nicht bestimmt werden!\");"
    puts "if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogDetermineParameterProgressBarError\"));"
    #puts "ShowErrorMsg(\"Der Parameter konnte nicht bestimmt werden.\");"
    puts "ShowErrorMsg(translateKey(\"dialogDetermineParameterMsgError\"));"
  } else {
    #puts "if (ProgressBar) ProgressBar.IncCounter(\"Parameter wurde bestimmt!\");"
    puts "if (ProgressBar) ProgressBar.IncCounter(translateKey(\"dialogDetermineParameterProgressBarSuccess\"));"
    #puts "ShowInfoMsg(\"Der Parameter wurde erfolgreich bestimmt.\");"
    puts "ShowInfoMsg(translateKey(\"dialogDetermineParameterMsgSuccess\"));"

    #Neuen Wert auslesen-----
    set newval ""

    catch {
        array set ps [xmlrpc $iface_url($iface) getParamset [list string $address] [list string $ps_id]]
      set newval $ps($param_id)
    }

    if {$newval != ""} then {
      puts "SetInputValue('$html_inputelem_id', '$newval');"
      catch {puts "SetInputValue('$html_inputelem_id' + '_tmp', '$newval');"}

      #INTEGER- und FLOAT-Input-Elemente müssen mit onkeyup in das eigentliche Daten-Input-Element übertragen werden.
      catch {puts "document.getElementById('$html_inputelem_id').onkeyup;"}
      catch {puts "document.getElementById('$html_inputelem_id' + '_tmp' ).onkeyup;"}
    } else {
      #Wert konnte nicht bestimmt werden.
      puts "reloadPage();"
    }
  }
  puts "</script>"
}

proc cmd_SendInternalKeyPress {} {
  global iface_url
  catch {import iface}
  catch {import sender}
  catch {import receiver}
  catch {import longKeyPress}

  set simLongKeyPress "false"

  catch {
    if {[info exists longKeyPress] == 1} {
      if {$longKeyPress == 1} {
        set simLongKeyPress "true"
      }
    }
  }
    
  if {[catch {xmlrpc $iface_url($iface) activateLinkParamset [list string $receiver] [list string $sender] [list bool $simLongKeyPress]}]} then {
    set error "<div class=\"CLASS20700\">\${dialogSimulateKeyPressError}</div>"
    puts "<script type=\"text/javascript\">MessageBox.show('\${dialogHint}','$error' ,'', 400, 80);</script>"
  } else {
    set success "<div class=\"CLASS20700\">\${dialogSimulateKeyPressSuccess}</div>"
    puts "<script type=\"text/javascript\">MessageBox.show('\${dialogHint}','$success' ,'', 420, 40);</script>"
  }
}

proc cmd_unknowncmd {cmd} {
  #puts "<script type=\"text/javascript\">alert('Fehler. Unbekannter Befehl: $cmd');</script>"
  puts "<script type=\"text/javascript\">alert(translateKey('errorMessageUnknownCommand') +' $cmd');</script>"
}

cgi_eval {

  cgi_input
  catch { import cmd }

  if {[session_requestisvalid 0] > 0} then {

    html {
      head {
        put_meta_nocache
        puts "<title>response of request with command: $cmd</title>"
      }
      body {
        puts "<script src=\"/config/js/ic_common.js\" type=\"text/javascript\"></script>"
          cmd_$cmd
      }
    }
  }
}
