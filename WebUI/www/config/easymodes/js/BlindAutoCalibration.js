AutoCalibrateBlind = Class.create();

AutoCalibrateBlind.prototype = {
  initialize: function (iface, address, endPosAutoDetect) {
    var aAddress = address.split(":");

    this.iface = iface;
    this.address = address;
    this.parentAddress = aAddress[0];
    this.endPosAutoDetect = (typeof endPosAutoDetect != "undefined") ? endPosAutoDetect : false;

    this.parentAddress;
    this.paramValueElems = [
      "presetsAutoCalibration",
      "REFERENCE_RUNNING_TIME_BOTTOM_TOP_UNIT",
      "REFERENCE_RUNNING_TIME_BOTTOM_TOP_VALUE",
      "REFERENCE_RUNNING_TIME_TOP_BOTTOM_UNIT",
      "REFERENCE_RUNNING_TIME_TOP_BOTTOM_VALUE"
    ];
    this.tdBtnBlindAutoCalibrationElm;
    this.tdBtnBlindStopCalibrationElm;
    this.autoCalibrationBargraphElm;
    this.calibrationActive;
    this.forceStop;


  },

  initAutoCalibration: function() {
    var self = this;
    this.autoCalibrationPanel = jQuery("#autoCalibrationPanel_"+this.parentAddress);

    this.autoCalibrationBargraphElm = jQuery("#autoCalibrationActive_" + this.parentAddress);
    this.tdBtnBlindAutoCalibrationElm = jQuery("#tdBtnBlindAutoCalibration_" + this.parentAddress );
    this.tdBtnBlindStopCalibrationElm = jQuery("#tdBlindStopCalibration_" + this.parentAddress);

    this.forceStop = false;
    this.calibrationActive = false;

    homematic("Interface.getParamsetDescription", {"interface": this.iface, "address": this.address, "paramsetKey": "VALUES"}, function(result) {
      jQuery.each(result, function(index,value){
        if ((self.endPosAutoDetect) && (value.NAME == "SELF_CALIBRATION")) {
          self.autoCalibrationPanel.show();
          return; // leave the each loop
        }
      });
    });
  },

  triggerAutoCalibration: function () {
    var self = this;
    // Calibration already active?
    if (! this.calibrationActive) {
      this.showStopAutoCalibration();
      homematic("Interface.getValue", {"interface": this.iface, "address": this.address, "valueKey": "SELF_CALIBRATION_RESULT"}, function (result) {

        if (result == 0) {
          var result = homematic("Interface.setValue", {"interface": self.iface, "address": self.address, "valueKey": "SELF_CALIBRATION", "type": "string", "value": "START"}, function (result) {
            self.pollEndOfSelfCalibration(self.address);
          });
        } else {
          // After the first successful calibration the parameter SELF_CALIBRATION_RESULT is set to true and never ever changes this state except a new calibration will be stopped by force.
          // Because we need this parameter to commence further actions after a successful calibration, we firstly start the calibration and stop it immediately so the parameter SELF_CALIBRATION_RESULT will be set to false.
          // After that we can start the calibration again and wait for the parameter SELF_CALIBRATION_RESULT to become true after a successful calibration. Then we can commence the next steps.
          var result = homematic("Interface.setValue", {"interface": self.iface, "address": self.address, "valueKey": "SELF_CALIBRATION", "type": "string", "value": "START"}, function (result) {
            var result = homematic("Interface.setValue", {"interface": self.iface, "address": self.address, "valueKey": "SELF_CALIBRATION", "type": "string", "value": "STOP"}, function (result) {
              var result = homematic("Interface.setValue", {"interface": self.iface, "address": self.address, "valueKey": "SELF_CALIBRATION", "type": "string", "value": "START"}, function (result) {
                self.pollEndOfSelfCalibration(self.address);
              });
            });
          });
        }
      });
    }
  },

  stopAutoCalibration: function() {
    var self = this;
    var result = homematic("Interface.setValue", {"interface": this.iface, "address": this.address, "valueKey": "SELF_CALIBRATION", "type": "string", "value": "STOP"}, function (result) {
      self.forceStop = true;
    });
  },

  pollEndOfSelfCalibration: function() {
    var self = this;
    window.setTimeout(function(){
      homematic("Interface.getValue", {"interface": self.iface, "address": self.address, "valueKey": "SELF_CALIBRATION_RESULT"}, function(result){
        if ((result != 0) || (self.forceStop)) {
          conInfo("Calibration READY");
          self.showStartAutoCalibration();
          self.forceStop = false;
          self.calibrationActive = false;
          if (result == 1) {
            //WebUI.enter(DeviceListPage);
            // Reload the page only when the user hasn't yet left
            if (jQuery("#page_" + self.parentAddress).text() == self.parentAddress) {
              self.reloadConfigPage(self.address);
            }
          }
        } else {
          conInfo("Calibration in progress");
          self.pollEndOfSelfCalibration(self.address);
        }
      });
    },1000);

    if (!this.calibrationActive) {
      this.showStopAutoCalibration();
      // In the case that someone stopped the calibration from another session, the parameter SELF_CALIBRATION_RESULT becomes never true and the calibration animation never stops
      // For security reasons we stop the animation after 5 minutes
      window.setTimeout(function () {
        self.forceStop = true;
      }, 300000);
    }
    this.calibrationActive = true;
  },

  showStartAutoCalibration: function() {
    this.allowValueEditing();
    this.tdBtnBlindAutoCalibrationElm.show();
    this.tdBtnBlindStopCalibrationElm.hide();
    this.autoCalibrationBargraphElm.hide();
  },

  showStopAutoCalibration: function() {
    this.preventValueEditing();
    this.tdBtnBlindAutoCalibrationElm.hide();
    this.tdBtnBlindStopCalibrationElm.show();
    this.autoCalibrationBargraphElm.show();
  },

  allowValueEditing: function() {
    jQuery.each(this.paramValueElems, function(index,val) {
      jQuery("[name='"+val+"']").prop("disabled", false);
    });
  },

  preventValueEditing: function() {
    jQuery.each(this.paramValueElems, function(index,val) {
      jQuery("[name='"+val+"']").prop("disabled", true);
    });
  },

  reloadConfigPage: function() {
    var device = DeviceList.getDeviceByAddress(this.parentAddress);
    DeviceListPage.showConfiguration(false, "DEVICE", device.id);
  }

};