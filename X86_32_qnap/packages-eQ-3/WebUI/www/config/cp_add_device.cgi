#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce session.tcl

load tclrega.so
load tclrpc.so

set RFD_URL "bin://127.0.0.1:2001"
set HS485D_URL "bin://127.0.0.1:2000"

proc _action_put_page {} {
    global env RFD_URL

    set serial ""
    catch { import serial }

    cgi_debug -on

    puts "<div style='background-color:white; border: 1px solid #000000; color:black; padding-left:10px; width:100%; padding-bottom:50px;'>"


      puts "<h1 style='font-size:25px !important;'>\${dialogNewDevicesTitle}</h1>"

      puts "<div id='time_bar' style='margin-bottom:10px;' >not active</div>"

      puts "<div style='margin-bottom:10px; font-size:18px !important;'>HomeMatic Geräte mit Funk<img src='/ise/img/help.png' alt='Question' style='width:50%; height:50%'></div>"
      puts "<div>"
        puts "<div style='float:left; background-color:#5D6373; width:150px; height:25px; padding:5px; text-align:center;'  onclick='rf_install_mode(true);'>Anlernmodus starten</div>"
        puts "<span style='margin-right:50px;'> ?</span>"
        puts "<span> Seriennummer eingeben</span>"
        puts "<span> ?</span>"
        puts "<input type=\"text\" name=\"serial\" value=\"\">"
      puts "</div>"

      puts "<div style='margin-top:30px'>"
        puts "<div style='background-color:#5D6373; width:150px; height:25px; padding:5px; text-align:center;' onclick='OnBack();'>\${footerBtnPageBack}</div>"
      puts "</div>"


    puts "</div>"

    puts ""
    cgi_javascript {
        puts "translatePage('#messagebox');"
        puts "var url = \"$env(SCRIPT_NAME)?sid=\" + SessionId;"
        puts {
            update_new_device_count = function() {
                var pb = "action=get_new_device_count";
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        var devcount=transport.responseText.replace(/[^0-9]/g, "");
                        for(var i=0;i<document.getElementById("cp_new_devices_button").childNodes.length;i++){
                            var oldval=document.getElementById("cp_new_devices_button").childNodes[i].nodeValue;
                            if(oldval)document.getElementById("cp_new_devices_button").childNodes[i].nodeValue=oldval.replace(/\d+/g, devcount);
                        }
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            install_time_remain=0;
            update_time_bar = function() {
                install_time_remain-=1;
                if((install_time_remain%5)==0){
                    var pb = "action=get_install_status";
                    var opts = {
                        postBody: pb,
                        sendXML: false,
                        onSuccess: function(transport) {
                            if (!transport.responseText.match(/^Success/g)){
                                cp_adddev_updater.stop();
                                return;
                            }
                            var result=transport.responseText.split(" ");
                            var serial="";
                            if(result.length >= 3)serial=result[2];
                            if(serial != ""){
                                cp_adddev_updater.stop();
                                dlgPopup.hide();
                                dlgPopup.setWidth(400);
                                dlgPopup.LoadFromFile(url, "action=put_key_dialog&serial="+serial);
                            }else{
                                install_time_remain=result[1];
                                if(install_time_remain<=0){
                                    if ($("time_bar")) { document.getElementById("time_bar").firstChild.nodeValue= translateKey("dialogNewDevicesBidCosRFFetchmodeNotActive"); } /*"Anlernmodus nicht aktiv"*/
                                    cp_adddev_updater.stop();
                                    update_new_device_count();
                                    install_time_remain=0;
                                }
                            }
                        }
                    };
                    new Ajax.Request(url, opts);
                }
		if(install_time_remain<=0){
                    if ($("time_bar")) { $("time_bar").firstChild.nodeValue= translateKey("dialogNewDevicesBidCosRFFetchmodeNotActive");} /*"Anlernmodus nicht aktiv"*/
                    cp_adddev_updater.stop();
                    update_new_device_count();
                    install_time_remain=0;
                }else{
                    //if ($("time_bar")) { $("time_bar").firstChild.nodeValue="Anlernmodus noch "+String(install_time_remain)+"s aktiv"; }
                    if ($("time_bar")) { $("time_bar").firstChild.nodeValue=translateKey("dialogNewDevicesBidCosRFFetchmodeActiveA")+String(install_time_remain)+translateKey("dialogNewDevicesBidCosRFFetchmodeActiveB"); }
                }
            }

            rf_install_mode = function(activate) {
                var pb = "action=rf_install_mode";
                pb += "&activate="+activate;
                if(!activate && cp_adddev_updater)cp_adddev_updater.stop();
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        if (!transport.responseText.match(/^Success/g)){
                            //alert("BidCoS-RF Anlernmodus konnte nicht aktiviert werden.");
                            alert(translateKey("dialogNewDevicesError4"));
                        }
                        result=transport.responseText.split(" ");
                        install_time_remain=result[1];
                        if(install_time_remain > 0){
                            install_time_remain++;
                            if(!cp_adddev_updater){
                                cp_adddev_updater=new PeriodicalExecuter(update_time_bar, 1);
                            }else if(!cp_adddev_updater.timer){
                                cp_adddev_updater.registerCallback();
                            }
                        }else{
                            install_time_remain=0;
                        }
                        update_time_bar();
                    },
                    onFailure: function(transport) {
                        //alert("BidCoS-RF Anlernmodus konnte nicht aktiviert werden.");
                        alert(translateKey("dialogNewDevicesError4"));
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            rf_serial = function() {
                var pb = "action=rf_serial&";
                pb += "serial="+document.getElementById("text_serial").value;
                Cursor.set(Cursor.WAIT);
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        Cursor.set(Cursor.NORMAL);
                        if (transport.responseText.match(/^Success/g)){
                            update_new_device_count();
                            document.getElementById("text_serial").value="";
                        } else if (transport.responseText.match(/^KeyMismatch/g)){
                            rf_install_mode(false);
                            if(cp_addev_updater)cp_adddev_updater.stop();
                            dlgPopup.hide();
                            dlgPopup.setWidth(400);
                            dlgPopup.LoadFromFile(url, "action=put_key_dialog&serial="+document.getElementById("text_serial").value+"&with_serial=1");
                        } else {
                            //alert("BidCoS-RF Anlernen mit Seriennummer "+document.getElementById("text_serial").value+ unescape(" fehlgeschlagen. Bitte %FCberpr%FCfen Sie die Seriennummer."));
                            alert(translateKey("dialogNewDevicesError1a")+document.getElementById("text_serial").value+ translateKey("dialogNewDevicesError1b"));
                        }
                    },
                    onFailure: function(transport) {
                        Cursor.set(Cursor.NORMAL);
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            wir_search = function() {
                var pb = "action=wir_search";
                CreateCPPopup2(url, "action=wait_page_wir_search");
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        Popup2Close();
                        if (transport.responseText.match(/^Success/g)){
                            update_new_device_count();
                        } else {
                            //alert(unescape("BidCoS-Wired Ger%E4te suchen fehlgeschlagen."));
                            alert(translateKey("dialogNewDevicesError2"));
                        }
                    },
                    onFailure: function(transport) {
                        Popup2Close();
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            OnInbox = function() {
                rf_install_mode(false);
                PopupClose();
                WebUI.enter(NewDeviceListPage);
            }
            OnBack = function() {
                rf_install_mode(false);
                PopupClose();
            }
        }
        catch {
            set install_time_remain [xmlrpc $RFD_URL getInstallMode]
            if { $install_time_remain } {
                puts "install_time_remain=$install_time_remain;"
                puts {
                    if(!cp_adddev_updater)cp_adddev_updater=new PeriodicalExecuter(update_time_bar, 1);
                    else if(!cp_adddev_updater.timer)cp_adddev_updater.registerCallback();
                    update_time_bar();
                }
            }
        }
        catch {
            import call_js
            puts "$call_js;"
        }

        puts "dlgPopup.readaptSize();"

    }

}

proc action_put_page {} {
    global env RFD_URL
  
    set serial ""
    catch { import serial }
    
    division {class="popupTitle j_translate"} {
        #puts "Ger&auml;te anlernen"
        puts "\${dialogNewDevicesTitle}"
    }
    division {class="CLASS21200 j_translate" } {
        table {class="popupTable"} {border="1"} {
            table_row {class="CLASS21202"} {
                table_data {class="CLASS21207"} {
                    #puts "BidCoS-RF (Funk)"
                    puts "\${dialogNewDevicesTDBidCosRF}"
                }
                table_data {width="50%"} {align="left"} {class="CLASS21208"} {
                    #puts "BidCoS-RF - Variante 1: Direktes Anlernen"
                    puts "\${dialogNewDevicesBidCosRFLbl1}"

                    division {class="popupControls CLASS21205"} {
                        table {
                            table_row {
                                table_data {class="CLASS21206"} {
                                    division {id="time_bar"} {class="CLASS21215"} {
                                        #puts "Anlernmodus nicht aktiv"
                                        puts "\${dialogNewDevicesBidCosRFFetchmodeNotActive}"
                                    }
                                }
                                table_data {class="CLASS21209"} {
                                    division {class="CLASS21210 colorGradient50px"} {onClick="rf_install_mode(true)"} {
                                        #puts "BidCoS-RF Anlernmodus"
                                        puts "\${dialogNewDevicesBidCosRFBtn1}"
                                    }
                                }
                            }
                        }
                    }
                    #puts "Falls Sie das anzulernende Ger&auml;t im direkten Zugriff haben, ist ein direktes Anlernen einfach m&ouml;glich:"
                    #puts "Bet&auml;tigen Sie den Button &quot;BidCoS-RF Anlernmodus&quot;. Dadurch wird die Zentrale f&uuml;r eine Minute"
                    #puts "in ihren Anlernmodus versetzt. Innerhalb dieser Zeit ist dann der Anlerntaster des anzulernenden Ger&auml;tes zu"
                    #puts "bet&auml;tigen. N&auml;here Einzelheiten dazu entnehmen Sie bitte der Bedienungs- bzw. Installationsanleitung"
                    #puts "des entsprechenden Ger&auml;tes."

                    puts "\${dialogNewDevicesBidCosRFLbl2a}"
                    puts "\${dialogNewDevicesBidCosRFLbl2b}"
                    puts "\${dialogNewDevicesBidCosRFLbl2c}"
                    puts "\${dialogNewDevicesBidCosRFLbl2d}"
                    puts "\${dialogNewDevicesBidCosRFLbl2e}"

                }
                table_data {width="50%"} {align="left"} {class="CLASS21208"} {
                    #puts "BidCoS-RF - Variante 2: Anlernen mit Seriennummer"
                    puts "\${dialogNewDevicesBidCosRFLbl3}"

                    table {class="CLASS21204"} {width="100%"} {
                        table_row {
                            td {width="20"} {}
                            #td "Seriennummer eingeben:"
                            td "\${dialogNewDevicesBidCosRFLbl4}"
                            table_data {
                                cgi_text serial=$serial {id="text_serial"}
                            }
                        }
                    }
                    division {class="popupControls CLASS21205"} {
                        table {
                            table_row {
                                table_data {class="CLASS21206"} {}
                                table_data {class="CLASS21209"} {
                                    division {class="CLASS21210a colorGradient50px"} {onClick="rf_serial()"} {
                                        #puts "Ger&auml;t anlernen"
                                        puts "\${dialogNewDevicesBidCosRFBtn2}"
                                    }
                                }
                            }
                        }
                    }
                    #puts "Falls Sie das anzulernende Ger&auml;t nicht im direkten Zugriff haben, geben Sie dazu dessen"
                    #puts "Seriennummer ein und bet&auml;tigen Sie den Button &quot;Ger&auml;t anlernen&quot;."
                    #puts "<p><span class='CLASS21211'>Achtung: </span>Nicht jedes BidCoS-RF-Ger&auml;t unterstützt das Anlernen per Seriennummer.</p>"

                    puts "\${dialogNewDevicesBidCosRFLbl5a}"
                    puts "\${dialogNewDevicesBidCosRFLbl5b}"
                    puts "\${dialogNewDevicesBidCosRFLbl5c}"
                }
            }
            table_row {class="CLASS21202"} {
                table_data {class="CLASS21212"} {
                    #puts "BidCoS-Wired"
                    puts "\${dialogNewDevicesTDBidCosWired}"
                }
                table_data {width="50%"} {align="left"} {class="CLASS21208"} {
                    #puts "BidCoS-Wired - Variante 1: Automatisches Anlernen"
                    puts "\${dialogNewDevicesBidCosWiredLbl1}"
                    br
                    br
                    br
                    #puts "Falls Sie das anzulernende Ger&auml;t im direkten Zugriff haben, ist ein direktes Anlernen einfach m&ouml;glich:"
                    #puts "Starten Sie den Anlernvorgang am anzulernenden Ger&auml;t. Die Anweisung zur Aktivierung des Anlernmodus am HomeMatic"
										#puts "Ger&auml;t entnehmen Sie bitte der Bedienungsanleitung zum Ger&auml;t."
										#puts "Die Zentrale wird das Ger&auml;t dann ohne weitere Bedienung anlernen."

										puts "\${dialogNewDevicesBidCosWiredLbl2a}"
										puts "\${dialogNewDevicesBidCosWiredLbl2b}"
										puts "\${dialogNewDevicesBidCosWiredLbl2c}"
										puts "\${dialogNewDevicesBidCosWiredLbl2d}"
                }
                table_data {width="50%"} {align="left"} {class="CLASS21208"} {
                    #puts "BidCoS-Wired - Variante 2: Ger&auml;te suchen"
                    puts "\${dialogNewDevicesBidCosWiredLbl3}"

                    division {class="popupControls CLASS21205"} {
                        table {
                            table_row {
                                table_data {class="CLASS21206"} {}
                                table_data {class="CLASS21209"} {
                                    division {class="CLASS21210a colorGradient50px"} {onClick="wir_search()"} {
                                        #puts "Ger&auml;te suchen"
                                        puts "\${dialogNewDevicesBidCosWiredBtn1}"
                                    }
                                }
                            }
                        }
                    }
                    #puts "Falls Sie das anzulernende Ger&auml;t nicht im direkten Zugriff haben, ist das Anlernen mittels"
                    #puts "der Suchfunktion m&ouml;glich. Bet&auml;tigen Sie dazu den Button &quot;Ger&auml;te suchen&quot;"
                    #puts "Die Zentrale lernt dann selbst&auml;ndig alle neuen BidCos-Wired Ger&auml;te an."

                    puts "\${dialogNewDevicesBidCosWiredLbl4a}"
                    puts "\${dialogNewDevicesBidCosWiredLbl4b}"
                    puts "\${dialogNewDevicesBidCosWiredLbl4c}"
                }
            }
        }
    }
    division {class="popupControls"} {
        table {
            table_row {
                table_data {class="CLASS21209"} {
                    division {class="CLASS21213 colorGradient50px"} {onClick="OnBack();"} {
                        #puts "Zur&uuml;ck"
                        puts "\${dialogBack}"
                    }
                }
                table_data {class="CLASS21209"} {
                    division {id="cp_new_devices_button"} {class="CLASS21216 colorGradient50px"} {onClick="OnInbox();"} {
                        #puts "Posteingang"
                        puts "\${dialogNewDevicesfooterBtnDeviceInputA}"
                        br
                        #puts "([get_new_device_count] neue Ger&auml;te)"
                        puts "([get_new_device_count] \${dialogNewDevicesfooterBtnDeviceInputB})"
                    }
                }
                table_data {class="CLASS21206"} {}
            }
        }
    }
    puts ""
    cgi_javascript {
        puts "var url = \"$env(SCRIPT_NAME)?sid=\" + SessionId;"
        puts {
            update_new_device_count = function() {
                var pb = "action=get_new_device_count";
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        var devcount=transport.responseText.replace(/[^0-9]/g, "");
                        for(var i=0;i<document.getElementById("cp_new_devices_button").childNodes.length;i++){
                            var oldval=document.getElementById("cp_new_devices_button").childNodes[i].nodeValue;
                            if(oldval)document.getElementById("cp_new_devices_button").childNodes[i].nodeValue=oldval.replace(/\d+/g, devcount);
                        }
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            install_time_remain=0;
            update_time_bar = function() {
                install_time_remain-=1;
                if((install_time_remain%5)==0){
                    var pb = "action=get_install_status";
                    var opts = {
                        postBody: pb,
                        sendXML: false,
                        onSuccess: function(transport) {
                            if (!transport.responseText.match(/^Success/g)){
                                cp_adddev_updater.stop();
                                return;
                            }
                            var result=transport.responseText.split(" ");
                            var serial="";
                            if(result.length >= 3)serial=result[2];
                            if(serial != ""){
                                cp_adddev_updater.stop();
                                dlgPopup.hide();
                                dlgPopup.setWidth(400);
                                dlgPopup.LoadFromFile(url, "action=put_key_dialog&serial="+serial);
                            }else{
                                install_time_remain=result[1];
                                if(install_time_remain<=0){
                                    if ($("time_bar")) { document.getElementById("time_bar").firstChild.nodeValue= translateKey("dialogNewDevicesBidCosRFFetchmodeNotActive"); } /*"Anlernmodus nicht aktiv"*/
                                    cp_adddev_updater.stop();
                                    update_new_device_count();
                                    install_time_remain=0;
                                }
                            }
                        }
                    };
                    new Ajax.Request(url, opts);
                }
		if(install_time_remain<=0){
                    if ($("time_bar")) { $("time_bar").firstChild.nodeValue= translateKey("dialogNewDevicesBidCosRFFetchmodeNotActive");} /*"Anlernmodus nicht aktiv"*/
                    cp_adddev_updater.stop();
                    update_new_device_count();
                    install_time_remain=0;
                }else{
                    //if ($("time_bar")) { $("time_bar").firstChild.nodeValue="Anlernmodus noch "+String(install_time_remain)+"s aktiv"; }
                    if ($("time_bar")) { $("time_bar").firstChild.nodeValue=translateKey("dialogNewDevicesBidCosRFFetchmodeActiveA")+String(install_time_remain)+translateKey("dialogNewDevicesBidCosRFFetchmodeActiveB"); }
                }
            }
        
            rf_install_mode = function(activate) {
                var pb = "action=rf_install_mode";
                pb += "&activate="+activate;
                if(!activate && cp_adddev_updater)cp_adddev_updater.stop();
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        if (!transport.responseText.match(/^Success/g)){
                            //alert("BidCoS-RF Anlernmodus konnte nicht aktiviert werden.");
                            alert(translateKey("dialogNewDevicesError4"));
                        }
                        result=transport.responseText.split(" ");
                        install_time_remain=result[1];
                        if(install_time_remain > 0){    
                            install_time_remain++;
                            if(!cp_adddev_updater){
                                cp_adddev_updater=new PeriodicalExecuter(update_time_bar, 1);
                            }else if(!cp_adddev_updater.timer){
                                cp_adddev_updater.registerCallback();
                            }
                        }else{
                            install_time_remain=0;
                        }
                        update_time_bar();
                    },
                    onFailure: function(transport) {
                        //alert("BidCoS-RF Anlernmodus konnte nicht aktiviert werden.");
                        alert(translateKey("dialogNewDevicesError4"));
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            rf_serial = function() {
                var pb = "action=rf_serial&";
                pb += "serial="+document.getElementById("text_serial").value;
                Cursor.set(Cursor.WAIT);
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        Cursor.set(Cursor.NORMAL);
                        if (transport.responseText.match(/^Success/g)){
                            update_new_device_count();
                            document.getElementById("text_serial").value="";
                        } else if (transport.responseText.match(/^KeyMismatch/g)){
                            rf_install_mode(false);
                            if(cp_addev_updater)cp_adddev_updater.stop();
                            dlgPopup.hide();
                            dlgPopup.setWidth(400);
                            dlgPopup.LoadFromFile(url, "action=put_key_dialog&serial="+document.getElementById("text_serial").value+"&with_serial=1");
                        } else {
                            //alert("BidCoS-RF Anlernen mit Seriennummer "+document.getElementById("text_serial").value+ unescape(" fehlgeschlagen. Bitte %FCberpr%FCfen Sie die Seriennummer."));
                            alert(translateKey("dialogNewDevicesError1a")+document.getElementById("text_serial").value+ translateKey("dialogNewDevicesError1b"));
                        }
                    },
                    onFailure: function(transport) {
                        Cursor.set(Cursor.NORMAL); 
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            wir_search = function() {
                var pb = "action=wir_search";
                CreateCPPopup2(url, "action=wait_page_wir_search");
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        Popup2Close();
                        if (transport.responseText.match(/^Success/g)){
                            update_new_device_count();
                        } else {
                            //alert(unescape("BidCoS-Wired Ger%E4te suchen fehlgeschlagen."));
                            alert(translateKey("dialogNewDevicesError2"));
                        }
                    },
                    onFailure: function(transport) {
                        Popup2Close();
                    }
                };
                new Ajax.Request(url, opts);
            }
        }
        puts {
            OnInbox = function() {
                rf_install_mode(false);
                PopupClose();
                WebUI.enter(NewDeviceListPage);
            }
            OnBack = function() {
                rf_install_mode(false);
                PopupClose();
            }
        }
        catch { 
            set install_time_remain [xmlrpc $RFD_URL getInstallMode] 
            if { $install_time_remain } {
                puts "install_time_remain=$install_time_remain;"
                puts {
                    if(!cp_adddev_updater)cp_adddev_updater=new PeriodicalExecuter(update_time_bar, 1);
                    else if(!cp_adddev_updater.timer)cp_adddev_updater.registerCallback();
                    update_time_bar();
                }
            }                
        }
        catch {
            import call_js
            puts "$call_js;"
        }

        puts "translatePage('#messagebox');"
        puts "dlgPopup.readaptSize();"

    }
}



proc action_put_key_dialog {} {
    global env
    
    import serial
    set with_serial 0
    catch { import with_serial }
  
    division {class="popupTitle"} {
        #puts "Ger&auml;te anlernen - Sicherheitsabfrage"
        puts "\${dialogNewDevicesErrorSecKeyTitle}"
    }
    division {class="CLASS21200"} {
        table {class="popupTable"} {border="1"} {
            table_row {class="CLASS21202"} {
                table_data {align="left"} {class="CLASS21203"} {
                    #puts "Sie haben gerade versucht, das Ger&auml;t $serial"
                    puts "\${dialogNewDevicesErrorSecKeyLbl1} $serial"
                    if { $with_serial } {
                        # durch Eingabe der Seriennummer
                        puts "\${dialogNewDevicesErrorSecKeyLbl1a}"
                    } else {
                        # im Anlernmodus
                        puts "\${dialogNewDevicesErrorSecKeyLbl1b}"
                    }
                    # anzulernen. Dieser Vorgang konnte nicht durchgef&uuml;hrt werden.
                    puts "\${dialogNewDevicesErrorSecKeyLbl1c}"

                    br
                    #puts "Wahrscheinlich ist diesem Ger&auml;t ein dem System unbekannter System-Sicherheitsschl&uuml;ssel"
                    #puts "zugeordnet. Bitte geben Sie den zum Ger&auml;t geh&ouml;renden System-Sicherheitsschl&uuml;ssel ein und"
                    #puts "starten den Anlernvorgang erneut."

                    puts "\${dialogNewDevicesErrorSecKeyLbl1d}"
                    puts "\${dialogNewDevicesErrorSecKeyLbl1e}"
                    puts "\${dialogNewDevicesErrorSecKeyLbl1f}"

                    table {class="CLASS21204"} {width="100%"} {
                        table_row {
                            td {width="10"} {}
                            #td "System-Sicherheitsschl&uuml;ssel:"
                            td "\${dialogNewDevicesErrorSecKeyLbl1g}"
                            table_data {
                                cgi_text aes_key= {id="text_aes_key"} {width="50"} {type="password"}
                            }
                        }
                    }
                }
            }
        }
    }
    division {class="popupControls"} {
        table {
            table_row {
                table_data {class="CLASS21209"} {
                    division {class="CLASS21213"} {onClick="cancel();"} {
                        #puts "Abbrechen"
                        puts "\${btnCancel}"
                    }
                }
                table_data {class="CLASS21209"} {
                    division {class="CLASS21214"} {onClick="try_again();"} {
                        #puts "Schl&uuml;ssel setzen und erneut versuchen"
                        puts "\${dialogNewDevicesBtnSetKeyAndTryAgain}"
                    }
                }
                table_data {class="CLASS21206"} {}
            }
        }
    }
    puts ""
    cgi_javascript {
        puts "var url = \"$env(SCRIPT_NAME)?sid=\" + SessionId;"
        
        puts {
            try_again = function() {
                var pb = "action=set_temp_key&";
                pb += "key="+document.getElementById("text_aes_key").value;
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        if (transport.responseText.match(/^Success/g)){
                            go_back();
                        } else {
                            //alert(unescape("Tempor%E4rer System-Sicherheitsschl%FCssel konnte nicht gesetzt werden."));
                            alert(translateKey('dialogNewDevicesError3'));
                        }
                    }
                };
                new Ajax.Request(url, opts);
            }
            cancel = function() {
                dlgPopup.hide();
                dlgPopup.setWidth(800);
                dlgPopup.LoadFromFile(url);
            }
        }
        
        puts "go_back = function() \{"
        if {$with_serial} {
            puts "    var pb=\"&serial=$serial&call_js=rf_serial()\";"
        } else {
            puts "    var pb=\"&call_js=rf_install_mode(true)\";"
        }
        puts {
            dlgPopup.hide();
            dlgPopup.setWidth(800);
            dlgPopup.LoadFromFile(url, pb);
        }
        puts "\}"
        puts "translatePage('#messagebox');"
    }
}

proc action_wait_page_wir_search {} {
    division {class="popupTitle j_translate"} {
        #puts "Ger&auml;te werden gesucht ... bitte warten"
        puts "\${dialogNewDevicesLblSearchDevices}"
    }
    puts ""

     cgi_javascript {
      puts "translatePage('.popupTitle');"
     }

}

proc get_new_device_count {} {
    array set result [rega_script {
        integer iNewCount = 0;
        object obj = dom.GetObject(ID_DEVICES);
        if ( obj ) {
          string tmp = "";
          foreach( tmp, obj.EnumEnabledIDs() ) {
            object elem = dom.GetObject(tmp);
            if (elem && (elem.ReadyConfig() == false) && (elem.Name() != 'Gateway')) {
              iNewCount = iNewCount + 1;
            }
          }
        }
    }]
    return $result(iNewCount);
}

proc action_rf_install_mode {} {
    global RFD_URL
    set activate true
    catch { import activate }
    catch {
        xmlrpc $RFD_URL setInstallMode [list bool $activate]
        set time [xmlrpc $RFD_URL getInstallMode]
        puts "Success $time "
        return
    } errMsg
    puts "$errMsg"
}

proc action_get_install_status {} {
    global RFD_URL
    catch {
        set time [xmlrpc $RFD_URL getInstallMode]
        set serial [xmlrpc $RFD_URL getKeyMismatchDevice [list bool true]]
        puts "Success $time $serial "
        return
    } errMsg
    puts "$errMsg"
}

proc action_rf_serial {} {
    global RFD_URL
    if {[catch {
        import serial
        xmlrpc $RFD_URL addDevice [list string $serial]
        puts "Success"
        return
    } errMsg] == -7 } {
        puts "KeyMismatch"
    } else {
#        puts "KeyMismatch"
        puts "$errMsg"
    }
}

proc action_set_temp_key {} {
    global RFD_URL
    if {[catch {
        import key
        xmlrpc $RFD_URL setTempKey [list string $key]
        puts "Success"
        return
    } errMsg]} {
        puts "$errMsg"
    }
}

proc action_wir_search {} {
    if {[catch {
        global HS485D_URL
        xmlrpc $HS485D_URL searchDevices
        puts "Success"
        return
    } errMsg]} {
        puts "$errMsg"
    }
}

proc action_get_new_device_count {} {
    puts [get_new_device_count]
}

cgi_eval {
    #cgi_debug -on
    cgi_input
    catch {
        import debug
        cgi_debug -on
    }

    set action "put_page"

    http_head
    catch { import action }
    if {[session_requestisvalid 8] > 0} then action_$action
}

