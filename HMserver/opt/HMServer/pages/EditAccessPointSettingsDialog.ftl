<script>

  var accessPointName,
  eyeIsVisible = false,
  btnOKVisible = false,
  userPassPhrase = null,
  selectedMaxBusCurrent,
  selectedBusConfig,
  configDirty = false,

  minBusCurrent,
  maxBusCurrent,

  dlgEditAP,
  dlgConfigAPEnterPassphrase,
  dlgConfigAP;

  togglePwdPic = "/ise/img/visible.png";

  showPlainPassword = function() {
    var passwordElm = jQuery("#passphraseConfigAP"),
    elmType = passwordElm.prop("type"),
    value = passwordElm.val();

    if (elmType == "password") {
      passwordElm.prop("type", "text");
    } else {
      passwordElm.prop("type", "password");
    }
    passwordElm.val(value);
  };

  getDrapConfiguration = function() {

    MessageBox.show(
    translateKey('lblQueryConfig'),
    '<br/><br/><img id="msgBoxBarGraph" src="/ise/img/anim_bargraph.gif"><br/>',
    '','320','105','getDrapConfig', 'msgBoxBarGraph');

    var url = '/pages/jpages/hmip/AccessPointSettings/getDRAPConfiguration?sid='+SessionId;
    var data = "{";
    data += '"id" : "${accessPoint.id}"';
    data += ',"passphrase" : "' + userPassPhrase +'"';
    data += '}';
		var opt =
		{
		  postBody: data,
			onComplete: function(t) {
			  MessageBox.close();
			  var response = JSON.parse(t.responseText);
        if (response.isSuccessful) {
          var content = JSON.parse(response.content);
          setDrapConfiguration(content);
        } else {
          MessageBox.show(translateKey('stringTableError'),translateKey(response.content), function() {
            showDlgEditAP();
          });
        }
			}
		}
		new Ajax.Request(url,opt);

  };

  setNewDrapConfiguration = function() {

    if (configDirty) {

      MessageBox.show(
      translateKey('lblSetConfig'),
      '<br/><br/><img id="msgBoxBarGraph" src="/ise/img/anim_bargraph.gif"><br/>',
      '','320','105','getDrapConfig', 'msgBoxBarGraph');

      var url = '/pages/jpages/hmip/AccessPointSettings/setDRAPConfiguration?sid='+SessionId;
      var data = "{";
      data += '"id" : "${accessPoint.id}"';
      data += ',"passphrase" : "' + userPassPhrase +'"';
      data += ',"bus_config" : '+ selectedBusConfig;
      data += ',"max_bus_current" : '+ selectedMaxBusCurrent;
      data += '}';
      var opt =
      {
        postBody: data,
        onComplete: function(t) {
          configDirty = false;
          MessageBox.close();
          var response = JSON.parse(t.responseText);
          if (response.isSuccessful) {
              MessageBox.show("",translateKey(response.content), function() {
                showDlgEditAP();
              });
          } else {
            MessageBox.show(translateKey('stringTableError'),translateKey(response.content), function() {
              showDlgEditAP();
            });
          }
        }
      }
      new Ajax.Request(url,opt);
    } else {
      // Configuration not changed
      MessageBox.show(translateKey("dialogHint"),translateKey("lblConfigNotChanged"), function() {
        showDlgEditAP();
      });
    }
  };

  setDrapConfiguration = function(data) {
    minBusCurrent = data.max_bus_current.min;
    maxBusCurrent = data.max_bus_current.max;

    dlgConfigAP = new YesNoDialog(translateKey("titleConfigDialog"),getConfigAPDlgHTML(data),function(btnPress){
      if (btnPress == YesNoDialog.RESULT_YES) {
        setNewDrapConfiguration();
      } else {
        showDlgEditAP();
      }
    }, "html");

    dlgConfigAP.btnTextNo(translateKey('dialogBack'));
    dlgConfigAP.btnTextYes(translateKey('btnSave'));

    window.setTimeout(function() {
        jQuery("#busConfig option[value="+data.bus_config.value+"]").prop("selected", true);
    }, 250);

  };

  ShowAccessPointList = function()
	{  
		var url = '/pages/jpages/hmip/AccessPointSettings/?sid='+SessionId;
		var opt =
		{
			onComplete: function(t)
			{
				jQuery("#content").html(t.responseText);
			}
		}
		new Ajax.Request(url,opt);
	};
    
	SetAccessPointName = function()
	{
		var name = accessPointName.replace("'", "").replace("\"", "").replace("\\", "").trim();

		var url = '/pages/jpages/hmip/AccessPointSettings/setAccessPointName?sid='+SessionId;
		var data = "{";
		data += '"id" : "${accessPoint.id}"';
		data += ',"name" : "' + name +'"';
		data += '}';
		var opt =
		{
			postBody: data,
			onComplete: function(t) {
				var response = JSON.parse(t.responseText);

				if(!response.isSuccessful)
				{
					if(response.errorCode == "42")
					{
						PopupClose();
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey(response.content));
					}
				} else {				
					PopupClose();
        	// response.content = SetAccessPointNameSuccess
					//alert(translateKey(response.content));
					
					// refresh main list	
					ShowAccessPointList();
				}
			}
		}
		new Ajax.Request(url,opt);
		
  };
    
  UpdateAccessPoint = function()
	{
	  if (typeof availableFwVersion != "undefined") {
      var arAvailFw = availableFwVersion.split(".");
      if (arAvailFw.length == 3) {
        var fwMajor = parseInt(arAvailFw[0]),
        fwMinor = parseInt(arAvailFw[1]),
        fwPatch = parseInt(arAvailFw[2]);

        // Check if fw >= 2.2.0
        if ((fwMajor < 2) || (fwMajor == 2 && fwMinor < 2))  {
          var url = '/pages/jpages/hmip/AccessPointSettings/startAccessPointUpdate?sid='+SessionId;
          var data = "{";
          data += '"id" : "${accessPoint.id}"';
          data += '}';
          var opt =
          {
            postBody: data,
            onComplete: function(t)
            {
              var response = JSON.parse(t.responseText);
              if(!response.isSuccessful) {
                if(response.errorCode == "42")
                {
                  PopupClose();
                  jQuery("#content").html(response.content);
                } else {
                  alert(translateKey(response.content));
                }
              } else {
                PopupClose();
                alert(translateKey(response.content));
              }
            }
          }
          new Ajax.Request(url,opt);
        } else {
          alert(translateKey("drapFwNotCompatWithCCUFW"));
        }
      } else {
        conInfo("UpdateAccessPoint - Version should be x.y.z but is: " + availableFwVersion);
      }
    } else {
      conInfo("UpdateAccessPoint - Available version not defined");
    }
	};

  storePassphrase = function(value) {
    if (!eyeIsVisible){
      var elm = jQuery("#theEye");
      elm.show();
      eyeIsVisible = true;
    }
    userPassPhrase = value;
    if (userPassPhrase.length > 0) {
      dlgConfigAPEnterPassphrase.btnYesShow();
    } else {
      dlgConfigAPEnterPassphrase.btnYesHide();
    }
  };

  checkMinMaxBusCurrent = function(value) {
    var result = parseInt(value);
    if ((isNaN(result)) || (parseInt(value) < minBusCurrent)) {
      result = minBusCurrent;
    }

    if (parseInt(value) > maxBusCurrent) {
      result = maxBusCurrent;
    }
    jQuery("#maxBusCurrent").val(result);
    return result;
  };

  storeMaxBusCurrent = function(value) {
    selectedBusConfig = jQuery("#busConfig").val();
    selectedMaxBusCurrent = checkMinMaxBusCurrent(value);
    configDirty = true;
  };

  storeBusConfig = function(value) {
    selectedBusConfig = value;
    selectedMaxBusCurrent = checkMinMaxBusCurrent(jQuery("#maxBusCurrent").val());
    configDirty = true;
  };

  ConfigureAccessPoint = function() {
    getDrapConfiguration();
  };


  EnterPassPhraseAccessPoint = function() {
    dlgEditAP.close();

    dlgConfigAPEnterPassphrase = new YesNoDialog(translateKey("titleConfigDialog"),getConfigAPPassphraseDlgHTML(),function(btnPress){
      if (btnPress == YesNoDialog.RESULT_YES) {
        ConfigureAccessPoint();
      } else {
        eyeIsVisible = false;
        showDlgEditAP();
      }
    }, "html");
    dlgConfigAPEnterPassphrase.setWidth(450);
    dlgConfigAPEnterPassphrase.btnTextNo(translateKey('dialogBack'));
    dlgConfigAPEnterPassphrase.btnTextYes(translateKey('btnNext'));
    dlgConfigAPEnterPassphrase.btnYesHide();

  };

  getConfigAPPassphraseDlgHTML = function() {
    var html = "";
    html += "<table align='center'>"
      html += "<tr><td align='center'>"+translateKey('accessPointPassphrase')+"</td></tr>";
       html += "<tr><td class='td2'>"
       html += "<input id='passphraseConfigAP' type='password' size='32' onkeyup='storePassphrase(this.value)' onpaste='var self=this; setTimeout(function() {storePassphrase(self.value)},10);' style='text-align:center'>"
       html += "<div style='font-weight:normal; font-size:11px !important;text-align:center'>"+translateKey("accessPointPassphraseA")+"</div>"
       html += "</td>";

       html += "<td id='theEye' class='hidden'>"; // show password
         html += "<div style='height:16px; width:16px; padding-bottom:15px' onclick='showPlainPassword();'>";
           html += "<img style='max-width:100%; max-height:100%;' src='"+togglePwdPic+"'>";
         html += "</div>";
       html += "</td>";

       html += "</tr>";
    html += "</table>";
    return html;
  };

  showHelp =function(topic) {
    MessageBox.show(translateKey('genericBtnTxtHelp'),topic);
  };

  getConfigAPDlgHTML = function(data) {
    var html = "";

    html += "<table>";

       html += "<tr><td>"+translateKey('drapMaxCurrentBus')+":</td>"
       html += "<td><input id='maxBusCurrent' type='text' size='4' onchange='storeMaxBusCurrent(this.value)' value='"+data.max_bus_current.value+"'>&nbsp;mA ("+data.max_bus_current.min+" - "+data.max_bus_current.max+")";
        html += "&nbsp;<img src='/ise/img/help.png' style='cursor: pointer; width:18px; height:18px; position:relative; top:2px' onclick='showHelp(translateKey(\"drapHelpMaxCurrentBus\"));'>";
       html += "</td></tr>";

       html += "<tr><td>"+translateKey('drapBusConfig')+":</td><td>";
        html += "<select id='busConfig' onchange='storeBusConfig(this.value)'>";
          html += "<option value='1'>"+translateKey('optionRingMode')+"</option>";
          html += "<option value='2'>"+translateKey('optionTwoSeparateBusSystems')+"</option>";
        html += "</select>";
        html += "&nbsp;<img src='/ise/img/help.png' style='cursor: pointer; width:18px; height:18px; position:relative; top:2px' onclick='showHelp(translateKey(\"drapHelpBusConfig\"));'>";
       html += "</td></tr>";
    html += "</table>";
    return html;

  };

  storeNewName = function(name) {
    accessPointName = name;

    if (!btnOKVisible) {
      btnOKElm.show();
      btnOKVisible = true;
    }

  };

  var   versionNotAvailable = translateKey("accessPointNotAvailable"),
  accessPointType = '${accessPoint.type}',
  accessPointVersion = '${accessPoint.version}',
  coProcessorVersion = '${accessPoint.versionCoprocessor}',
  availableFwVersion = '${availableVersion}',
  availableFwVersionCoPro = '${availableVersionCoprocessor}';

  accessPointVersion = accessPointVersion.replace("$\{notAvailable\}", versionNotAvailable);
  coProcessorVersion = coProcessorVersion.replace("$\{notAvailable\}", versionNotAvailable);
  availableFwVersion = (availableFwVersion.length > 0) ?  availableFwVersion : versionNotAvailable;
  availableFwVersionCoPro = (availableFwVersionCoPro.length > 0) ? availableFwVersionCoPro : versionNotAvailable;

  var devicePic = (accessPointType == "") ? "/config/img/devices/250/CCU3.png" : "/config/img/devices/250/162_hmipw-drap.png";

  showBtnUpload = (
    (availableFwVersion != accessPointVersion) || (availableFwVersionCoPro != coProcessorVersion) ||
    ((accessPointVersion == versionNotAvailable) && (availableFwVersion != versionNotAvailable)) ||
    ((coProcessorVersion == versionNotAvailable) && (availableFwVersionCoPro != versionNotAvailable))
    ) ? true : false;

  var dlgHtml = "";

  dlgHtml += "<style media='screen' type='text/css'>";

    dlgHtml += ".td2 {padding-left:10px;}";
    dlgHtml += ".border1 {border: 1px solid black;}";
    dlgHtml += ".textCenter {text-align: center;}";

  dlgHtml += "</style>";

  dlgHtml += "<table>";
    dlgHtml += "<tr>";
      dlgHtml += "<td>"; // Picture
        dlgHtml += "<div class='border1' style='height:200px; width:200px; margin-right:35px'>";
          dlgHtml += "<img style='max-width:100%; max-height:100%;' src='"+devicePic+"'>";
        dlgHtml += "</div>";
      dlgHtml += "</td>";

      dlgHtml += "<td>"; // Content

        dlgHtml += "<table>";
          dlgHtml += "<tr>";
            dlgHtml += "<td>";
              dlgHtml += translateKey("thAccessPointID")+":";
            dlgHtml += "</td>";
            dlgHtml += "<td class='td2'>";
              dlgHtml += "<input type='text' size='30' value='${accessPoint.id}' disabled>";
            dlgHtml += "</td>";
          dlgHtml += "</tr>";

          if (accessPointType != "") {
            dlgHtml += "<tr>";
              dlgHtml += "<td>";
                dlgHtml += translateKey("thAccessPointType")+":";
              dlgHtml += "</td>";
              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input type='text' size='30' value='${accessPoint.type}' disabled>";
              dlgHtml += "</td>";
            dlgHtml += "</tr>";
          }

          dlgHtml += "<tr>";
            dlgHtml += "<td>";
              dlgHtml += translateKey("thAccessPointName")+":";
            dlgHtml += "</td>";
            dlgHtml += "<td class='td2'>";
              dlgHtml += "<input id='accessPointName' type='text' size='30' value='${accessPoint.name}' onkeyup='storeNewName(this.value)' onpaste='var self=this; setTimeout(function() {storeNewName(self.value)},10);'>";
            dlgHtml += "</td>";
          dlgHtml += "</tr>";

          dlgHtml += "<tr><td colspan='2'><hr></td></tr>";

          dlgHtml += "<tr align='center'><td colspan='3'>"+translateKey('lblFirmwareVersions')+"</td></tr>";

          dlgHtml += "<table>";
            dlgHtml += "<tr>";
              dlgHtml +=  "<th></th>";
              dlgHtml +=  "<th>"+translateKey('dialogShowDeviceFirmwareTHCurFw')+"</th>";
              if (accessPointType != "") {
                dlgHtml += "<th>" + translateKey('lblAvailableCapital') + "</th>";
              }
            dlgHtml +=  "</tr>";

            dlgHtml += "<tr>";
              dlgHtml += "<td>";
                dlgHtml += translateKey("thAccessPointVersion")+":";
              dlgHtml += "</td>";
              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input id='versionMainprocessor' type='text' class='textCenter' size='10' value='"+accessPointVersion+"' disabled>";
              dlgHtml += "</td>";

              if (accessPointType != "") {
                dlgHtml += "<td class='td2'>";
                dlgHtml += "<input type='text' class='textCenter' size='10' value='" + availableFwVersion + "' disabled>";
                dlgHtml += "</td>";
              }
            dlgHtml += "</tr>";

            dlgHtml += "<tr>";
              dlgHtml += "<td>";
                dlgHtml += translateKey("thAccessPointVersionCoprocessor")+":";
              dlgHtml += "</td>";
              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input id='versionCoprocessor' type='text' class='textCenter' size='10' value='"+coProcessorVersion+"' disabled>";
              dlgHtml += "</td>";

              if (accessPointType != "") {
                dlgHtml += "<td class='td2'>";
                dlgHtml += "<input type='text' class='textCenter' size='10' value='" + availableFwVersionCoPro + "' disabled>";
                dlgHtml += "</td>";
              }
            dlgHtml += "</tr>";

            if (accessPointType != "") {
              if (showBtnUpload) {
                dlgHtml += "<tr>";
                dlgHtml += "<td><td><td class='CLASS04903 td2'>";
                dlgHtml += "<input type='button' class='DeviceListButton' name='lblUpdate' value='" + translateKey('lblUpdate') + "' onclick='UpdateAccessPoint();'>";
                dlgHtml += "</td></td></td>";
                dlgHtml += "</tr>";
              }

              dlgHtml += "<tr><td colspan='3'><hr></td></tr>";
              //dlgHtml += "<tr align='center'><td colspan='3'>"+translateKey('lblAccessPointConfiguration')+"</td></tr>";
              dlgHtml += "<tr align='center'>";
              dlgHtml += "<td colspan='3'><input type='button' class='DeviceListButton' name='lblAccessPointConfig' value='" + translateKey('btnAccessPointConfig') + "' onclick='EnterPassPhraseAccessPoint();'></td>";
              dlgHtml += "</tr>";
            }
          dlgHtml += "</table>";
        dlgHtml += "<table>";
      dlgHtml += "</td>"; // END Content
    dlgHtml += "</tr>";
  dlgHtml += "</table>";

  showDlgEditAP = function() {
    dlgEditAP = new YesNoDialog(translateKey("dialogEditAccessPointTitle"),dlgHtml,function(btnPress){
      if (btnPress == YesNoDialog.RESULT_YES) {
        if (typeof accessPointName != "undefined") {
          SetAccessPointName();
        } else {
          PopupClose();
        }
      } else {
        PopupClose();
      }
    }, "html");
    btnOKElm = jQuery(".YesNoDialog_yesButton")[0];
    btnOKElm.hide();
    dlgEditAP.btnTextYes(translateKey("btnOk"));
    dlgEditAP.btnTextNo(translateKey("dialogBack"));
    dlgEditAP.setWidth(650);
  };

  showDlgEditAP();

</script>

