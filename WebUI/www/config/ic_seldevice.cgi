#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) once.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) cgi.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) session.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/ic_common.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) common.tcl]
loadOnce tclrpc.so

#Datenbank der Gerätebeschreibungen fürs WebUI
sourceOnce [file join $env(DOCUMENT_ROOT) config/devdescr/DEVDB.tcl]

#ISE-Daten
array set ise_CHANNELNAMES ""
ise_getChannelNames ise_CHANNELNAMES

array set ise_FUNCTIONS ""
ise_getChannelFunctions ise_FUNCTIONS

array set ise_ROOMS ""
ise_getChannelRooms ise_ROOMS

#=====

proc put_page {} {

  global iface_url HTMLTITLE sidname sid
  global step dev_descr_sender dev_descr_receiver iface sender_address receiver_address name description group_name group_description sender_group

#cgi_debug -on

  puts "<div id=\"ic_selchannel\">"
      
    puts "<div id=\"id_body\">"
      
      puts "<div id=\"id_subOffsetDivPopup\" class=\"subOffsetDivPopup CLASS21900\" >"
      
      puts "<div id=\"body_wrapper\">"

      if {$step > 1} then {
        put_PreviousStep
      }

      set realchannels    0
      set virtualchannels 0
        
      if {$step < 3} then {
        # wegen dem IE muss das Style overflow:visible eingestellt sein
        puts "<div id=\"ChnTblContentDiv\" class=\"CLASS21908\" style=\"overflow:visible\" >"
        puts "<table border=\"1\" id=\"ChnListTbl\" class=\"ChnListTbl\" width=\"100%\" cellspacing=\"0\">"
        put_colgroup
        put_tableheader

        put_tablebody realchannels virtualchannels
        puts "</table>"
        puts "</div>"

        put_js_SizeTable
        #put_js_sortby 0
        
        #if {$realchannels == 0 && $virtualchannels > 0} then {
        # Funktioniert an dieser Stelle noch nicht, da der Button noch gar nicht vorhanden ist.
        #  put_js_ShowVirtualChannels
        #}
      }
      
      #body_wrapper
      puts "</div>"

       puts "<div id=\"global_values\" style=\"display: none; visibility: hidden;\">"
      puts "<form action=\"#\">"
      puts "<input id=\"global_sid\" type=\"hidden\" name=\"$sidname\"          value=\"$sid\"/>"
      puts "<input id=\"global_iface\" type=\"hidden\" name=\"iface\"             value=\"$iface\"/>"
      puts "<input id=\"global_sender_address\" type=\"hidden\" name=\"sender_address\"    value=\"$sender_address\"/>"
      puts "<input id=\"global_sender_group\" type=\"hidden\" name=\"sender_group\"    value=\"$sender_group\"/>"
      puts "<input id=\"global_receiver_address\" type=\"hidden\" name=\"receiver_address\"  value=\"$receiver_address\"/>"
      puts "<input id=\"global_realchannels\"    type=\"hidden\" name=\"realchannels\"          value=\"$realchannels\"/>"
      puts "<input id=\"global_virtualchannels\" type=\"hidden\" name=\"virtualchannels\"          value=\"$virtualchannels\"/>"
      puts "</form>"
      puts "</div>"

      #subOffsetDivPopup
      puts "</div>"

      puts "<script type=\"text/javascript\">"
      #puts "  setPath(\"<span onclick='WebUI.enter(LinksAndProgramsPage);'>Programme &amp; Verkn&uuml;pfungen</span> &gt; <span onclick='WebUI.enter(LinkListPage);'>Direkte Verkn&uuml;pfungen</span> &gt; Neue Verkn&uuml;pfung anlegen - Schritt $step/3\");"
      #puts "  setPath(\"<span onclick='WebUI.enter(LinksAndProgramsPage);'>\"+translateKey('menuProgramsLinksPage')+\"</span> &gt; <span onclick='WebUI.enter(LinkListPage);'>\"+translateKey('submenuDirectLinks')+\"</span> &gt; \"+translateKey('lblPathCreateNewLink')+\" - \"+translateKey('lblPathStepX')+\" $step/3\");"
      puts "  setPath(\"<span onclick='WebUI.enter(SystemConfigPage);'>\"+translateKey('menuSettingsPage')+\" &gt; \" +translateKey('submenuDeviceInbox')+\"</span> &gt; <span onclick='WebUI.enter(NewDeviceListPage);'>\"+translateKey('replaceDevicePathAction')+\"</span>\");"

      puts "  var s = \"\";"
      puts "  s += \"<table cellspacing='8'>\";"
      puts "  s += \"<tr>\";"
      if {$step < 3} then {
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.enter(NewDeviceListPage);'>\${btnCancel}</div></td>\";"
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton CLASS21901' onclick='ResetFilterAndTable();'>\${footerBtnResetFilter}</div></td>\";"

        if {$virtualchannels > 0} then {
          puts "  s += \"<td align='center' valign='middle'><div class='FooterButton CLASS21909' onclick='ToggleVirtualKeys();' id='ToggleVirtualKeys'>\${footerBtnVirtualChannelsShow}</div></td>\";"
        }
      } else {
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.enter(NewDeviceListPage);'>\${btnCancel}</div></td>\";"
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton CLASS21901' onclick='CollectData_AddLink(1);'>\${footerBtnCreateEdit}</div></td>\";"
        puts "  s += \"<td align='center' valign='middle'><div class='FooterButton' onclick='CollectData_AddLink(0);'>\${footerBtnCreate}</div></td>\";"
      }
      puts "  s += \"</tr>\";"
      puts "  s += \"</table>\";"
      puts "  setFooter(s);"
      
      # Tabelle sortieren
      if {$step < 3} then  {
        puts "  SORTED_COL = -1;"
        puts "  Sort('ChnListTbl', 0);"
      }
      puts "</script>"
      
    #id_body
    puts "</div>"
      
  #ic_selchannel
  puts "</div>"
}

proc put_colgroup {} {
  puts "<colgroup>"
#Name
  puts "  <col width=\"39%\" />"
#Typenbezeichnung
  puts "  <col width=\"10%\" />"
#Bild
  puts "  <col width=\"4%\" />"
#Bezeichnung
  puts "  <col width=\"30%\" />"
#Seriennummer
  puts "  <col width=\"10%\" />"



#Kategorie
  #puts "  <col width=\"5%\" />"
#Übertragungsmodus
  #puts "  <col width=\"5%\" />"
#Gewerk
  #puts "  <col width=\"10%\" />"
#Raum
  #puts "  <col width=\"10%\" />"
#Aktion
  puts "  <col width=\"7%\" />"

  puts "</colgroup>"
}

proc put_NaviButtons {} {

  global step

#cgi_debug -on

  puts "<div class=\"popupControls\">"
  puts "<table class=\"CLASS21902\">"
  puts "<tbody>"
  
  puts "<TR>"

  if {$step < 3} then {
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"CloseSelChannel();\" ><div>\${btnCancel}</div></td>"
    puts "<TD class=\"ActiveButton CLASS21903\" onclick=\"ResetFilterAndTable();\"><div>\${footerBtnResetFilter}</div></TD>"
    puts "<TD class=\"ActiveButton CLASS21903\" onclick=\"ToggleVirtualKeys();\"><div id=\"ToggleVirtualKeys\">\${footerBtnVirtualChannelsShow}</div></TD>"
    puts "<td class=\"CLASS21911\">&nbsp;</td>"
  } else {
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"CloseSelChannel();\"><div>\${btnCancel}</div></td>"
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"AddLink(\$F('global_iface'), \$F('global_sender_address'), \$F('global_sender_group'), \$F('global_receiver_address'), \$F('input_name'), \$F('input_description'), \$F('input_group_name'), \$F('input_group_description'), 'IC_SETPROFILES'    );\"><div>\${footerBtnCreateEdit}</div></td>"
    puts "<td class=\"ActiveButton CLASS21903\" onclick=\"AddLink(\$F('global_iface'), \$F('global_sender_address'), \$F('global_sender_group'), \$F('global_receiver_address'), \$F('input_name'), \$F('input_description'), \$F('input_group_name'), \$F('input_group_description'), 'IC_LINKPEERLIST');\"><div>\${footerBtnCreate}</div></td>"
    puts "<td class=\"CLASS21911\">&nbsp;</td>"
  }

  puts "</TR>"
  puts "</tbody>"

  puts "</table>"
  puts "</div>"
}

# AG test_space

proc test_space {pruefling} {
  
# wenn &nbsp; vorhanden, dann 1, sonst 0

  if {$pruefling == "&nbsp;"} {
    return 1
    } else {
    return 0
    }
}

proc put_PreviousStep {} {

#cgi_debug -on
  global ise_CHANNELNAMES step receiver_links
  global dev_descr_sender dev_descr_receiver iface sender_address receiver_address name description group_name group_description sender_group dev_descr_sender_group

#cgi_debug -on
  
  array set SENTRY ""
  set SENTRY(RECEIVERADDR) "&nbsp;"
  set SENTRY(RECEIVERNAME) "&nbsp;"
  set SENTRY(RECEIVERNAME_DISPLAY) "&nbsp;"
  set SENTRY(SENDERADDR)   "&nbsp;"
  set SENTRY(SENDERNAME)   "&nbsp;"
  set SENTRY(SENDERNAME_DISPLAY) "&nbsp;"
  set SENTRY(SENDERGROUPADDR)   "&nbsp;"
  set SENTRY(SENDERGROUPNAME)   "&nbsp;"
  set SENTRY(SENDERGROUPNAME_DISPLAY) "&nbsp;"
  set SENTRY(LINKNAME)     "&nbsp;"
  set SENTRY(LINKDESC)     "&nbsp;"
  set SENTRY(WARNINGS)     ""


  if {$receiver_address != ""} then {
    set SENTRY(RECEIVERADDR) $receiver_address
    if { [catch { set SENTRY(RECEIVERNAME) $ise_CHANNELNAMES($iface;$receiver_address)} ] } then {
         set SENTRY(RECEIVERNAME) "$iface"
         append SENTRY(RECEIVERNAME) ".$receiver_address"
    }

    if {[test_space $SENTRY(RECEIVERNAME)] == 1} {
    set SENTRY(RECEIVERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_receiver(PARENT_TYPE)', 250, $dev_descr_receiver(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">$SENTRY(RECEIVERNAME)</div>"
    } else {
    set SENTRY(RECEIVERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_receiver(PARENT_TYPE)', 250, $dev_descr_receiver(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">[cgi_quote_html $SENTRY(RECEIVERNAME)]</div>"
  }
    
  }

    
  if {$sender_address != ""} then {
    set SENTRY(SENDERADDR) $sender_address
    if { [catch { set SENTRY(SENDERNAME) $ise_CHANNELNAMES($iface;$sender_address)} ] } then {
         set SENTRY(SENDERNAME) "$iface"
         append SENTRY(SENDERNAME) ".$sender_address"
    }
    
    if {[test_space $SENTRY(SENDERNAME)] == 1 } {
    set SENTRY(SENDERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender(PARENT_TYPE)', 250, $dev_descr_sender(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">$SENTRY(SENDERNAME)</div>"
    } else {
    set SENTRY(SENDERNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender(PARENT_TYPE)', 250, $dev_descr_sender(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">[cgi_quote_html $SENTRY(SENDERNAME)]</div>"
  }
  }

  if {$sender_group != ""} then {
    set SENTRY(SENDERGROUPADDR) $sender_group
    if { [catch { set SENTRY(SENDERGROUPNAME) $ise_CHANNELNAMES($iface;$sender_group)} ] } then {
         set SENTRY(SENDERGROUPNAME) "$iface"
         append SENTRY(SENDERGROUPNAME) ".$sender_group"
    }
    
    if {[test_space $SENTRY(SENDERGROUPNAME)] == 1} {
    set SENTRY(SENDERGROUPNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender_group(PARENT_TYPE)', 250, $dev_descr_sender_group(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">$SENTRY(SENDERGROUPNAME)</div>"
    } else {
    set SENTRY(SENDERGROUPNAME_DISPLAY) "<div class=\"CLASS21912\" onmouseover=\"picDivShow(jg_250, '$dev_descr_sender_group(PARENT_TYPE)', 250, $dev_descr_sender_group(INDEX), this);\" onmouseout=\"picDivHide(jg_250);\">[cgi_quote_html $SENTRY(SENDERGROUPNAME)]</div>"
  }

    }

  if {$step < 3} then {
    set SENTRY(LINKNAME)      "<input id=\"input_name\"              name=\"name\"              type=\"hidden\" value=\"\"/>&nbsp;"
    set SENTRY(LINKDESC)      "<input id=\"input_description\"       name=\"description\"       type=\"hidden\" value=\"\"/>&nbsp;"
    set SENTRY(LINKGROUPNAME) "<input id=\"input_group_name\"        name=\"group_name\"        type=\"hidden\" value=\"\"/>&nbsp;"
    set SENTRY(LINKGROUPDESC) "<input id=\"input_group_description\" name=\"group_description\" type=\"hidden\" value=\"\"/>&nbsp;"
  } else {
    if {$name       == ""                       } then {set name       "[cgi_quote_html $SENTRY(SENDERNAME)] \${lblLinkNameWith} [cgi_quote_html $SENTRY(RECEIVERNAME)]"}
    if {$group_name == "" && $sender_group != ""} then {set group_name "[cgi_quote_html $SENTRY(SENDERGROUPNAME)] \${lblLinkNameWith} [cgi_quote_html $SENTRY(RECEIVERNAME)]"}

    set description1 ""
    set description2 ""
    
    catch {set description1 "\${lblStandardLink} $dev_descr_sender(TYPE) - $dev_descr_receiver(TYPE)"}
    catch {set description2 "Standardverknüpfung $dev_descr_sender(TYPE) - $dev_descr_receiver(TYPE)"}
    #catch {set description2 "\${lblStandardLink} $dev_descr_sender(TYPE) - $dev_descr_receiver(TYPE)"}

    set SENTRY(LINKNAME)      "<input id=\"input_name\"              name=\"name\"              type=\"text\" value=\"$name\"/>"
    set SENTRY(LINKDESC)      "<input id=\"input_description\"       name=\"description\"  class=\"stringtable_input\"     type=\"text\" value=\"$description1\"/>"
    puts "<script type=\"text/javascript\">st_setStringTableValues();</script>"
    set SENTRY(LINKGROUPNAME) "<input id=\"input_group_name\"        name=\"group_name\"        type=\"text\" value=\"$group_name\"/>"
    set SENTRY(LINKGROUPDESC) "<input id=\"input_group_description\" name=\"group_description\" class=\"stringtable_input\"  type=\"text\" value=\"$description2\"/>"
    puts "<script type=\"text/javascript\">st_setStringTableValues();</script>"
    puts "<script type=\"text/javascript\">"
      puts "jQuery(\"#input_name\").attr(\"value\",translateString(\"$name\"));"
      puts "jQuery(\"#input_group_name\").attr(\"value\",translateString(\"$group_name\"));"
      puts "jQuery(\"#input_description\").attr(\"value\",translateString(\"$description1\"));"
      puts "jQuery(\"#input_group_description\").attr(\"value\",translateString(\"$description2\"));"
    puts "</script>"

    #Warnung vor dem Überschreiben von Verknüpfungen----------------------------------
    set i 0
    
    if { [LinkExists receiver_links $sender_address $receiver_address ] == 1 } then {
      append SENTRY(LINKNAME) "<img src=\"/ise/img/dialog-warning.png\" alt=\"Warnung\" title=\"Verkn&uuml;pfung gibt es schon\"/>"
      #append SENTRY(LINKNAME) "Achtung, die Verkn&uuml;pfung existiert bereits und wird &uuml;berschrieben."
      append SENTRY(LINKNAME) "\${dialogCreateLinkHintLinkExists}"
      incr i
    }

    if { [LinkExists receiver_links $sender_group $receiver_address ] == 1 } then {
      append SENTRY(LINKGROUPNAME) "<img src=\"/ise/img/dialog-warning.png\" alt=\"Warnung\" title=\"Verkn&uuml;pfung gibt es schon\"/>"
      #append SENTRY(LINKGROUPNAME) "Achtung, die Verkn&uuml;pfung existiert bereits und wird &uuml;berschrieben."
      append SENTRY(LINKNAME) "\${dialogCreateLinkHintLinkExists}"
      incr i
    }

    if {$i > 0} then {
      #append SENTRY(WARNINGS) "<script type=\"text/javascript\">ShowWarningMsg(\"Sie sind dabei $i bestehende Verknüpfungen zu überschreiben.\");</script>"
      append SENTRY(WARNINGS) "<script type=\"text/javascript\">ShowWarningMsg(translateKey(\"dialogCreateLinkMsgLinkExistsA\") +\"$i\"+ translateKey(\"dialogCreateLinkMsgLinkExistsB\"));</script>"
    }
    #---------------------------------------------------------------------------------
  }

  puts "<div id=\"previous_step_wrapper\" >"
  
  puts "<table border=\"1\" id=\"createLinkStep1\" cellspacing=\"0\" class=\"j_translate\" >"

  puts "<colgroup>"
  puts "  <col width=\"10%\" />"
  puts "  <col width=\"10%\" />"
  puts "  <col width=\"25%\" />"
  puts "  <col width=\"25%\" />"
  puts "  <col width=\"10%\" />"
  puts "  <col width=\"10%\" />"
  puts "</colgroup>"
  
  puts "<THEAD>"

  puts "<TR>"
  puts "<TD COLSPAN=\"2\" align=\"center\">\${thSender}</TD>"
  puts "<TD COLSPAN=\"2\" align=\"center\" class=\"BlueHeader\">\${thLink}</TD>"
  puts "<TD COLSPAN=\"2\" align=\"center\">\${thReceiver}</TD>"
  puts "</TR>"
  puts "<TR class=\"CLASS21913\">"
  puts "<TD align=\"center\">\${thName}</TD>"
  puts "<TD align=\"center\">\${thSerialNumber}</TD>"
  puts "<TD align=\"center\" class=\"BlueHeader\">\${thName}</TD>"
  puts "<TD align=\"center\">\${thDescription}</TD>"
  puts "<TD align=\"center\">\${thName}</TD>"
  puts "<TD align=\"center\">\${thSerialNumber}</TD>"
  puts "</TR>"
  
  puts "</THEAD>"

  puts "<TBODY>"
      
  puts "<tr>"
  puts "<td align=\"center\">$SENTRY(SENDERNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(SENDERADDR)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKNAME)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKDESC)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERADDR)</td>"
  puts "</tr>"

  puts "<tr [expr {$sender_group != ""?"":"style=\"display:none;\""}]>"
  puts "<td align=\"center\">$SENTRY(SENDERGROUPNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(SENDERGROUPADDR)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKGROUPNAME)</td>"
  puts "<td style=\"vertical-align: top;\" align=\"center\" [expr {$step==3?"class=\"WhiteHeader\"":""}]>$SENTRY(LINKGROUPDESC)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERNAME_DISPLAY)</td>"
  puts "<td align=\"center\">$SENTRY(RECEIVERADDR)</td>"
  puts "</tr>"

  puts "</TBODY>"

  puts "</table>"

  puts "<script type=\"\">translatePage(\"#createLinkStep1\")</script>"

  puts $SENTRY(WARNINGS)
  
  puts "</div>"
}

proc put_js_ShowVirtualChannels {} {
  set msg [cgi_quote_html "Es stehen nur virtuelle Kanäle zur Verfügung."]
  puts "<script type=\"text/javascript\">alert('$msg'.unescapeHTML()); ToggleVirtualKeys();</script>"
}

proc put_js_sortby {colNr} {
  puts "<script type=\"text/javascript\">Sort('ChnListTbl', $colNr);</script>"
}

proc put_js_SizeTable {} {
  puts "<script type=\"text/javascript\">SizeTable();</script>"
}

proc put_tableheader {} {

  global step

  puts "<THEAD id=\"chnListHead\" class=\"j_translate\" >"
  
  puts "<TR>"
  puts "<TD class=\"chnListTbl_Caption\" align=\"left\" colspan=\"10\">\${replaceDeviceTblHeader}</TD>"
  puts "</TR>"
  
  puts "<TR id=\"tr_caption_colnames\" align=\"center\">"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 0);\">\${thName}<img src=\"/ise/img/arrow_up.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 1);\">\${thTypeDescriptor}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"nosort\">\${thPicture}</TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 3);\">\${thDescriptor}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 4);\">\${thSerialNumber}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  #puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 5);\">\${thCategorie}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  #puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 6);\">\${thTransmitMode}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  #puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 7);\">\${thFunc}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  #puts "<TD class=\"unsorted\" onclick=\"Sort('ChnListTbl', 8);\">\${thRoom}<img src=\"/ise/img/arrow_down.gif\" alt=\"sorting\"/></TD>"
  puts "<TD class=\"nosort\">\${thAction}</TD>"
  puts "</TR>"

  puts "<script type=\"text/javascript\">translatePage(\"#chnListHead\")</script>"

  puts "<TR align=\"center\" class='height20px'>"

  #Name
  put_FilterControl TEXTINPUT  0

  #Typenbezeichnung
  put_FilterControl TEXTINPUT  1 

  #Bild
  put_FilterControl NONE       2
  #puts "<td class=\"unfiltered CLASS21914\" >&nbsp;</td>"

  #Bezeichnung
  put_FilterControl TEXTINPUT  3

  #Seriennummer / Adresse
  put_FilterControl TEXTINPUT  4
  
  #Kategorie
  #put_FilterControl CHECKBOXES 5 [list "\${lblReceiver}" "\${lblSender}"]

  #Übertragungsmodus
  #put_FilterControl CHECKBOXES 6 [list "\${lblStandard}" "\${lblSecured}"]

  #Gewerk
  #set ise_FUNCTIONS ""
  #ise_getFunctions ise_FUNCTIONS
  #put_FilterControl CHECKBOXES 7 $ise_FUNCTIONS
  
  #Raum
  #set ise_ROOMS ""
  #ise_getRooms ise_ROOMS
  #put_FilterControl CHECKBOXES 8 $ise_ROOMS
  
  #Aktion
  put_FilterControl NONE       9
  puts "<td class=\"chkCell CLASS21914 nofilter\" >&nbsp;</td>"

  puts "</TR>"

  puts "</THEAD>"
}

#control: NONE|TEXTINPUT|CHECKBOXES|RADIOBOXES
proc put_FilterControl {control colNr {entrylist ""} } {

  #cgi_debug -on

  if {$control == "NONE"} then {
    puts "<td id=\"id_filtertd_$colNr\" class=\"nofilter\">"
    puts "<div class=\"spacer\">&nbsp;</div>"
    puts "<div class=\"CLASS21915\">&nbsp;"
  } else {
    puts "<td id=\"id_filtertd_$colNr\" class=\"unfiltered\">"
    puts "<div class='FilterBtn' onclick=\"ShowFilterControl($colNr);\">Filter</div>"
    puts "<div class=\"CLASS21915\">"
  }
  
  puts "<div class=\"filterBox\" id=\"id_filtercontrol_$colNr\" style=\"display: none; visibility: hidden;\">"

  if {$control == "TEXTINPUT"} then {
    
    puts "<input type=\"text\" name=\"input_filtercontrol_$colNr\" /><br/>"
    
  } elseif {$control == "CHECKBOXES"} then {
    
    if {[llength $entrylist] > 0} then {
      
      puts "<table>"
      foreach entry $entrylist {
        puts "<tr>"
        puts "<td>[cgi_quote_html $entry]</td>"
        puts "<td><input type=\"checkbox\" name=\"input_filtercontrol_$colNr\" value=\"[cgi_quote_html $entry]\"></td>"
        puts "</tr>"
      }
      puts "</table>"
    } else {
      puts "Keine Eintr&auml;ge vorhanden."
    }

  } elseif {$control == "RADIOBOXES"} then {
    
    foreach entry $entrylist {
      puts "[cgi_quote_html $entry] <input type=\"radio\" name=\"input_filtercontrol_$colNr\" value=\"[cgi_quote_html $entry]\"><br/>"
    }

    # TODO Übersetzung
    puts "Keine Auswahl<input type=\"radio\" name=\"input_filtercontrol_$colNr\" value=\"\"><br/>"
  }
  
  puts "<div class=\"CLASS21916\">"
  puts "  <span onclick=\"filterTable();\" class=\"CLASS21917\">\${btnOk}</span>"
  puts "</div>"
  
  puts "</div>"
  
  puts "</div>"
  puts "</td>"
}

proc put_tablefooter {} {

  #cgi_debug -on

  puts "<TFOOT id=\"chnListFoot\">"
  
  puts "<TR>"
  puts "<td colspan=\"10\">"
  puts "<table id=\"chnListFoot_NaviTbl\">"
  puts "<tr>"
  puts "<TD class=\"CLASS21903\"><div class=\"CLASS21904\" onclick=\"ResetFilterAndTable();\">\${footerBtnResetFilter}</div></TD>"
  puts "<TD class=\"CLASS21903\"><div class=\"CLASS21904\" id=\"ToggleVirtualKeys\" onclick=\"ToggleVirtualKeys();\">\${footerBtnVirtualChannelsShow}</div></TD>"
  puts "<TD class=\"CLASS21905\">&nbsp;</TD>"
  puts "</tr>"
  puts "</table>"
  puts "</td>"
  puts "</TR>"

  puts "</TFOOT>"
}

#proc trim_dev_descr {p_dev_descr} {
#
  #upvar $p_dev_descr dev_descr
  #foreach d [array names dev_descr] {
    #trimright dev_descr($d)
  #}
#}
#
#proc trimright {p_var} {
  #upvar $p_var var
  #set var [string trimright $var " "]
#}

proc LinkExists {p_LINKLIST sender_address receiver_address} {

  upvar $p_LINKLIST linklist
  set match 0
  
  foreach _link $linklist {

    array set link $_link

    if {$link(SENDER) == $sender_address && $link(RECEIVER) == $receiver_address} then {
      set match 1
      break
    }
  }

  return $match
}

proc put_tablebody {p_realchannels p_virtualchannels} {

  global DEV_DESCRIPTION
  global iface_url ise_CHANNELNAMES ise_FUNCTIONS ise_ROOMS
  global step dev_descr_sender dev_descr_receiver iface sender_address receiver_address sender_group
  global SNNewDev TypeNewDev IDNewDev

#cgi_debug -on

  upvar $p_realchannels    realchannels
  upvar $p_virtualchannels virtualchannels

  set HmIPIdentifier "HmIP-RF"

  #Step 2=====
   set ROLENAME2CHECK ""
  set dev_roles ""
  
  if {$step == 2} then {
    if {$receiver_address != ""} then {
      set ROLENAME2CHECK LINK_SOURCE_ROLES
      set dev_roles $dev_descr_receiver(LINK_TARGET_ROLES)
    } else {
      set ROLENAME2CHECK LINK_TARGET_ROLES
      set dev_roles $dev_descr_sender(LINK_SOURCE_ROLES)
    }
  }
  #==========

  set rowcount 0
  set virtualcount 0

  puts "<TBODY id=\"chnListBody\" class=\"j_translate\">"

  foreach iface_loop [array names iface_url] {

    #Liste nur Geräte desselben Interfaces auf (iface = in der URL übergebenes Interface, iface_loop = alle bekannten Interfaces)
    if {$iface != "" && $iface_loop != $iface} then { continue }

    # HmIP doesn't support device replacement
    if {$iface_loop != $HmIPIdentifier } {
      set error [catch { set devlist [xmlrpc $iface_url($iface_loop) listReplaceableDevices [list string $SNNewDev]] } ]
      if { $error } then {
        # Error code -2  happens when listReplaceableDevices tries to get a device with a serial number from another interface
        # E. g. SN ABC0123456 belongs to a device of the interface BidCos-Wired and listReplaceDevices checks this SN for the interface BidCos-RF
        if { ($error != -2) } {
          puts "<div class=\"CLASS21906\">Interface-Prozess '$iface_loop' communication error.</div>"
          continue
        } else {
          continue
        }
      }
    }

    set devcount [llength $devlist]
    for {set i 0} {$i < $devcount} {incr i} {


      array set dev_descr [lindex $devlist $i]

      #Nur Geräte, keine Kanäle
      if { $dev_descr(PARENT) != ""} then {
        array_clear dev_descr
        continue
      }

      #Nur Geräte anzeigen, die schon vom Posteingang in die Geräteliste übertragen wurden
      if { ![ metadata_getReadyConfig $iface_loop $dev_descr(ADDRESS) ] } then {
        continue
      }

      array set SENTRY ""
      
      if { [catch { set SENTRY(NAME) $ise_CHANNELNAMES($iface_loop;$dev_descr(ADDRESS))} ] } then {
        set SENTRY(NAME) "$iface_loop"
        append SENTRY(NAME) ".$dev_descr(ADDRESS)"
      }
      set SENTRY(TYPE)  "$dev_descr(TYPE)"

      #Image===
      set senderimgpath_50  [DEV_getImagePath $dev_descr(TYPE)  50]

      if {$senderimgpath_50 == ""} { set senderimgpath_50 "#" }
      set SENTRY(IMAGE) "<div id=\"picDiv_$rowcount\" class=\"CLASS21907\" onmouseover=\"picDivShow(jg_250, '$dev_descr(TYPE)', 250, '', this);\" onmouseout=\"picDivHide(jg_250);\"></div>"
      append SENTRY(IMAGE) "<script type=\"text/javascript\">"
      append SENTRY(IMAGE) "var jg_$rowcount = new jsGraphics(\"picDiv_$rowcount\");"
      append SENTRY(IMAGE) "InitGD(jg_$rowcount, 50);"
      append SENTRY(IMAGE) "Draw(jg_$rowcount, '$dev_descr(TYPE)', 50, '');"
      append SENTRY(IMAGE) "</script>"
      #===
      
      if { [catch {set SENTRY(DESCRIPTION) "$DEV_DESCRIPTION($dev_descr(TYPE))" } ] } then {
        set SENTRY(DESCRIPTION) "$dev_descr(TYPE)"
      }

      set SENTRY(ADDRESS)  $dev_descr(ADDRESS)

      cgi_debug -on

      set args "{"
      append args "'oldDevAddr': '$dev_descr(ADDRESS)',"
      append args "'newDevAddr': '$SNNewDev',"
      append args "'oldDevType': '$dev_descr(TYPE)',"
      append args "'newDevType': '$TypeNewDev',"
      append args "'newDevID': '$IDNewDev'"
      append args "}"

      set SENTRY(ACTION) "<div onclick=\"ReplaceDevice.perform('$iface_loop',$args);\" class=\"CLASS21904\">\${btnSelect}</div>"
      puts "<tr>"

      if { [test_space $SENTRY(NAME)] == 1 } then { puts "<td>$SENTRY(NAME)</td>" } else { puts "<td>[cgi_quote_html $SENTRY(NAME)]</td>" }
      
      puts "<td>$SENTRY(TYPE)</td>"

      puts "<td class=\"chnListTbl_dev_img\">$SENTRY(IMAGE)</td>"

      if { [test_space $SENTRY(DESCRIPTION)] == 1 } then { puts "<td>$SENTRY(DESCRIPTION)</td>" } else { puts "<td>[cgi_quote_html $SENTRY(DESCRIPTION)]</td>" }

      puts "<td>$SENTRY(ADDRESS)</td>"
      puts "<td align=\"center\">$SENTRY(ACTION)</td>"
      puts "</tr>"

      incr rowcount
      
      if {$dev_descr(TYPE) == "VIRTUAL_KEY"} then { incr virtualcount }
      
      array_clear SENTRY
      array_clear dev_descr
    }
  }

  if {$rowcount == 0} then {
    puts "<TR>"
    puts "<TD height=\"100\" align=\"center\" COLSPAN=\"10\">\${replaceDeviceNoDevAvailable}</TD>"
    puts "</TR>"
  }

  puts "</TBODY>"

  set realchannels    [expr $rowcount - $virtualcount]
  set virtualchannels $virtualcount
  puts "<script type=\"text/javascript\">translatePage(\"#chnListBody\")</script>"
}

# TODO Viel überflüssiger Ballast, der entfernt werden sollte.
cgi_eval {

#cgi_debug -on
  cgi_input

  if {[session_requestisvalid 0] > 0} then {

    #-----------------------------------------
    #allg. globale Parameter
    set step 1
    array set dev_descr_sender       ""
    array set dev_descr_receiver     ""
    array set dev_descr_sender_group ""
    set sender_group                 ""
     set receiver_links               ""
    
    #URL-Parameter
    set iface             ""
    set sender_address    ""
    set receiver_address  ""
    set name              ""
    set description       ""
    set group_name        ""
    set group_description ""
    set SNNewDev ""
    set TypeNewDev ""
    set IDNewDev ""

    catch {import iface}
    catch {import sender_address}
    catch {import receiver_address}
    catch {import name}
    catch {import description}
    catch {import group_name}
    catch {import group_description}
    catch {import SNNewDev}
    catch {import TypeNewDev}
    catch {import IDNewDev}
    #-----------------------------------------

    http_head
    
    if { $iface != "" && $sender_address != "" && $receiver_address != "" } then {
      
      set step 3
      set url $iface_url($iface)
        array set dev_descr_sender   [xmlrpc $url getDeviceDescription [list string $sender_address  ]]
        array set dev_descr_receiver [xmlrpc $url getDeviceDescription [list string $receiver_address]]
      
      catch { set sender_group $dev_descr_sender(GROUP) }
      if {$sender_group != ""} then {
          array set dev_descr_sender_group [xmlrpc $url getDeviceDescription [list string $sender_group]]
      }

      #Für die Prüfung, ob es die Verknüpfung schon gibt. Schutz vorm Überschreiben der Verknüpfung---
      set flags 0
         set receiver_links [xmlrpc $url getLinks [list string $receiver_address] [list int $flags] ]
      #-----------------------------------------------------------------------------------------------

    } elseif {$iface != "" && $sender_address != ""} then {
      
      set step 2
      set url $iface_url($iface)
        array set dev_descr_sender [xmlrpc $url getDeviceDescription [list string $sender_address]]

      catch { set sender_group $dev_descr_sender(GROUP) }
      if {$sender_group != ""} then {
          array set dev_descr_sender_group [xmlrpc $url getDeviceDescription [list string $sender_group]]
      }
      
    } elseif {$iface != "" && $receiver_address != ""} then {
      
      set step 2
      set url $iface_url($iface)
        array set dev_descr_receiver [xmlrpc $url getDeviceDescription [list string $receiver_address]]

    } else {
      #step 1 wird nun angezeigt. "set step 1" wurde schon gesetzt
    }
    put_page
  }
}
