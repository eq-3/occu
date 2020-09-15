<script type="text/javascript">

    var ajaxRequest = null;

    jQuery("#powerTip").css("opacity",1);

    RequestCredentialsDialog = Class.create(YesNoDialog, {

        yes: function()
        {
            this.dlk = jQuery("#dlk").val();
            this.passphrase = jQuery("#passphrase").val();
            this.close(YesNoDialog.RESULT_YES);
        }
    });

    searchAccessPoints = function() {
        onInitialState();

        var url = '/pages/jpages/hmip/AccessPoint/searchAccessPoints?sid='+SessionId;
        var opt = {
            onComplete: function(t)
            {

                //jQuery("#content").html(t.responseText);
                var success = JSON.parse(t.responseText);
                console.log(success);
                if(success) {

                    updateUI();
                }
            }
       }
       ajaxRequest = new Ajax.Request(url,opt);
    };

    //function waitInitDone is called indirectly from Java code (AccessPointManagementController.java) by injecting the call into the generated JS code.
    waitInitDone = function() {
        var url = '/pages/jpages/hmip/AccessPoint/waitInitDone?sid='+SessionId;
        var opt = {
            onComplete: function(t)
            {
                searchAccessPoints();
            }
       }
       new Ajax.Request(url,opt);
       console.log("waitInitDone");

    }

    waitForUpdateCompleted = function() {
        var url = '/pages/jpages/hmip/AccessPoint/waitForUpdateCompleted?sid='+SessionId;
        var opt = {
            onComplete: function(t)
            {
                var retCode = parseInt(t.responseText);
                if(retCode == 0) {
                    //try again
                    //updateUI(); //may cal waitForUpdateComplete again
                } else if(retCode == 1) {
                    //success
                    var text = translateKey("apMigrationUpdateSuccessful");
                    if(migrationMode === true) {
                        text = text + "</br>" + translateKey("apMigrationUpdateSuccessfulAdditionMigrationMode");
                    } else {
                        text = text + "</br>" + translateKey("apMigrationUpdateSuccessfulAddition");
                    }
                    MessageBox.show(translateKey("apMigrationUpdateSuccessfulTitle"), text);
                    //updateUI();
                } else if(retCode == 2) {
                    //timeout or error
                    MessageBox.show(translateKey("lblError"), translateKey("apMigrationErrorOrTimeout"));
                    //updateUI();
                } else if(retCode == 3) {
                    var text = translateKey("drapRescueUpdateSuccessful");
                    MessageBox.show(translateKey("apMigrationUpdateSuccessfulTitle"), text);
                } else {
                    //TODO Handle should not happen case
                }
                updateUI();
            }
       }
       new Ajax.Request(url,opt);
       console.log("waitForUpdateCompleted");
    }

    updateUI = function() {
        dlgPopup.close();
        CreateCPPopup("/pages/jpages/hmip/AccessPoint/show");
    };

    sendUpdateAPRequest = function(accessPointId, pwd, dlk)  {
        pwd = pwd.replace(/\\/g, "\\\\");
        pwd = pwd.replace(/"/g, '\\"');
        var url = '/pages/jpages/hmip/AccessPoint/updateAccessPoint?sid='+SessionId;
        var pb = '';
        pb += '{"accessPointId":"'+accessPointId+'",';
        pb += '"pwd":"'+pwd+'"}';
        var opt = {
            method: 'post',
            postBody: pb,
            onComplete: function(t)
            {
                var jsonObj = JSON.parse(t.responseText);
                if(jsonObj.isSuccessful === true) {
                    updateUI(); //java calls waitUpdateComplete on next updateUI iteration, but this way the dialog ui is updated immediately
                    //waitForUpdateCompleted();
                } else {
                    MessageBox.show(translateKey("lblError"), jsonObj.content);
                }
            }
        }
        new Ajax.Request(url,opt);
    };

    sendRescueAPRequest = function(accessPointId, pwd)  {
        pwd = pwd.replace(/\\/g, "\\\\");
        pwd = pwd.replace(/"/g, '\\"');
        var url = '/pages/jpages/hmip/AccessPoint/rescueAccessPoint?sid='+SessionId;
        var pb = '';
        pb += '{"accessPointId":"'+accessPointId+'",';
        pb += '"pwd":"'+pwd+'"}';
        var opt = {
            method: 'post',
            postBody: pb,
            onComplete: function(t)
            {
                var jsonObj = JSON.parse(t.responseText);
                if(jsonObj.isSuccessful === true) {
                    updateUI(); //java calls waitUpdateComplete on next updateUI iteration, but this way the dialog ui is updated immediately
                } else {
                    MessageBox.show(translateKey("lblError"), jsonObj.content);
                }
            }
        }
        new Ajax.Request(url,opt);
    };

    showCredentialsDialog = function(accessPointId) {
        var title = '${"$"}{password}';
        var descriptionText = migrationMode ? '${"$"}{apSearchMigrationDescription}' : '${"$"}{apSearchDescription}';
        var credDlgHtml = "<html><body>";
        credDlgHtml += '<div style="margin:10px">'+descriptionText+'</br></div>';
        credDlgHtml += '<div style="margin:10px">${"$"}{lblUserPassword}</br><input width="30" id="passphrase" placeholder=${"$"}{password} type="password"/></div>';
        credDlgHtml += "</body></html>";

        var credDlg = new RequestCredentialsDialog(title, credDlgHtml , function(result) {
            var self = this;
            if (result) {
                sendUpdateAPRequest(accessPointId, self.passphrase);
            }
        }, "html");
        credDlg.btnTextYes(translateKey("btnOk"));
        credDlg.btnTextNo(translateKey("btnCancel"));
    };

    updateAccessPoint = function(accessPointId) {
        showCredentialsDialog(accessPointId);
    }

    rescueAccessPoint = function(accessPointId) {
        console.log("rescueAccessPoint");
        var title =  '${"$"}{drapRescueIntroTitle}';
        var descriptionText = '${"$"}{drapRescueIntroText}';
        var credDlgHtml = "<html><body>";
        credDlgHtml += '<div style="margin:10px">'+descriptionText+'</br></div>';
        credDlgHtml += '<div style="margin:10px">${"$"}{lblUserPassword}</br><input width="30" id="passphrase" placeholder=${"$"}{password} type="password"/></div>';
        credDlgHtml += "</body></html>";

        var credDlg = new RequestCredentialsDialog(title, credDlgHtml , function(result) {
            var self = this;
            if (result) {
                sendRescueAPRequest(accessPointId, self.passphrase);
            }
        }, "html");
        credDlg.btnTextYes(translateKey("btnOk"));
        credDlg.btnTextNo(translateKey("btnCancel"));
    }

    cleanUpAndClose = function() {
        if (ajaxRequest) {
          ajaxRequest.transport.abort();
        }
        var url = '/pages/jpages/hmip/AccessPoint/reset?sid='+SessionId;
        var opt = {
            onComplete: function(t)
            {
                PopupClose();
            }
       }
       new Ajax.Request(url,opt);
    }

    onInitialState = function() { // called by AccessPointManagementController.java
        console.log("migrationMode="+migrationMode);
        jQuery("#noApToUpdate").hide();
        jQuery("#table").hide();
        jQuery("#btn_reload").hide();
        jQuery("#waitApSearch").show();
    }

    onApSearchFinishedState = function() { // called by AccessPointManagementController.java
        jQuery("#noApToUpdate").hide();
        jQuery("#waitApSearch").hide();
        jQuery("#table").show();
        jQuery("#btn_reload").show();
    }

    onApSearchFinishedStateNoApToUpdate = function() { //called by AccessPointManagementController.java
        console.log("noApToUpdate");
        jQuery("#waitApSearch").hide();
        jQuery("#table").hide();
        jQuery("#noApToUpdate").show();
        jQuery("#btn_reload").show();
    }

    dlgPopup.setWidth(650);

    translatePage('#messagebox');
    translateButtons("actionStatusControlLblStart, btnOk");
    translateButtons("btnUpdate");
    dlgPopup.readaptSize();


</script>
<div class="popupTitle">${"$"}{submenuAccessPointSettings}</div>

<div class="CLASS21114 j_translate">

    <!-- content -->

    <div id="waitApSearch" hidden="true" class="CLASS00016" style="border:1px solid black;">
      <div>${"$"}{apSearchWaitText}</div>
      <img id="waitAnimation" src="/ise/img/anim_bargraph.gif" >
    </div>

    <div id="noApToUpdate" hidden="true" class="CLASS00016" style="border:1px solid black;">
        <div>${"$"}{apMigrationNoApToUpdate}</div>
    </div>

    <div id="table">
       <table id="${TableId}" class="popupTable CLASS20901"  border="0" cellpadding="0" cellspacing="0">
       <thead>
            <tr>
              <td class="thCell CLASS04900" >${"$"}{thPicture}</td>
              <td class="thCell CLASS04900" >${"$"}{thAccessPoint}</td>
              <td class="thCell CLASS04900" >${"$"}{thInstalledVersion}</td>
              <td class="thCell CLASS04900" >${"$"}{thAvailableVersion}</td>
              <td class="thCell CLASS04900" >${"$"}{thAction}</td>
            </tr>
          </thead>


          <tbody>

            <#list objectList as accessPoint>
              <tr class="CLASS04901">

                <td class="tBodyCellCenter">
                  <div id="pic_${accessPoint.id}"></div>
                </td>

                <td class="tBodyCellCenter">
                  <table cellpadding="0" cellspacing="0" border="0" align="center">
                    <tr>
                      <td class="_CLASS04903">
                        ${accessPoint.id}
                      </td>
                    </tr>
                    <tr>
                      <td class="_CLASS04903">
                        ${accessPoint.type}
                      </td>
                    </tr>
                  </table>
                </td>
                <td name="tdVersion" class="tBodyCellCenter">${accessPoint.version}</td>
                <td name="tdAvailableVersion" class="tBodyCellCenter">${accessPoint.availableVersion}</td>

                <!-- Start action column -->
                <td class="tBodyCell CLASS04902" >
                  <table cellpadding="0" cellspacing="0" border="0" align="center">
                    <tr>
                      <td class="CLASS04903">
                        <div id="updateBtn_${accessPoint.id}" class="DeviceListButton hidden">
                          <div class="CLASS21108A" onclick="updateAccessPoint('${accessPoint.id}');">${"$"}{lblUpdate}</div>
                        </div>
                        <div id="rescueBtn_${accessPoint.id}" class="DeviceListButton hidden">
                          <div class="CLASS21108A" onclick="rescueAccessPoint('${accessPoint.id}');">${"$"}{lblUpdate}</div>
                        </div>
                        <div id="noUpdateTxt_${accessPoint.id}" class="hidden">${"$"}{noUpdateNeeded}</div>
                        <div id="updateInProgressTxt_${accessPoint.id}" class="hidden">${"$"}{dialogFirmwareUpdateSuccess}</div>
                      </td>
                  </table>
                </td>
                <!-- End Action Column -->
              </tr>

              <script type="text/javascript">

                //Compares version string a to b.
                //Version format: MAJOR.MINOR.PATCH (e.g. 1..2.3)
                evalVersionAGreaterThanB = function(a, b) {
                    var aSplit = a.split(".", 3);
                    var bSplit = b.split(".", 3);
                    if( Array.isArray(aSplit) && aSplit.length == 3) {
                        if(Array.isArray(bSplit) && bSplit.length == 3) {
                            //major
                            var aI = parseInt(aSplit[0]);
                            var bI = parseInt(bSplit[0]);
                            if( aI > bI ) { return true; }
                            if( aI < bI ) { return false; }
                            //major equal, cmp minor
                            aI = parseInt(aSplit[1]);
                            bI = parseInt(bSplit[1]);
                            if( aI > bI ) { return true; }
                            if( aI < bI ) { return false; }
                            //minor equal, check patch
                            aI = parseInt(aSplit[2]);
                            bI = parseInt(bSplit[2]);
                            if( aI > bI) { return true; }
                            if( aI <= bI ) { return false; }
                        } else { return true; }
                    } else { return false; }
                    return false;
                }

                var accessPointType = '${accessPoint.type}',
                  devicePic = (accessPointType == "HMIP-HAP") ? "/config/img/devices/50/CCU3_thumb.png" : "/config/img/devices/50/162_hmipw-drap_thumb.png";
                  jQuery("#pic_${accessPoint.id}").html("<img style='max-width:100%; max-height:100%;' src='"+devicePic+"'>");

                  //show / hide update button
                  var avFirm = '${accessPoint.availableVersion}';
                  var instFirm = '${accessPoint.version}';
                  var apUpdating = '${accessPoint.updating?c}';
                  var needUdpUpdate = '${accessPoint.needUdpUpdate?c}';
                  if(apUpdating === 'true') {
                      jQuery("#updateInProgressTxt_${accessPoint.id}").show();
                  } else if(needUdpUpdate === 'true') {
                      console.log("needUdpUpdate");
                      jQuery("#rescueBtn_${accessPoint.id}").show();
                  }
                  else {
                      if(evalVersionAGreaterThanB(avFirm, instFirm)) {
                        jQuery("#updateBtn_${accessPoint.id}").show();
                      } else {
                        jQuery("#noUpdateTxt_${accessPoint.id}").show();
                      }
                  }
              </script>

            </#list>
          </tbody>
        </table>

    </div> <!-- table -->
</div> <!-- translate -->

<!-- back and footer -->
<div class="popupControls">
	<table>
		<tr>
			<td class="CLASS21103">
				<div class="CLASS21108" onClick="cleanUpAndClose()">${"$"}{btnSelectRoomOrFunctionClose}</div>
			</td>
			<td></td>
            <td id="btn_reload" class="CLASS21103" style="text-align:right;" hidden="true">
                <div class="CLASS21108" onClick="searchAccessPoints()">${"$"}{btnReload}</div>
            </td>
		</tr>
	</table>
</div>

