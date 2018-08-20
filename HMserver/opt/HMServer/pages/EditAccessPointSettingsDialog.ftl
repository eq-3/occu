<script>

  var accessPointName,
  btnOKVisible = false;


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
        			// TODO make a correct message box
					alert(translateKey(response.content));
				}
			}
		}
		new Ajax.Request(url,opt);
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

  showBtnUpload = ((availableFwVersion != versionNotAvailable) || (availableFwVersionCoPro != versionNotAvailable)) ? true : false;

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
              dlgHtml += "<input id='accessPointName' type='text' size='30' value='${accessPoint.name}' onblur='storeNewName(this.value)'>";
            dlgHtml += "</td>";
          dlgHtml += "</tr>";

          dlgHtml += "<tr><td colspan='2'><hr></td></tr>";

          dlgHtml += "<tr align='center'><td colspan='3'>"+translateKey('lblFirmwareVersions')+"</td></tr>";

          dlgHtml += "<table>"
            dlgHtml += "<tr><th></th><th>"+translateKey('dialogShowDeviceFirmwareTHCurFw')+"</th><th>"+translateKey('lblAvailableCapital')+"</th></tr>";
            dlgHtml += "<tr>";
              dlgHtml += "<td>";
                dlgHtml += translateKey("thAccessPointVersion")+":";
              dlgHtml += "</td>";
              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input id='versionMainprocessor' type='text' class='textCenter' size='10' value='"+accessPointVersion+"' disabled>";
              dlgHtml += "</td>";

              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input type='text' class='textCenter' size='10' value='"+availableFwVersion+"' disabled>";
              dlgHtml += "</td>";
            dlgHtml += "</tr>";

            dlgHtml += "<tr>";
              dlgHtml += "<td>";
                dlgHtml += translateKey("thAccessPointVersionCoprocessor")+":";
              dlgHtml += "</td>";
              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input id='versionCoprocessor' type='text' class='textCenter' size='10' value='"+coProcessorVersion+"' disabled>";
              dlgHtml += "</td>";

              dlgHtml += "<td class='td2'>";
                dlgHtml += "<input type='text' class='textCenter' size='10' value='"+availableFwVersionCoPro+"' disabled>";
              dlgHtml += "</td>";
            dlgHtml += "</tr>";

            if (showBtnUpload) {
              dlgHtml += "<tr>";
                 dlgHtml += "<td><td><td class='CLASS04903 td2'>";
                   dlgHtml += "<input type='button' class='DeviceListButton' name='lblUpdate' value='"+translateKey('lblUpdate')+"' onclick='UpdateAccessPoint();'>";
                 dlgHtml += "</td></td></td>";
              dlgHtml += "</tr>";
            }

          dlgHtml += "</table>"

        dlgHtml += "<table>";

      dlgHtml += "</td>"; // END Content
    dlgHtml += "</tr>";
  dlgHtml += "</table>";

  var dlg = new YesNoDialog(translateKey("dialogEditAccessPointTitle"),dlgHtml,function(btnPress){
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
  dlg.btnTextYes(translateKey("btnOk"));
  dlg.btnTextNo(translateKey("dialogBack"));
  dlg.setWidth(650);

</script>

