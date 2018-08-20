<script>

  var eyeIsVisible = false,
  forcedRemove = false,
  userPassPhrase = "";

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

  IsAccessPointDeletionDone = function()
	{
		var url = '/pages/jpages/hmip/AccessPointSettings/isDeletionDone?sid='+SessionId;
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
        				jQuery("#messageBoxDeletion").remove();
        				PopupClose();
						jQuery("#content").html(response.content);
					} else {
						// Recursive call until it finished or has a crytical problem
						setTimeout(IsAccessPointDeletionDone, 1000);
					}
				} else {
          jQuery("#messageBoxDeletion").remove();
          PopupClose();
          // TODO make a correct message box
					alert(translateKey(response.content));

					// refresh main list
					ShowAccessPointList();
				}
			}
		}
		new Ajax.Request(url,opt);
	};

	RemoveAccessPoint = function()
	{
  	var passphrase = userPassPhrase.replace("'", "").replace("\"", "").replace("\\", "");

		var url = '/pages/jpages/hmip/AccessPointSettings/deleteAccessPoint?sid='+SessionId;
		var data = "{";
		data += '"id" : "${accessPoint.id}"';
		data += ',"passphrase" : "' + passphrase +'"'
		data += ',"forceChecked" : "' + forcedRemove +'"';
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
					MessageBox.show(translateKey(response.content), '<br/><br/><img id="messageBoxDeletionGraph" src="/ise/img/anim_bargraph.gif"><br/>','','320','90', 'messageBoxDeletion', 'messageBoxDeletionGraph');
					setTimeout(IsAccessPointDeletionDone, 1000);
				}
			}
		}
		new Ajax.Request(url,opt);
  };

  setForceRemoved = function(elm) {
    var trPasswordPhraseElm = jQuery("#trPasswordPhrase"),
    //forceReset = jQuery("#forceRemove").prop("checked");
    forceReset = elm.checked;

    if (forceReset) {
      trPasswordPhraseElm.hide();
      forcedRemove = true;
    } else {
      trPasswordPhraseElm.show();
      forcedRemove = false;
    }
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

  storePassphrase = function(value) {
    if (!eyeIsVisible){
      var elm = jQuery("#theEye");
      elm.show();
      eyeIsVisible = true;
    }
    userPassPhrase = value;
  };


  var accessPointType = '${accessPoint.type}',
  devicePic = (accessPointType == "") ? "/config/img/devices/250/CCU3.png" : "/config/img/devices/250/162_hmipw-drap.png";
  togglePwdPic = "/ise/img/visible.png";

  var dlgHtml = "";

  dlgHtml += "<style media='screen' type='text/css'>";

   dlgHtml += ".td2 {padding-left:10px;}";
   dlgHtml += ".border1 {border: 1px solid black;}";
   dlgHtml += ".textCenter {text-align: center;}";
   dlgHtml += ".userHint {margin-left:10px; margin-bottom:20px;}";

  dlgHtml += "</style>";

  dlgHtml += "<div class='userHint attention'>";
      dlgHtml += translateKey("accessPointDeleteHint");
  dlgHtml += "</div>";

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

        dlgHtml += "<tr>";
          dlgHtml += "<td>";
            dlgHtml += translateKey("thAccessPointType")+":";
          dlgHtml += "</td>";
          dlgHtml += "<td class='td2'>";
            dlgHtml += "<input type='text' size='30' value='${accessPoint.type}' disabled>";
          dlgHtml += "</td>";
        dlgHtml += "</tr>";

        dlgHtml += "<tr>";
          dlgHtml += "<td>";
            dlgHtml += translateKey("thAccessPointName")+":";
          dlgHtml += "</td>";
          dlgHtml += "<td class='td2'>";
            dlgHtml += "<input type='text' size='30' value='${accessPoint.name}' disabled>";
          dlgHtml += "</td>";
        dlgHtml += "</tr>";

        dlgHtml += "<tr><td colspan='2'><hr></td></tr>";

        dlgHtml += "<tr>";
          dlgHtml += "<td>";
            dlgHtml += translateKey("accessPointForceDelete")+":";
          dlgHtml += "</td>";
          dlgHtml += "<td class='td2'>";
            dlgHtml += "<input type='checkbox' id='forceRemove' onchange='setForceRemoved(this);'>";
          dlgHtml += "</td>";
        dlgHtml += "</tr>";

        dlgHtml += "<tr id='trPasswordPhrase'>";
          dlgHtml += "<td>";
            dlgHtml += translateKey("accessPointPassphrase")+":";
          dlgHtml += "</td>";
          dlgHtml += "<td class='td2'>";
            dlgHtml += "<input id='passphrase' type='password' size='32' onblur='storePassphrase(this.value)'>";
            dlgHtml += "<div style='font-weight:normal; font-size:11px !important;text-align:center'>"+translateKey("accessPointPassphraseA")+"</div>"
          dlgHtml += "</td>";

          dlgHtml += "<td id='theEye' class='hidden'>"; // show password
            dlgHtml += "<div style='height:16px; width:16px; padding-bottom:15px' onclick='showPlainPassword();'>";
              dlgHtml += "<img style='max-width:100%; max-height:100%;' src='"+togglePwdPic+"'>";
            dlgHtml += "</div>";
          dlgHtml += "</td>";

        dlgHtml += "</tr>";

      dlgHtml += "</table>";
    dlgHtml += "</td>";
   dlgHtml += "</tr>";
  dlgHtml += "</table>";


  var dlg = new YesNoDialog(translateKey("dialogDeleteAccessPointTitle"),dlgHtml,function(btnPress){
    if (btnPress == YesNoDialog.RESULT_YES) {
      RemoveAccessPoint();
      PopupClose();
    } else {
      PopupClose();
    }
  }, "html");
  dlg.btnTextYes(translateKey("btnRemove"));
  dlg.btnTextNo(translateKey("dialogBack"));
  dlg.setWidth(700);

</script>

