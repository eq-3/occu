<script type=text/javascript>

  dlgPopup.setWidth(650);


  var lightify = "lightify",
  hue = "hue";

  var availableGateways = [lightify, hue];

  var base_url = "/pages/jpages/system/Coupling/",
  ipAddressPort = {},
  ipAddress = {},
  scanActive = {},
  deviceScanning = {},
  pollingTimer = {},
  pollingTime = 3000,
  loopCounter = {},
  maxPollNumber = 20;

  getAvailableGateways = function() {
    return availableGateways;
  };

  jQuery.each(getAvailableGateways(), function(index, gateway) {
    ipAddressPort[gateway] = "",
    ipAddress[gateway] = "",
    deviceScanning[gateway] = false;
    loopCounter[gateway] = 0;
    scanActive[gateway] = false;
  });


  initStartButtons = function() {
    initClickEvents(getAvailableGateways());
  };

  initClickEvents = function(arGateways) {
    jQuery.each(arGateways, function(index, val) {
      jQuery("#btnStartScanGateway_" + val).unbind().click(function(){scanGateway(val);}).val(translateKey("actionStatusControlLblStart"));
    });
  };

  showBargraphAnimation = function(bindingId) {
      var bargraphID = "animBargraph"+bindingId;
      jQuery("#" + bargraphID).show();
  };

  hideBargraphAnimation = function(bindingId) {
      var bargraphID = "animBargraph_"+bindingId;
      jQuery("#" + bargraphID + "_0").hide();
      jQuery("#" + bargraphID + "_1").hide();
  };

  showEnterIPAddress = function(bindingId) {
    jQuery("[name='enterIPForGateway_" + bindingId + "']").show();
  }

  hideEnterIPAddress = function(bindingId) {
    jQuery("[name='enterIPForGateway_" + bindingId + "']").hide();
  }

  showGatewayIPAddress = function(ip, bindingId) {
    jQuery("#gateWayIP_"+bindingId).val(ip);

    if (!isIPv4AddressValid(ip)) {
      showEnterIPAddress(bindingId);
    } else {
      hideEnterIPAddress(bindingId);
    }
  }

  disableSearchingOtherGateways = function(bindingId) {
     jQuery.each(getAvailableGateways(), function(index, gateway) {
      if (gateway != bindingId) {
        conInfo("disableSearchingOtherGateway: " + gateway);
        jQuery("#btnStartScanGateway_" + gateway).unbind().click(function() {alert(gateway + ' disabled.');}).val("--");
      }
    });
  }

  stopPolling = function(bindingId) {

    if (bindingId != undefined) {
      if (pollingTimer[bindingId] != undefined) {
        conInfo("Polling " + bindingId + " deactivated");
        hideBargraphAnimation(bindingId);
        HideWaitAnim()
        clearTimeout(pollingTimer[bindingId]);
        loopCounter[bindingId] = 0;
        scanActive[bindingId] = false;
        initStartButtons();
      }
    } else {
      conInfo("Stop Polling - Close Dialog");
      HideWaitAnim()

      jQuery.each(getAvailableGateways(), function(index, gateway) {
        HideWaitAnim();
        hideBargraphAnimation(gateway);
        clearTimeout(pollingTimer[gateway]);
        loopCounter[gateway] = 0;
        scanActive[gateway] = false;
      });

    }
  }

  showTeachInUserMessage = function(gtw) {
      // gtw can be used later when there are more gateways with a required messaage available.
      alert(translateKey("teachInUserMessage"));
  }

  scanGateway = function(bindingId) {


    if (!scanActive[bindingId]) {

      if (bindingId == hue) {
        showTeachInUserMessage(bindingId);
      }

      var data = new Object();
      var ip = jQuery("#gateWayIP_"+bindingId).val();

      disableSearchingOtherGateways(bindingId);

      scanActive[bindingId] = true;
      deviceScanning[bindingId] = true;
      loopCounter[bindingId] = 0;

      showBargraphAnimation("_"+bindingId+"_"+0);

      conInfo("scanGateway " + bindingId + " activated");

      var url = '/pages/jpages/system/Coupling/scanGateway?bindingID='+bindingId+'&sid='+SessionId;
      var pb = JSON.stringify(data);
      var opt =
      {
        postBody: pb,
        onComplete: function(t) {
          conInfo(bindingId + " scanGateway complete");
          poll4GatewayIP(bindingId);
        }
      };
      ShowWaitAnim();
      HideWaitAnimAutomatically(60);
      new Ajax.Request(url,opt);
    } else {
      conInfo("Scan "+ bindingId +" already active");
    }
  };

  addGatewayByIP = function(bindingId) {
    if (!scanActive[bindingId]) {

      if (bindingId == hue) {
        showTeachInUserMessage(bindingId);
      }

      var ipA = jQuery("#ipA_"+bindingId).val(),
      ipB = jQuery("#ipB_"+bindingId).val(),
      ipC = jQuery("#ipC_"+bindingId).val(),
      ipD = jQuery("#ipD_"+bindingId).val();

      var ipAddr = ipA+"."+ipB+"."+ipC+"."+ipD

      if (! isIPv4AddressValid(ipAddr)) {
        alert(translateKey("invalidIP"));
      } else {
        addGateway(ipAddr, bindingId);
      }
    }
  };


  addGateway = function(ip, bindingId) {
    if (!scanActive[bindingId]) {
      var data = new Object();
      var ip = ip;

      scanActive[bindingId] = true;
      deviceScanning[bindingId] = true;
      loopCounter[bindingId] = 0;

      showBargraphAnimation("_"+bindingId+"_"+1);

      conInfo("scanGateway activated");

      data.gateWayIP = ip;

      var url = '/pages/jpages/system/Coupling/addGateway?sid='+SessionId+'&bindingId='+bindingId;
      var pb = JSON.stringify(data);
      var opt =
      {
        postBody: pb,
        onComplete: function(t) {
          conInfo("addGateway complete");
          poll4GatewayIP(bindingId);
        }
      };
      ShowWaitAnim();
      HideWaitAnimAutomatically(60);
      new Ajax.Request(url,opt);
    }
  };

  // This adds the devices of the gateway
  addNewDevices = function(bindingId) {
    var data = new Object();
    var url = '/pages/jpages/system/Coupling/isScanning?sid='+SessionId;
    var pb = JSON.stringify(data);
    conInfo(bindingId + ": addNewDevices - check if the scan for devices on the server has been completed.");

    loopCounter[bindingId]++;

    var opt =
    {
      postBody: pb,
      onComplete: function(t) {
        var response = JSON.parse(t.responseText);
        deviceScanning[bindingId] = (response.content == "false" || response.content == false) ? false : true;

        // Scanning for devices completed
        if (! deviceScanning[bindingId]) {
          stopPolling(bindingId);
          showGatewayIPAddress(ipAddressPort[bindingId], bindingId);
          conInfo(bindingId +" - All devices are available now so we can refresh the config data");
          ConfigData.destroy();
          ConfigData.check(function() {
            conInfo("Config data refreshed");
          });
        } else {
          conInfo(bindingId + " - Not all devices are known yet - continue scan for devices");
          if (maxPollNumberReached(loopCounter[bindingId])) {
              stopPolling(bindingId);
              alert(translateKey("timeoutAddNewDevices")); // TODO Binding
          } else {
            clearTimeout(pollingTimer[bindingId]); // clear the old timer
            if (scanActive[bindingId]) {
              pollingTimer[bindingId] = setInterval(function() {
                addNewDevices(bindingId);
              },pollingTime);
            }
          }
        }
      }
    };
    new Ajax.Request(url,opt);
  };

  poll4GatewayIP = function(bindingId) {
    conInfo("poll4GatewayIP "+bindingId+" activated");
    pollingTimer[bindingId] = setInterval(function() {getGatewayIP(bindingId, "poll4GatewayIP");}, pollingTime);
  };

  maxPollNumberReached = function(counter) {
    return (counter > maxPollNumber) ? true : false;
  }

  getGatewayIP = function(bindingId, mode) {
    var data = new Object();
    var poll4GatewayIP = "poll4GatewayIP";
    conInfo("getGatewayIP " + bindingId);
    var url = '/pages/jpages/system/Coupling/getGatewayIP?bindingId='+bindingId+'&sid='+SessionId;
    var pb = JSON.stringify(data);

    loopCounter[bindingId]++;

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
          ipAddressPort[bindingId] = response.content.replace("http://", "");
          ipAddress[bindingId] = ipAddressPort[bindingId].split(":")[0];
        } catch (e) {}

        if (isIPv4AddressValid(ipAddress[bindingId])) {
          if (mode == poll4GatewayIP) {
            // Adds all known devices of the gateway
            addNewDevices(bindingId);
          } else {
            stopPolling(bindingId);
            showGatewayIPAddress(ipAddressPort[bindingId], bindingId);
            activateBtnScanDevice();
          }
        } else if (maxPollNumberReached(loopCounter[bindingId])) {
          if (mode == poll4GatewayIP) {
            stopPolling(bindingId);
            alert(alertMsg);
            showEnterIPAddress(bindingId);
          }
        } else {
          showEnterIPAddress(bindingId);
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
		<!-- Osram Lightify -->
		<tr class="CLASS21115">
			<td class="CLASS21116" style="background-color:white;" width="125px">
			  <table>

			    <tr>
			      <td><img src="/ise/img/osramLightify/OsramLightifyLogo.jpg" alt="" width="125px" height="125px"></td>
			    </tr>
			  </table>
			</td>

			<td width="45%" align="center">
			  <table>

			    <tr>
			      <td>${"$"}{btnScanGateway}</td>
			      <td colspan="4"><input id="btnStartScanGateway_lightify" type="button" style="width:100%" name="actionStatusControlLblStart" _onclick="scanGateway('lightify');"></td>
			    </tr>

			    <tr>
			      <td>${"$"}{lblIPAddress}</td>
			      <td colspan="4"><input id="gateWayIP_lightify" type="text" size="20"  style="text-align: center; width:96%" disabled></td>
			    </tr>

 			    <tr id="animBargraph_lightify_0" class="hidden j_animBargraph">
 			      <td></td>
 			      <td colspan="5"><img src="/ise/img/anim_bargraph.gif" alt="" style="width:100%; height:25px; margin-top:15px;"></td>
 			    </tr>

				<tr name="enterIPForGateway_lightify" class="hidden"><td colspan="5"><hr></td></tr>
	
				<tr name="enterIPForGateway_lightify" class="hidden">
					<td>${"$"}{enterIPAddress}</td>
					<td><input id="ipA_lightify" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
					<td><input id="ipB_lightify" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
				<td><input id="ipC_lightify" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
				<td><input id="ipD_lightify" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
				</tr>

			    <tr name="enterIPForGateway_lightify" class="hidden">
			      <td></td>
			      <td style="text-align:center" colspan="4"><input type="button" style="width:100%" name="btnOk" onclick="addGatewayByIP('lightify');"></td>
			    </tr>

 			    <tr id="animBargraph_lightify_1" class="hidden j_animBargraph">
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
		<!-- Philips Hue -->
		<tr class="CLASS21115">
			<td class="CLASS21116" style="background-color:white;" width="125px">
			  <table>
			    <tr>
			      <td><img src="/ise/img/philipsHue/PhilipsHueLogo.jpg" alt="" width="125px" height="125px"></td>
			    </tr>
			  </table>
			</td>

			<td width="45%" align="center">
			  <table>

			    <tr>
			      <td>${"$"}{btnScanGateway}</td>
			      <td colspan="4"><input id="btnStartScanGateway_hue" type="button" style="width:100%" name="actionStatusControlLblStart" _onclick="scanGateway('hue');"></td>
			    </tr>

			    <tr>
			      <td>${"$"}{lblIPAddress}</td>
			      <td colspan="4"><input id="gateWayIP_hue" type="text" size="20"  style="text-align: center; width:96%" disabled></td>
			    </tr>

 			    <tr id="animBargraph_hue_0" class="hidden j_animBargraph">
 			      <td></td>
 			      <td colspan="5"><img src="/ise/img/anim_bargraph.gif" alt="" style="width:100%; height:25px; margin-top:15px;"></td>
 			    </tr>

				<tr name="enterIPForGateway_hue" class="hidden"><td colspan="5"><hr></td></tr>
	
				<tr name="enterIPForGateway_hue" class="hidden">
					<td>${"$"}{enterIPAddress}</td>
					<td><input id="ipA_hue" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
					<td><input id="ipB_hue" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
				<td><input id="ipC_hue" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
				<td><input id="ipD_hue" type="text" style="text-align:center" size="3" maxlength="3" onblur="isValidEntry(this)"/></td>
				</tr>

			    <tr name="enterIPForGateway_hue" class="hidden">
			      <td></td>
			      <td style="text-align:center" colspan="4"><input type="button" style="width:100%" name="btnOk" onclick="addGatewayByIP('hue');"></td>
			    </tr>

 			    <tr id="animBargraph_hue_1" class="hidden j_animBargraph">
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
                ${"$"}{helpPhilipsHue}
              </div>
			        <div class="StdTableBtnHelp" style="text-align:center"><img id="showHueHelp" src="/ise/img/help.png">
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
  dlgPopup.readaptSize();
  jQuery("#gateWayIP_lightify, #gateWayIP_hue").val(translateKey("lblUnknown"));
  getGatewayIP("lightify", "showIPonStart");
  getGatewayIP("hue", "showIPonStart");

  window.setTimeout(function() {initStartButtons();},100);

  var tooltipLightify = translateKey("helpOsramLightifyToolTip");
  var tooltipLightifyElem = jQuery("#showLightifyHelp");
  tooltipLightifyElem.data('powertip', tooltipLightify);
  tooltipLightifyElem.powerTip({placement: "nw", smartPlacement: true, followMouse: false});
  
  var tooltipHue = translateKey("helpPhilipsHueToolTip");
  var tooltipHueElem = jQuery("#showHueHelp");
  tooltipHueElem.data('powertip', tooltipHue);
  tooltipHueElem.powerTip({placement: "nw", smartPlacement: true, followMouse: false});

    
  jQuery("#powerTip").css("opacity",1);
</script>

























