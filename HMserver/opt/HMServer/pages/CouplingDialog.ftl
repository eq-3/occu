<script type=text/javascript>

  dlgPopup.setWidth(650);
  dlgPopup.readaptSize();

  var base_url = "/pages/jpages/system/Coupling/",
  ipAddressPort = "",
  ipAddress = "",
  scanActive = false,
  deviceScanning = false,
  pollingTimer,
  pollingTime = 3000,
  loopCounter = 0,
  maxPollNumber = 20;

  showBargraphAnimation = function(mode) {
      var bargraphID = "animBargraph"+mode;
      jQuery("#" + bargraphID).show();
  };

  hideBargraphAnimation = function() {
    jQuery(".j_animBargraph").hide();

  };

  showEnterIPAddress = function() {
    jQuery("[name='enterIPForGateway']").show();
  }

  showGatewayIPAddress = function(ip) {
    jQuery("#gateWayIP").val(ip);

    if (!isIPv4AddressValid(ip)) {
      showEnterIPAddress();
    }
  }

  stopPolling = function() {
    if (pollingTimer != undefined) {
      conInfo("Polling deactivated");
      hideBargraphAnimation();
      HideWaitAnim()
      clearTimeout(pollingTimer);
      loopCounter = 0;
      scanActive = false;
    }
  }

  scanGateway = function() {
    if (!scanActive) {
      var data = new Object();
      var ip = jQuery("#gateWayIP").val();

      scanActive = true;
      deviceScanning = true;
      loopCounter = 0;

      showBargraphAnimation(0);

      conInfo("scanGateway activated");

      //data.gateWayIP = jQuery("#gateWayIP").val();

      var url = '/pages/jpages/system/Coupling/scanGateway?sid='+SessionId;
      var pb = JSON.stringify(data);
      var opt =
      {
        postBody: pb,
        onComplete: function(t) {
          conInfo("scanGateway complete");
          poll4GatewayIP();
        }
      };
      ShowWaitAnim();
      HideWaitAnimAutomatically(60);
      new Ajax.Request(url,opt);
    }
  };

  addLightifyGatewayByIP = function() {
    if (!scanActive) {
      var ipA = jQuery("#ipA").val(),
      ipB = jQuery("#ipB").val(),
      ipC = jQuery("#ipC").val(),
      ipD = jQuery("#ipD").val();

      var ipAddress = ipA+"."+ipB+"."+ipC+"."+ipD

      if (! isIPv4AddressValid(ipAddress)) {
        alert(translateKey("invalidIP"));
      } else {
        addLightifyGateway(ipAddress);
      }
    }
  };


  addLightifyGateway = function(ip) {
    if (!scanActive) {
      var data = new Object();
      var ip = ip;

      scanActive = true;
      deviceScanning = true;
      loopCounter = 0;

      showBargraphAnimation(1);

      conInfo("scanGateway activated");

      data.gateWayIP = ip;

      var url = '/pages/jpages/system/Coupling/addLightifyGateway?sid='+SessionId;
      var pb = JSON.stringify(data);
      var opt =
      {
        postBody: pb,
        onComplete: function(t) {
          conInfo("addGateway complete");
          poll4GatewayIP();
        }
      };
      ShowWaitAnim();
      HideWaitAnimAutomatically(60);
      new Ajax.Request(url,opt);
    }
  };

  // This adds the devices of the gateway
  addNewDevices = function() {
    var data = new Object();
    var url = '/pages/jpages/system/Coupling/isScanning?sid='+SessionId;
    var pb = JSON.stringify(data);
    conInfo("addNewDevices - check if the scan for devices on the server has been completed.");

    loopCounter++;

    var opt =
    {
      postBody: pb,
      onComplete: function(t) {
        var response = JSON.parse(t.responseText);
        deviceScanning = (response.content == "false" || response.content == false) ? false : true;

        // Scanning for devices completed
        if (! deviceScanning) {
          stopPolling();
          showGatewayIPAddress(ipAddressPort);
          conInfo("All devices are available now so we can refresh the config data");
          ConfigData.destroy();
          ConfigData.check(function() {
            conInfo("Config data refreshed");
          });
        } else {
          conInfo("Not all devices are known yet - continue scan for devices");
          if (maxPollNumberReached(loopCounter)) {
              stopPolling();
              alert(translateKey("timeoutAddNewDevices"));
          } else {
            clearTimeout(pollingTimer); // clear the old timer
            pollingTimer = setInterval(function() {
              addNewDevices();
            },pollingTime);
          }
        }
      }
    };
    new Ajax.Request(url,opt);
  };

  poll4GatewayIP = function() {
    conInfo("poll4GatewayIP activated");
    pollingTimer = setInterval(function() {getGatewayIP("poll4GatewayIP");}, pollingTime);
  };

  maxPollNumberReached = function(counter) {
    return (counter > maxPollNumber) ? true : false;
  }

  getGatewayIP = function(mode) {
    var data = new Object();
    var poll4GatewayIP = "poll4GatewayIP";
    conInfo("getGatewayIP");
    var url = '/pages/jpages/system/Coupling/getGatewayIP?sid='+SessionId;
    var pb = JSON.stringify(data);

    loopCounter++;

    var opt =
    {
      postBody: pb,
      onComplete: function(t) {
        var response = JSON.parse(t.responseText);
        var alertMsg = translateKey("unknownError");
        conInfo("HmServer response content: " + response.content);

        if (response.content === undefined) {
          alertMsg = translateKey("msgNoGatewayFound");
        } else {
          alertMsg = response.content;
        }
        try {
          ipAddressPort = response.content.replace("http://", "");
          ipAddress = ipAddressPort.split(":")[0];
        } catch (e) {}

        if (isIPv4AddressValid(ipAddress)) {

          if (mode == poll4GatewayIP) {
            // Adds all known devices of the gateway
            addNewDevices();
          } else {
            stopPolling();
            showGatewayIPAddress(ipAddressPort);
            activateBtnScanDevice();
          }

        } else if (maxPollNumberReached(loopCounter)) {
          if (mode == poll4GatewayIP) {
            stopPolling();
            alert(alertMsg);
            showEnterIPAddress();
          }
        } else {
          showEnterIPAddress();
        }

      }
    };
    new Ajax.Request(url,opt);
  };


  isValidEntry = function(elm) {
    var value = parseInt(elm.value);
    if (isNaN(value) || (value < 0) || (value > 255))  {
      elm.value = "1";
    }
  };

  dlgPopup.readaptSize();
  translatePage('#messagebox');
  translateButtons("actionStatusControlLblStart, btnOk");
</script>

<div class="popupTitle">${"$"}{couplingDialogTitle}</div>
<div class="CLASS21114 j_translate">
	<table class="popupTable" border=1 width="100%">
		<tr class="CLASS21115">
			<td class="CLASS21116" style="background-color:white;" width="125px">
			  <table>

			    <tr>
			      <td><img src="/ise/img/osramLightify/OsramLightifyLogo.jpg" alt="" width="125px" height="125px"></td>
			    </tr>

			    <!--
			    <tr>
			      <td>${"$"}{lblOsramLightify}</td>
			    </tr>
			    -->
			  </table>
			</td>

			<td width="45%" align="center">
			  <table>

			    <tr>
			      <td>${"$"}{btnScanGateway}</td>
			      <td colspan="4"><input type="button" style="width:100%" name="actionStatusControlLblStart" onclick="scanGateway();"></td>
			    </tr>

			    <tr>
			      <td>${"$"}{lblIPAddress}</td>
			      <td colspan="4"><input id="gateWayIP" type="text" size="20"  style="text-align: center; width:96%" disabled></td>
			    </tr>

 			    <tr id="animBargraph0" class="hidden j_animBargraph">
 			      <td></td>
 			      <td colspan="5"><img src="/ise/img/anim_bargraph.gif" alt="" style="width:100%; height:25px; margin-top:15px;"></td>
 			    </tr>

          <tr name="enterIPForGateway" class="hidden"><td colspan="5"><hr></td></tr>

          <tr name="enterIPForGateway" class="hidden">
            <td>${"$"}{enterIPAddress}</td>
            <td><input id="ipA" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
            <td><input id="ipB" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
            <td><input id="ipC" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
            <td><input id="ipD" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
          </tr>

			    <tr name="enterIPForGateway" class="hidden">
			      <td></td>
			      <td style="text-align:center" colspan="4"><input type="button" style="width:100%" name="btnOk" onclick="addLightifyGatewayByIP();"></td>
			    </tr>

 			    <tr id="animBargraph1" class="hidden j_animBargraph">
 			      <td></td>
 			      <td colspan="5"><img src="/ise/img/anim_bargraph.gif" alt="" style="width:100%; height:25px; margin-top:15px;"></td>
 			    </tr>

			  </table>
			</td>
			<td align="center">
			  <table>
				  <tr>
			      <td>
              <div style="overflow:auto; height:auto;">
                ${"$"}{helpOsramLightify}
              </div>
			        <div class="StdTableBtnHelp" style="text-align:center"><img id="showLightifyHelp" src="/ise/img/help.png">
			        </div>
			      </td>
			    </tr>
			  </table>
			</td>

		</tr>
	</table>
</div>

<div class="popupControls">
	<table>
		<tr>
			<td class="CLASS21103">
				<div class="CLASS21108" onClick="stopPolling();PopupClose()">${"$"}{footerBtnPageBack}</div>
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">
  jQuery("#gateWayIP").val(translateKey("lblUnknown"));
  getGatewayIP("showIPonStart");
  var tooltip = translateKey("helpOsramLightifyToolTip");
  var tooltipElem = jQuery("#showLightifyHelp");
  tooltipElem.data('powertip', tooltip);
  tooltipElem.powerTip({placement: "nw", smartPlacement: true, followMouse: false});
  jQuery("#powerTip").css("opacity",1);
</script>
