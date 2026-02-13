jQuery.extend(true, langJSON, {
  "en": {
    "lblCampfire" : "Campfire",
    "lblRainbow" : "Rainbow",
    "lblSunrise" : "Sunrise",
    "lblSunset" : "Sunset",
    "lblWaterfall" : "Waterfall",
    "lblForest" : "Forest",
    "lblEffect7" : "Effect 7",
    "lblEffect8" : "Effect 8",
    "lblRedFlashing" : "red flashing",
    "lblGreenWobble" : "green swirls",

    "lblDisplayModeETRV" : "Display mode",
    "optionReducedMode" : "Reduced mode",
    "optionFunctionalMode" : "Functional mode",

    "lblDisplayColor" : "Display colour",
    "optionNormalColors" : "Normal",
    "optionInvertedColors" : "Inverted",

    "optionAllowed" : "Authorised",
    "optionNotAllowed" : "Not authorised",

    "lblPermission" : "Authorisation",

    "stringTablePermissionStateFalse" : "Channel not authorised",
    "stringTablePermissionStateTrue" : "Channel authorised",

    "lblAngle" : "Angle",

    "lblInfoStatusControlDeviceFeedIn" : "Feed-in meter device",
    "lblInfoStatusControlFeedInCounter" : "Feed-in meter CCU",

    "hintHeatingCoolngNotAllowed" :
      "The heating/cooling display fields show the currently set mode.<br/><br/>" +
      "If there is <b><u>no</u></b> link between an Homematic IP wall thermostat and an Homematic IP heating controller, the mode can also be actively changed.<br/><br/>" +
      "<b>In heating groups, the two fields only display the set mode. A change is not possible.</b>",

    "stringTableAltitude" : "Height above sea level",
    "stringTableAirPressure" : "Air pressure",
    "lblMeter" : "Meter",

    "optionOneBtn" : "1 Button",
    "optionTwoBtnLeftRRight" : "2 Buttons left/right",
    "optionTwoBtnUpDDown" : "2 Buttons up/down",
    "optionFourBtn" : "4 Buttons",

    "lblHeaderFeedbackLevelMode" : "Brightness feedback (brightness of the pressed button)",
    "lblFeedbackLevelMode" : "Feedback mode",
    "lblFeedbackLevelValue" : "Level feedback",

    "lblHeaderActivateLevelMode" : "Active brightness",

    "lblActivateLevelMode" : "Level mode",
    "lblActivateLevelValue" : "Level active brightness",
    "optionAbsolut" : "Absolute",
    "optionRelativ" : "Relative",

    "stringTableActivateLevelOnTime" : "Unit switch-on duration",

    "stringTableErrorTempSensor" : "Error temperature sensor",
    "stringTableErrorTempSensorFalse" : "Temperature sensor ok",
    "stringTableErrorTempSensorTrue" : "Temperature sensor not ok",

    "stringTableErrorTempSensor2" : "Error temperature sensor 2",
    "stringTableErrorTempSensor2False" : "Temperature sensor 2 ok",
    "stringTableErrorTempSensor2True" : "Temperature sensor 2 not ok",

    "lblDisplayLayoutMode" : "Display layout",

    "hintPrgExists_WGT" : "There is at least one program. Therefore, switching the mode (channel 4) is disabled.",
    "hintLinkExists_WGT" : "There is at least one link. Therefore, switching the mode (channel 4) is disabled.",

    "optionActual" : "Current temperature",
    "optionSetpoint" : "Setpoint temperature",
    "optionActualHumidity" : "Current temperature/humidity",
    "optionCO2" : "CO2",
    "optionActualHumidityCO2" : "Current temperature/humidity/CO2",
    "optionHumidity" : "Humidity",

    "modeBWTH" : "Wall Thermostat",
    "modeSWITCH" : "eSwitch actuator",

    "stringTableWaterFlow" : "Current flow",
    "stringTableWaterVolume" : "Total water volume",
    "stringTableWaterVolumeSinceOpen" : "Water volume since opening",

    "stringTableWaterFlowStatus" : "Status current flow",
    "stringTableWaterFlowOverflowFalse" : "Counter overflow: No",
    "stringTableWaterFlowOverflowTrue" : "Counter overflow: Yes",
    "stringTableWaterVolumeSinceOpenOverflowFalse" : "Counter overflow since opening: no",
    "stringTableWaterVolumeSinceOpenOverflowTrue" : "Counter overflow since opening: yes",

    "msgResetWaterCounter" : "Use this option to reset the total water volume counter to 0.00 L",

    "lblValve" : "Valve",
    "btnWaterOff" : "Closed",
    "btnWaterOn" : "Open",

    "stringTableErrorErrorFrostProtection" : "Frost protection malfunction",
    "stringTableErrorErrorFrostProtectionFalse" : "Frost protection malfunction: No",
    "stringTableErrorErrorFrostProtectionTrue" : "Frost protection malfunction: Yes",

    "stringTableErrorValveFailure" : "Valve malfunction",
    "stringTableErrorValveFailureFalse" : "Valve malfunction: No",
    "stringTableErrorValveFailureTrue" : "Valve malfunction: Yes",

    "stringTableErrorWaterFailure" : "Water flow problem",
    "stringTableErrorWaterFailureFalse" : "Water flow problem: No",
    "stringTableErrorWaterFailureTrue" : "Water flow problem: Yes",

    "stringTableValveStateErrorPosition" : "Valve in error position",
    "stringTableValveStateErrorPositionFalse" : "Valve in error position: No",
    "stringTableValveStateErrorPositionTrue" : "Valve in error position: Yes",
    "stringTableValveStateTooTight" : "Valve sluggish/blocked",
    "stringTableValveStateTooTightFalse" : "Valve sluggish/blocked: No",
    "stringTableValveStateTooTightTrue" : "Valve sluggish/blocked: Yes",
    "stringTableValveStateAdjTooBig" : "Valve positioning range too large",
    "stringTableValveStateAdjTooBigFalse" : "Valve positioning range too large: No",
    "stringTableValveStateAdjTooBigTrue" : "Valve positioning range too large: Yes",
    "stringTableValveStateAdjTooSmall" : "Valve positioning range too small",
    "stringTableValveStateAdjTooSmallFalse" : "Valve positioning range too small: No",
    "stringTableValveStateAdjTooSmallTrue" : "Valve positioning range too small: Yes",

    "stringTableSoilMoistureTransmitterFilterSize" : "Filter size",
    "stringTableMeasurementInterval" : "Measurement interval",
    "stringTableMeasurementIntervalUnit" : "Unit measurement interval",
    "stringTableMeasurementIntervalValue" : "Value measurement interval",
    "stringTableRefMin0" : "Reference value 0% soil moisture",
    "stringTableRefMax100" : "Reference value 100% soil moisture",

    "stringTableSoilMoisture" : "Soil moisture",
    "stringTableSoilMoistureRaw" : "Raw value soil moisture",
    "stringTableSoilTemperature" : "Soil temperature",

    "hintAutomaticDeviceUpdate" : "The update is carried out automatically in the background.",

    "stringTableWeatherReceiverDataId" : "Picture ID",
    "optionPictureID" : "ID&nbsp;",

    "optionAutoDetection" : "Automatic detection",
    "optionTrailingEdge" : "Trailing edge",
    "optionLeadingEdge" : "Leading edge",

    "comment" : "Release A/2026",

    "lblDoorLockDirection" : "Direction of turning for closing ",
    "lblDoorEndStopOffsetLocked" : "Angle from neutral unlocked to closed",
    "lblDoorEndStopOffsetOpen" : "Angle from neutral unlocked to open",
    "lblDoorLockTurns" : "Turns from unlocked to locked",
    "lblDoorLockNeutralPos" : "Neutral key position",
    "lblDoorOpeningDirection" : "Opening direction",

    "lblAutomaticLock" : "Automatic locking",

    "optionIgnoreDoorOpen" : "Ignore door status",
    "optionSkipHoldTimeOpening" : "Skip door latch hold time",
    "optionSkipRelockDelayClosing" : "Skip Auto-Relock Delay",
    "optionSkipHoldTimeOpeningRelockDelayClosing" : "Skip door latch hold time and Auto-Relock Delay",

    "optionInwards" : "Inward",
    "optionOutwards" : "Outward",

    "btnAutoRelockOff" : "Auto-Relock off",
    "btnAutoRelockOn" : "Auto-Relock on",

    "dialogSetDLPTargetLevelTitle" : "Pairing the door lock",

    "stringTableLoadTooLow" : "Load too low",
    "stringTableNoEndStopLock" : "No end stop lock",
    "stringTableNoEndStopUnLock" : "No end stop unLock",

    "stringTableLockState" : "Lock status",
    "stringTableLockStateReason" : "Trigger",

    "stringTableLockTeachInState" : "Status pairing process door lock",

    "neutralPositionLockedSet" : "Neutal position locked marked",
    "neutralPositionUnlockedSet" : "Neutal position unlocked marked",
    "neutralPositionBothSet" : "Both neutral positions marked, ready for calibration drive",
    "teachInDriveRunning" : "Calibration drive ongoing",
    "teachInSuccessful" : "Pairing process door lock successfully  completed",
    "errorNeutralPositionIncomplete" : "Neutral position error: no integer turns between locked and unlocked",
    "errorNeutralPositionLessOneTurn" : "Neutral position erorr: less than 1 turn between locked and unlocked",
    "errorEndStopDriveLockBeforeNeutralPosition" : "calibration drive error: end stop lock before neutral position locked",
    "errorEndStopDriveUnlockBeforeNeutralPosition" : "calibration drive error: end stop open before neutral position unlocked",
    "errorTeachInDriveCanceled" : "Cancellation by another command/event",
    "errorTeachInDriveBatteryLow" : "Low batteries",
    "teachInError" : "Error pairing process door lock: other",

    "stringTableLastLockDriveLoad" : "Pre-load of the last closing movement",

    "dlpLockState_0" : "unknown",
    "dlpLockState_1" : "locked",
    "dlpLockState_2" : "unlocked",
    "dlpLockState_3" : "invalid",

    "dlpLockStateReason_0" : "unknown",
    "dlpLockStateReason_1" : "motorised",
//        "dlpLockStateReason_2" : "en* Motorisch, durch interne Taste",
//        "dlpLockStateReason_3" : "en* Motorisch, durch Wochenprogramm",
//        "dlpLockStateReason_4" : "en* Motorisch, durch Auto-Relock nach Timeout",
//        "dlpLockStateReason_5" : "en* Motorisch, durch Auto-Relock nach T%FCrzustands%E4nderung",
    "dlpLockStateReason_2" : "motorised, after open, ACKed (no new open event)",
    "dlpLockStateReason_3" : "motorized after open",
//        "dlpLockStateReason_8" : "Motorisch nach Open durch interne Taste",
    "dlpLockStateReason_4" : "manual, from outside",
    "dlpLockStateReason_5" : "manual, from inside",
    "dlpLockStateReason_6" : "manual",

    "dlpLockTeachInState_0" : "Pairing process door lock inactive",
    //  "dlpLockTeachInState_1" : "en* Neutralstellung Verriegelt vorgemerkt",
    //  "dlpLockTeachInState_2" : "en* Neutralstellung Entriegelt vorgemerkt",
    //  "dlpLockTeachInState_3" : "en* beide Neutralstellungen vorgemerkt, bereit f%FCr Endanschlagsfahrt",
    "dlpLockTeachInState_1" : "Calibration drive in progress",
    "dlpLockTeachInState_2" : "Pairing process door lock successfully completed (no parameter transmission)",
    //  "dlpLockTeachInState_6" : "en* Neutralstellungen Fehler: ganzzahliges Vielfaches von 360° zwischen Ver- und Entriegelt",
    "dlpLockTeachInState_3" : "Neutral position error: less than 1 turn between locked und unlocked",
    //  "dlpLockTeachInState_8" : "en* Endanschlagsfahrt Fehler: Endanschlag lock vor Neutralstellung Verriegelt",
    //  "dlpLockTeachInState_9" : "en* Endanschlagsfahrt Fehler: Endanschlag open vor Neutralstellung Entriegelt",
    "dlpLockTeachInState_4" : "Calibration drive error: Aborted by another command/event",
    "dlpLockTeachInState_5" : "Calibration drive error: Batteries low",
    "dlpLockTeachInState_6" : "Pairing process door lock error: other",

    "stringTableErrorDoorLockedWhileOpen" : "Locked with door open",
    "stringTableErrorDoorOpenedWhileLocked" : "Door opened while locked",
    "stringTableSabotageAcceleration" : "Sabotage acceleration sensor",
    "stringTableSabotageBattery" : "Sabotage battery",
    "stringTableSabotageMagneticField" : "Sabotage magnetic sensors",
    "stringTableSabotageVertical" : "Sabotage tilt sensor",

    "stringTableDoorStateTransceiverCalibrate" : "Calibrate",

    "stringTableDoorLockStateTransceiverLockTargetLevelResetTeachIn" : "Reset pairing process door lock",
    "stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralLocked" : "Mark as neutral position locked",
    "stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralUnlocked" : "Mark as neutral position unlocked",
    "stringTableDoorLockStateTransceiverLockTargetLevelTestrunSaveLockUnlock" : "Check end positions (drive: lock, open) and save as configuration",

    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralUnlocked" : "Start configuration drive with door open (unlocked) \\nand lock in neutral position",

    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralVertical" : "Start configuration drive with door open (unlocked) \\nand lock with vertical neutral position",

    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralHorizontal" : "Start configuration drive with door open (unlocked) \\nand lock with horizontal neutral position",

    "stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationClosedDoor" : "Pairing the pre-load with the door closed (unlocked)",
    "stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationOpenDoor" : "Pairing the pre-load with the door open (unlocked)",

    "stringTableAutoRelockState" : "Auto-Relock active",

    "optionPermission" : "Permission",
    "optionDoorLock" : "Door lock",
    "optionAutoRelock" : "Auto-Relock",

    "optionLocked" : "Locked",
    "optionUnlocked" : "Unlocked",

    "lblDoorClosed" : "Door closed",
    "lblDoorOpen" : "Door open",

    "btnTeachInDoorLock" : "Pairing door lock",
    "btnInfo" : "Info",

    "lblSabotage_A" : "Sabotage detection",
    "lblEventDelay_A" : "Message delay for position detection",

    "lblEventTimeOut_DLP" : "Reporting duration in case of vibration",

    "lblTriggerAngle_DLP" : "Position tolerance",

    "lblEventFilterPeriodB1" : "Messages for ",
    "lblEventFilterPeriodB2" : "vibration within ",

    "optionPositionControl" : "Position monitoring",
    "optionVibrationControl" : "Vibration monitoring",
    "optionPositionVibrationControl" : "Position and vibration monitoring",
    "lblDeviceSensorSensibility_DLP" : "Vibration sensitivity",
    "triggerAngleDLP" : "Position tolerance",

    "stringTableEventFilterNumberDLP_A" : "Message for",
    "stringTableEventFilterNumberDLP_B" : "vibrations",

    "lblSensorSensibility_A" : "Pre-load sensitivity",

    "optionAutoCalibration" : "Automatic calibration",
    "optionDriftCompensationOn" : "Active with drift compensation",
    "optionDriftCompensationAndCalibrationOn" : "Active with drift compensation and calibration after pre-load detection",
    "lblTableDeviceMagnetSensibility" : "Magnetic field sensitivity",

    "lblSensorVoltage" : "Operating voltage",
    "optionSensorVoltage_3_3" : "3.3V",
    "optionSensorVoltage_5" : "5.0V",
    "lblFilterSelect" : "Filter",
    "optionFilterSelectCurrent" : "Instantaneous value",
    "optionSensoSelectMin" : "Minimum value",
    "optionSensoSelectMax" : "Maximum value",
    "optionSensoSelectAverage" : "Average value",
    "optionSensoSelectAverageWoExtrema" : "Average value excluding extremes",
    "lblSensorReferenceHeight" : "Reference height",
    "lblHeight" : "Height",
    "lblDistance" : "Distance",

    "optionSensitive" : "Sensitive",

    "stringTableErrorObstacleFalse": "No obstacle detected",
    "stringTableErrorObstacleTrue": "Obstacle detected",

    "lblDewPointControl" : "Dew point control",
    "lblDewPointTemp" : "Dew point temperature",

    "lblSpeedSeclect_1" : "Speed for externally triggered drive",
    "lblSpeedSeclect_2" : "Speed for self-triggered drive",

    "noMoreKeys" : ""
  }
});

/*
langJSON.en.helpLockTargetLevel_A = "A = " + langJSON.en.lblLock + "<br/>";
langJSON.en.helpLockTargetLevel_B = "B = " + langJSON.en.lblUnlock + "<br/>";
langJSON.en.helpLockTargetLevel_C = "C = " + langJSON.en.lblOpen + "<br/>";
langJSON.en.helpLockTargetLevel_D = "D = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelResetTeachIn + "<br/>";
langJSON.en.helpLockTargetLevel_E = "E = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralLocked + "<br/>";
langJSON.en.helpLockTargetLevel_F = "F = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralUnlocked + "<br/>";
langJSON.en.helpLockTargetLevel_G = "G = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelTestrunSaveLockUnlock + "<br/>";
*/
langJSON.en.helpLockTargetLevel_H = "A = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralUnlocked + "<br/>";
langJSON.en.helpLockTargetLevel_I = "B = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralVertical + "<br/>";
langJSON.en.helpLockTargetLevel_J = "C = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralHorizontal + "<br/>";
//langJSON.en.helpLockTargetLevel_K = "D = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationClosedDoor + "<br/>";
langJSON.en.helpLockTargetLevel_L = "E = " + langJSON.en.stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationOpenDoor;

langJSON.en.helpLockTargetLevel =
  /*
  langJSON.en.helpLockTargetLevel_A +
  langJSON.en.helpLockTargetLevel_B +
  langJSON.en.helpLockTargetLevel_C +
  langJSON.en.helpLockTargetLevel_D +
  langJSON.en.helpLockTargetLevel_E +
  langJSON.en.helpLockTargetLevel_F +
  langJSON.en.helpLockTargetLevel_G +
  */
  langJSON.en.helpLockTargetLevel_H +
  langJSON.en.helpLockTargetLevel_I +
  langJSON.en.helpLockTargetLevel_J +
//  langJSON.en.helpLockTargetLevel_K ;
  langJSON.en.helpLockTargetLevel_L;