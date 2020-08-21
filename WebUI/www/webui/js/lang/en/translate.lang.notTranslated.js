jQuery.extend(true, langJSON, {
  "en": {

    "helpAlarmSwitchParamDurationValue":
      "Due to legal regulations, the duration of the alarm is limited to 10 minutes. " +
      "This means that an entered value greater than 10 minutes or 600 seconds is ignored.",

      "cpSecurityHttpsRedirectTitle" : "Automatic forwarding to HTTPS",
      "cpSecurityHttpsRedirectLabel" : "Forwarding to HTTPS active:",
      "cpSecurityHttpsRedirectDescription" : "If this function is activated, automatic forwarding to HTTPS takes place when accessing the WebUI via HTTP.",
  
    /* LanRoutingV2 */

    "stringTableBrightnessVisKey": "Brightness of the system button",
    "stringTableDisplayLightingDuration": "Illumination time display",

    "lblBus": "BUS",

    "lblOperatingVoltage": "Output voltage",
    "lblOperatingVoltageStatus": "Status output voltage",
    "lblOperationPowerConsumptionState": "Status current consumption",

    "lblCurrentPowerConsumption": "Actual current consumption",
    "lblCurrentOperatingVoltage": "Actual operating voltage",

    "comment": "lt. D. Stueben 06.02.2020",
    "lblVoltageStatus_0": "Normal",
    "lblVoltageStatus_1": "Unknown",
    "lblVoltageStatus_2": "Overvoltage",
    "lblVoltageStatus_3": "Ext. power supply",


    "lblPowerConsumptionStatus_0": "Normal",
    "lblPowerConsumptionStatus_1": "Unknown",
    "lblPowerConsumptionStatus_2": "Current consumption too high",

    "stringTableOperationPowerConsumptionState": "Status current consumption",
    "lblOperationTemp": "Operating temperature",

    "lblDutyCycle": "Duty cycle",
    "lblCarrierSense": "Carrier Sense",

    "comment": "NEW for the DRAP migration",
    "headerDrapUpdateNecessary": 
    "This update uses Advanced Routing to establish improved communication between the Homematic IP wireless and wired components. " +
      "This requires a firmware update of the Homematic IP Wired Access Point.<br><br>After the update, the Homematic IP Wired Access Point is moved into the inbox and must be configured there.<br>" +
      "All wired devices in the installation that have already been connected and configured will continue to work as usual after the update.",

    "drapUpdateNecessary": "The following Wired Access Points with an incompatible firmware were found and must be updated:<br/><br/>",

    "comment": "SPHM-537",
    "stringTableErrorCoProcessor": "The channel is not accessible. Please check the power supply of the channel or deactivate it in the WebUI.",

    "lblSeeServiceMessage": "See service message!",

    "lblAllChannelsVisible": "All channels visible:",

    "thAvailableVersion": "Available version",
    "thInstalledVersion": "Installed version",
    "btnReload": "Reload",


    "btnAccessPoints": "Update Access Points with</br>incompatible FW",
    "lblShowAllAPs": "Update Access Points with incompatible FW",
    "lblGotoUpdate" : "To the update",

    "apSearchMigrationDescription": "The password of the Homematic IP Access Point and an active Internet connection are required for the update. The password (PW) can be found on the sticker on the device.",

    "apSearchDescription": "The password of the Homematic IP Access Point is required for the update. The password (PW) can be found on the sticker on the device.",
    "password": "Password",
    "apSearchWaitText": "Access Points are searched in the network. Please wait until the search is complete.",
    "apMigrationNoApToUpdate" : "No Access Points were found that require firmware updates.",
    "apMigrationConfigureForUpdateFailed" : "An error occurred when starting the Access Point update. Please check the password and try again.",
    "apMigrationUpdateSuccessful" : "The firmware update was successfully completed.",
    "apMigrationErrorOrTimeout" : "An error occurred during the firmware update Please update the view and try again.",
    "apMigrationUpdateSuccessfulAddition" : "You can now teach-in the Access Point via &ldquo;Teach-in device&rdquo;.",
    "apMigrationUpdateSuccessfulAdditionMigrationMode" : "The Access Point is now in your inbox.",

    "hintDeviceDoesNotSupportAction" : "The currently installed device firmware does not support this function.",


    "stringTableTempHumidityParticulateMatterUnit" : "Unit of automatic sensor cleaning",
    "stringTableTempHumidityParticulateMatterValue" : "Value of automatic sensor cleaning",

    "lblDifferentialTemperature": "Difference temperature T1 - T2",
    "noNeedForUpdate" : "No update required.",
    "notCompatible" : "Not compatible",

    "stringTableMassConc25" : "Mass concentration PM2.5",
    "stringTableMassConc100" : "Mass concentration PM10",
    "stringTableNumberConc25" : "Quantity concentration PM2.5",
    "stringTableNumberConc100" : "Quantity concentration PM10",
    "stringTableTypicalParticelSize" : "Typical particle size",

    "aqiGood" : "Good",
    "aqiModerate" : "Moderate",
    "aqiUnhealty1" : "Unhealthy for sen. people",
    "aqiUnhealty2" : "Unhealthy",
    "aqiUnhealty3" : "Very unhealthy",
    "aqiHazardous" : "Threat to health",
    "lblLocationA" : "Location",
    "Europe" : "Europe",
    "USA" : "USA",

    "hintGroupDevice" : "Please note! This device is part of a heating group.<br/>Adjustments to the temperature profiles should be made in the group.",

    "lblChnNotAllowedInRoom" : "This channel cannot be assigned to a room!",
    "lblChnNotAllowedInFunc" : "This channel cannot be assigned to a function!",

    "stringTableMulticastRouterModuleEnabled" : "MultiCast Routing",

    "lblErrorSensor" : "Sensor error",

     "lblOutputSwap" : "Swap outputs",
    "optionOutputNotSwapped" : "No",
    "optionOutputSwapped" : "Yes",

    "hintSetReady" : "Please press the Done button and configure the device in the device list.",

    "noMoreKeys" : ""
  }
});
