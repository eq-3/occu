<script>
  var accessPointName = null,
  eyeIsVisible = false,
  offlineOperation = false,
  userPassPhrase = null,
  localKeyA = "";
  maxAttemptAssignAP = 10;

	translatePage('#messagebox');
  	dlgPopup.setWidth(600);
	dlgPopup.readaptSize();

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

  IsAssignDoneAccessPoint = function()
	{
		var url = '/pages/jpages/hmip/AccessPointSettings/isAssignmentDone?sid='+SessionId;
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
					if(response.errorCode == "42") {
            jQuery("#messageBoxAssignment").remove();
            PopupClose();
						jQuery("#content").html(response.content);
					} else {
						// Recursive call 'maxAttemptAssignAP' times
						if (maxAttemptAssignAP > 0) {
						  maxAttemptAssignAP--;
						  setTimeout(IsAssignDoneAccessPoint, 5000);
					  } else {
              jQuery("#messageBoxAssignment").remove();
              PopupClose();
              alert(translateKey(response.content));
					  }
					}
				} else {
          jQuery("#messageBoxAssignment").remove();
          PopupClose();
					alert(translateKey(response.content));

					// refresh main list
					ShowAccessPointList();
				}
			}
		}
		new Ajax.Request(url,opt);
	};

	AssignAccessPoint = function()
	{
		var name = accessPointName.replace("'", "").replace("\"", "").replace("\\", "");
		var passphrase = userPassPhrase.replace("'", "").replace("\"", "").replace("\\", "");
		var localKey = localKeyA.replace("'", "").replace("\"", "").replace("\\", "");
		var localKeyChecked = offlineOperation;

		var url = '/pages/jpages/hmip/AccessPointSettings/assignAccessPoint?sid='+SessionId;
		var data = "{";
		data += '"id" : "${accessPoint.id}"';
		data += ',"type" : "${accessPoint.type}"';
		data += ',"name" : "' + name +'"';
		data += ',"passphrase" : "' + passphrase +'"';
		data += ',"localKeyChecked" : "' + localKeyChecked +'"';
		data += ',"localKey" : "' + localKey +'"';
		data += '}';
		var opt =
		{
			postBody: data,
			onComplete: function(t)
			{
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
					MessageBox.show(translateKey(response.content), '<br/><br/><img id="messageBoxAssignmentGraph" src="/ise/img/anim_bargraph.gif"><br/>','','320','90', 'messageBoxAssignment', 'messageBoxAssignmentGraph');
					// first wait 15s
					setTimeout(IsAssignDoneAccessPoint, 15000);
				}
			}
		}
		new Ajax.Request(url,opt);
  };

  showPlainPassword = function() {
    var passwordElm = jQuery("#passphrase"),
    elmType = passwordElm.prop("type"),
    value = passwordElm.val();

    if (elmType == "password") {
      passwordElm.prop("type", "text");
    } else {
      passwordElm.prop("type", "password");
    }
    passwordElm.val(value);
  };

  showOkButton = function() {
    dlg.btnYesShow();
  };

  hideOkButton = function() {
    dlg.btnYesHide();
  };

  storeNewName = function(value) {
    accessPointName = value;
    if ((accessPointName != "") && (userPassPhrase)) {
      showOkButton();
    } else {
     hideOkButton();
    }
  };

  storePassphrase = function(value) {
    if (!eyeIsVisible){
      var elm = jQuery("#theEye");
      elm.show();
      eyeIsVisible = true;
    }
    userPassPhrase = value;

    if ((userPassPhrase != "") && (accessPointName)) {
      showOkButton();
    } else {
      hideOkButton();
    }

  };

  setOfflineOperation = function(value) {
    var trLocalKeyElm = jQuery("#trEnterLocalKey");

    offlineOperation = value;

    if (offlineOperation) {
      trLocalKeyElm.removeClass("visibilityHidden");
    } else {
      trLocalKeyElm.addClass("visibilityHidden");
    }

  };

  storeLocalKey = function(value) {
    localKeyA = value;
  };

  var accessPointType = '${accessPoint.type}',
  devicePic = (accessPointType == "") ? "/config/img/devices/250/CCU3.png" : "/config/img/devices/250/162_hmipw-drap.png",
  togglePwdPic = "/ise/img/visible.png";

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
              dlgHtml += "<input type='text' size='32' value='${accessPoint.id}' disabled>";
            dlgHtml += "</td>";
          dlgHtml += "</tr>";

          if (accessPointType != "") {
            dlgHtml += "<tr>";
              dlgHtml += "<td>";
                dlgHtml += translateKey("thAccessPointType")+":";
              dlgHtml += "</td>";
              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input type='text' value='${accessPoint.type}' disabled>";
              dlgHtml += "</td>";
            dlgHtml += "</tr>";
          }

          dlgHtml += "<tr><td colspan='2'><hr></td></tr>";

          dlgHtml += "<tr>";
            dlgHtml += "<td>";
              dlgHtml += translateKey("thAccessPointName")+":";
            dlgHtml += "</td>";
            dlgHtml += "<td class='td2'>";
              dlgHtml += "<input id='name' type='text' size='32' value='${accessPoint.name}' onkeyup='storeNewName(this.value)' onpaste='var self=this; setTimeout(function() {storeNewName(self.value)},10);'>";
            dlgHtml += "</td>";
          dlgHtml += "</tr>";

          dlgHtml += "<tr id='trPasswordPhrase'>";
            dlgHtml += "<td>";
              dlgHtml += translateKey("accessPointPassphrase")+":";
            dlgHtml += "</td>";
            dlgHtml += "<td class='td2'>";
              dlgHtml += "<input id='passphrase' type='password' size='32' onkeyup='storePassphrase(this.value)' onpaste='var self=this; setTimeout(function() {storePassphrase(self.value)},10);'>";
              dlgHtml += "<div style='font-weight:normal; font-size:11px !important;text-align:center'>"+translateKey("accessPointPassphraseA")+"</div>"
            dlgHtml += "</td>";

            dlgHtml += "<td id='theEye' class='hidden'>"; // show password
              dlgHtml += "<div style='height:16px; width:16px; padding-bottom:15px' onclick='showPlainPassword();'>";
                dlgHtml += "<img style='max-width:100%; max-height:100%;' src='"+togglePwdPic+"'>";
              dlgHtml += "</div>";
            dlgHtml += "</td>";
          dlgHtml += "</tr>";

          dlgHtml += "<tr><td colspan='2'><hr></td></tr>";

          dlgHtml += "<tr align='center'><td colspan='3'>"+translateKey('offlineOperation')+"</td><td style='position:relative; left:-130px'><img src='/ise/img/help.png'/ height='20' width='20' onclick=\"MessageBox.show('"+translateKey('tooltipHelp')+"', '"+translateKey('helpAccessPointOffline')+"', '', 450, 220);\"/></td></tr>";

          dlgHtml += "<tr>";
            dlgHtml += "<td>";
              dlgHtml += translateKey("active")+":";
            dlgHtml += "</td>";
            dlgHtml += "<td class='td2'>";
              dlgHtml += "<input type='checkbox' id='localKeyChecked' onchange='setOfflineOperation(this.checked);'>";
            dlgHtml += "</td>";
          dlgHtml += "</tr>";

          dlgHtml += "<tr id='trEnterLocalKey' class='visibilityHidden'>";
            dlgHtml += "<td>";
              dlgHtml += translateKey("accessPointLocalKey")+":";
            dlgHtml += "</td>";
            dlgHtml += "<td class='td2'>";
              dlgHtml += "<input id='localKey' type='text' size='32' value='' onkeyup='storeLocalKey(this.value)'>";
              dlgHtml += "<div style='font-weight:normal; font-size:11px !important;text-align:center'>"+translateKey("lblSeeQRCodeSticker")+"</div>"
            dlgHtml += "</td>";
          dlgHtml += "</tr>";
        dlgHtml += "</table>";
      dlgHtml += "</td>"; // END Content
    dlgHtml += "</tr>";
  dlgHtml += "</table>";

  var dlg = new YesNoDialog(translateKey("dialogNewAccessPointTitle"),dlgHtml,function(btnPress){
    if (btnPress == YesNoDialog.RESULT_YES) {
      if (accessPointName && userPassPhrase) {
        AssignAccessPoint();
      } else {
        // This should never be called
        alert("Name oder Passwort nicht gesetzt.");
      }
      PopupClose();
    } else {
      PopupClose();
    }
  }, "html");
  dlg.btnYesHide();
  dlg.btnTextYes(translateKey("btnAdd"));
  dlg.btnTextNo(translateKey("dialogBack"));
  dlg.setWidth(650);
</script>
