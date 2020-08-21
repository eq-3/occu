selectAQI = function(mode, address) {
  var chId = DeviceList.getChannelByAddress(address).id;
  homematic("Interface.setMetadata", {
  "objectId" : chId,
  "dataId" : "modeAQI",
  "value" : mode
  }, function(result) {
    conInfo("selectAQI",result);
  });
};

setCurrentAQIMode = function(address) {
  var chId = DeviceList.getChannelByAddress(address).id;
  homematic("Interface.getMetadata", {
    "objectId" : chId,
    "dataId" : "modeAQI"
  }, function(result) {
    conInfo("setCurrentAQIMode",result);
    var defaultMode = "Europe";
    if ((result != null) && (result != "null") && (result != "No metadata available")) {
      jQuery("#modeAirQuality").val(result);
    } else {
      jQuery("#modeAirQuality").val(defaultMode);
      selectAQI(defaultMode, address);
    }
  });
};