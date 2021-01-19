jQuery.extend(true, langJSON, {
  "en": {

    "comment" : "Wird noch nicht übersetzt, ist noch nicht im Release C/2020 enthalten",
    "stringTableAutoRelockDelay" : "Verz%F6gerung autom. Verschlie%DFen",
    "stringTableDoorLockDirection" : "Drehrichtung zum Schlie%DFen",
    "stringTableDoorLockNeutralPos" : "Neutrale Position",
    "stringTableDoorLockTurns" : "Anzhahl der Umdrehungen zum Schlie%DFen",
    "lblVertical" : "Vertikal",
    "lblHorizontal" : "Horizontal",
    "comment" : "END comment",

    "comment" : "Diese Keys nach MASTER_LANG/HmIPWeeklyDeviceProgram.js - Wird noch nicht übersetzt, ist noch nicht im Release C/2020 enthalten",
    "optionDoorLockAction" : "Ger%E4te-Verhalten",
    "optionDoorLockUser" : "Benutzerberechtigung",
    "optionDLDAction1" : "Verriegeln + Auto-Relock Ende",
    "optionDLDAction2" : "100% Verriegeln + Auto-Relock Beginn mit On-Time aus AutoRelockDelay",
    "optionDLDAction3" : "Entriegeln + Auto-Relock Ende",
    "optionDLDAction4" : "Auto-Relock Ende",
    "comment" : "End HmIPWeeklyDeviceProgram.js",


    "stringTableErrorCommunicationParticulateMatterSensor" : "Fine dust sensor communication error",
    "stringTableErrorCommunicationParticulateMatterSensorFalse" : "Fine dust sensor communication: OK",
    "stringTableErrorCommunicationParticulateMatterSensorTrue" : "Fine dust sensor communication: failed",

    "stringTableErrorCommunicationTempAndHumiditySensor" : "Temperature/Humidity sensor communication error",
    "stringTableErrorCommunicationTempAndHumiditySensorFalse" : "Temperature/Humidity sensor communication: OK",
    "stringTableErrorCommunicationTempAndHumiditySensorTrue" : "Temperature/Humidity sensor communication: failed",

    "stringTableErrorParticulateMatterMeasurementFalse" : "Fine dust sensor measurement: OK",
    "stringTableErrorParticulateMatterMeasurementTrue" : "Fine dust sensor measurement: failed",

    "stringTableErrorTempOrHumidityMeasurementFalse" : "Temperature/Humidity measurement: OK",
    "stringTableErrorTempOrHumidityMeasurementTrue" : "Temperature/Humidity measurement: failed",

    "lblTilt" : "Tilt",

    "stringTableAutoHydraulicAdjustment" : "Hydraulic valve adjustment",

    "hintSetReadyWeeklyProgram" : "Please press the Finish button to configure the week program and then access the device in the device list.",



    "lblBehaviour" : "Response",

    "optionColorOFF" : "Back light off",
    "optionColorON" : "Permanently on",
    "blinkSlow" : "Slow flashing",
    "blinkMiddle" : "Medium flashing",
    "blinkFast" : "Fast flashing",
    "blinkFlashSlow" : "Slow lighting",
    "blinkFlashMiddle" : "Medium lighting",
    "blinkFlashFast" : "Fast lighting",
    "blinkBillowSlow" : "Slow pulsing",
    "blinkBillowMiddle" : "Medium pulsing",
    "blinkBillowFast" : "Fast pulsing",

    "stringTableColorOldValue" : "Retain colour value",
    "stringTableColorNoChange" : "Ignore colour value",

    "stringTableColorBehaviourOldValue" : "Retain response",
    "stringTableColorBehaviourDoNotCare" : "Ignore response",

    "stringTableColorBehaviourStatus" : "Status response",

    "stringTableRampTimeOff" : "Ramp off time",

    "helpCombinedParameterTimeLimit" :
      "A non-activated checkbox indicates 'permanently on'.<br/></br>" +
      "When you activate this checkbox, you can then determine the switch-on time.  " +
      "Please note that the switch-on time is limited to 30 hours. A value of 31 hours means 'permanently on'.",

    "helpCombinedParameterTimeLimitWithRampOff" :
    "A non-activated checkbox indicates 'permanently on'.<br/></br>" +
    "When you activate this checkbox, you can then determine the switch-on time as well as the ramp time switch-off. " +
    "Please note that the switch-on time is limited to 30 hours. A value of 31 hours means 'permanently on'. ",


    "lblCO2Concentration" : "CO2 concentration",

    "btnDirectFwUpload" : "Load directly to CCU and install",
    "dialogSettingsCMLblAlternateSoftwareUpdate" : "Alternative procedure:",

    "indoorAirQualityGood" : "Room air quality: Good",
    "indoorAirQualityMediocre" : "Room air quality: Fair<br/><br/>The room should be ventilated.",
    "indoorAirQualityModerate" : "Room air quality: Average<br/><br/>The room should be ventilated as soon as possible.",
    "indoorAirQualityLow" : "Room air quality: Poor<br/><br/>The room should be ventilated immediately.",

    "lblCalibrationValue" : "Calibration value",
    "lblCalibrationInterval" : "Calibration interval",
    "stringTableCalibrationIntervalUnit" : "Unit calibration interval",
    "stringTableCalibrationIntervalValue" : "Value calibration interval",

    "stringTableConcentrationStatus" : "CO2 concentration status",
    "lblAutoCalibration" : "Automatic calibration",

    "stringTableMountingOrientation" : "Display orientation",

    "stringTableConditionSwitchTransmitterParticulateMatter" : "Fine dust sensor",

    "noMoreKeys" : ""
  }
});

langJSON.en.diagramValueTypeCONCENTRATION_CO2 = langJSON.en.lblCO2Concentration;
langJSON.en.stringTableConcentration = langJSON.en.lblCO2Concentration;
langJSON.en.diagramValueTypeCONCENTRATION = langJSON.en.lblCO2Concentration;

langJSON.en.stringTableOpticalSignalReceiver = langJSON.en.stringTableDimmerTitle;

langJSON.en.stringTableAbsoluteAngle = langJSON.en.lblTilt;
langJSON.en.stringTableColorBehaviourOff = langJSON.en.optionColorOFF;
langJSON.en.stringTableColorBehaviourOn = langJSON.en.optionColorON;
langJSON.en.stringTableColorBehaviourBlinkingSlow = langJSON.en.blinkSlow;
langJSON.en.stringTableColorBehaviourBlinkingMiddle = langJSON.en.blinkMiddle;
langJSON.en.stringTableColorBehaviourBlinkingFast = langJSON.en.blinkFast;
langJSON.en.stringTableColorBehaviourFlashSlow = langJSON.en.blinkFlashSlow;
langJSON.en.stringTableColorBehaviourFlashMiddle = langJSON.en.blinkFlashMiddle;
langJSON.en.stringTableColorBehaviourFlashFast = langJSON.en.blinkFlashFast;
langJSON.en.stringTableColorBehaviourBillowSlow = langJSON.en.blinkBillowSlow;
langJSON.en.stringTableColorBehaviourBillowMiddle = langJSON.en.blinkBillowMiddle;
langJSON.en.stringTableColorBehaviourBillowFast = langJSON.en.blinkBillowFast;