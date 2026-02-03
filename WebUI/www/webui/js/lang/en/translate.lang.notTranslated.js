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

    "comment" : "Release A/2026 not yet translated",

    "lblDoorLockDirection" : "en* Drehrichtung zum Verschlie%DFen",
    "lblDoorEndStopOffsetLocked" : "en* Winkel von neutral unverschlossen nach geschlossen",
    "lblDoorEndStopOffsetOpen" : "en* Winkel von neutral unverschlossen nach offen",
    "lblDoorLockTurns" : "en* Umdrehungen von unverschlossen nach verschlossen",
    "lblDoorLockNeutralPos" : "en* Neutrale Schl%FCsselposition",
    "lblDoorOpeningDirection" : "en* %D6ffnungsrichtung",

    "lblAutomaticLock" : "en* Automatisches Verriegeln",

    "optionIgnoreDoorOpen" : "en* T%FCrzustand ignorieren",
    "optionSkipHoldTimeOpening" : "en* Fallen-Haltezeit %FCberspringen",
    "optionSkipRelockDelayClosing" : "en* Auto-Relock-Delay %FCberspringen",
    "optionSkipHoldTimeOpeningRelockDelayClosing" : "en* Fallen-Haltezeit und Auto-Relock-Delay %FCberspringen ",

    "optionInwards" : "en* nach innen",
    "optionOutwards" : "en* nach au%DFen",

    "btnAutoRelockOff" : "en* Auto-Relock Aus",
    "btnAutoRelockOn" : "en* Auto-Relock Ein",

    "dialogSetDLPTargetLevelTitle" : "en* T%FCrschloss anlernen",

    "stringTableLoadTooLow" : "en* LoadTooLow",
    "stringTableNoEndStopLock" : "en* NoEndStopLock",
    "stringTableNoEndStopUnLock" : "en* NoEndStopUnLock",

    "stringTableLockState" : "Schlosszustand",
    "stringTableLockStateReason" : "en* Ausl%F6ser",

    "stringTableLockTeachInState" : "en* Status der T%FCrschloss-Anlern-Prozedur",

    "neutralPositionLockedSet" : "en* Neutralstellung Verriegelt vorgemerkt",
    "neutralPositionUnlockedSet" : "en* Neutralstellung Entriegelt vorgemerkt",
    "neutralPositionBothSet" : "en* beide Neutralstellungen vorgemerkt, bereit f%FCr Anlernfahrt",
    "teachInDriveRunning" : "en* Anlernfahrt l%E4uft",
    "teachInSuccessful" : "en* T%FCrschloss-Anlern-Prozedur erfolgreich abgeschlossen",
    "errorNeutralPositionIncomplete" : "en* Neutralstellungen Fehler: keine ganzzahligen Umdrehungen zwischen Ver- und Entriegelt",
    "errorNeutralPositionLessOneTurn" : "en* Neutralstellungen Fehler: weniger als 1 Umdrehung zwischen Ver- und Entriegelt",
    "errorEndStopDriveLockBeforeNeutralPosition" : "en* Anlernfahrt Fehler: Endanschlag lock vor Neutralstellung Verriegelt",
    "errorEndStopDriveUnlockBeforeNeutralPosition" : "en* Anlernfahrt Fehler: Endanschlag open vor Neutralstellung Entriegelt",
    "errorTeachInDriveCanceled" : "en* Abbruch durch anderes Kommando / Ereignis",
    "errorTeachInDriveBatteryLow" : "en* Batterien zu schwach",
    "teachInError" : "en* T%FCrschloss-Anlern-Prozedur Fehler: sonstige",

    "stringTableLastLockDriveLoad" : "en* Schlosslast der letzten Schlie%DFfahrt",

    "dlpLockState_0" : "en* unbekannt",
    "dlpLockState_1" : "en* verriegelt",
    "dlpLockState_2" : "en* entriegelt",
    "dlpLockState_3" : "en* ung%FCltig",

    "dlpLockStateReason_0" : "en* unbekannt",
    "dlpLockStateReason_1" : "en* Motorisch",
//        "dlpLockStateReason_2" : "en* Motorisch, durch interne Taste",
//        "dlpLockStateReason_3" : "en* Motorisch, durch Wochenprogramm",
//        "dlpLockStateReason_4" : "en* Motorisch, durch Auto-Relock nach Timeout",
//        "dlpLockStateReason_5" : "en* Motorisch, durch Auto-Relock nach T%FCrzustands%E4nderung",
    "dlpLockStateReason_2" : "en* Motorisch, nach Open, ACKed (kein neues Open-Ereignis)",
    "dlpLockStateReason_3" : "en* Motorisch nach Open",
//        "dlpLockStateReason_8" : "Motorisch nach Open durch interne Taste",
    "dlpLockStateReason_4" : "en* Manuell, von au%DFen",
    "dlpLockStateReason_5" : "en* Manuell, von innen",
    "dlpLockStateReason_6" : "en* Manuell",

    "dlpLockTeachInState_0" : "en* T%FCrschloss-Anlern-Prozedur nicht (mehr) aktiv",
    //  "dlpLockTeachInState_1" : "en* Neutralstellung Verriegelt vorgemerkt",
    //  "dlpLockTeachInState_2" : "en* Neutralstellung Entriegelt vorgemerkt",
    //  "dlpLockTeachInState_3" : "en* beide Neutralstellungen vorgemerkt, bereit f%FCr Endanschlagsfahrt",
    "dlpLockTeachInState_1" : "en* Anlernfahrt l%E4uft",
    "dlpLockTeachInState_2" : "en* T%FCrschloss-Anlern-Prozedur erfolgreich abgeschlossen (keine Aussage %FCber Parameter-%DCbertragung)",
    //  "dlpLockTeachInState_6" : "en* Neutralstellungen Fehler: ganzzahliges Vielfaches von 360° zwischen Ver- und Entriegelt",
    "dlpLockTeachInState_3" : "en* Neutralstellungen Fehler: weniger als 1 Umdrehung zwischen Ver- und Entriegelt",
    //  "dlpLockTeachInState_8" : "en* Endanschlagsfahrt Fehler: Endanschlag lock vor Neutralstellung Verriegelt",
    //  "dlpLockTeachInState_9" : "en* Endanschlagsfahrt Fehler: Endanschlag open vor Neutralstellung Entriegelt",
    "dlpLockTeachInState_4" : "en* Anlernfahrt Fehler: Abbruch durch anderes Kommando / Ereignis",
    "dlpLockTeachInState_5" : "en* Anlernfahrt Fehler: Batterien zu schwach",
    "dlpLockTeachInState_6" : "en* T%FCrschloss-Anlern-Prozedur Fehler: sonstige",

    "stringTableErrorDoorLockedWhileOpen" : "en* Verschlossen bei offener T%FCr",
    "stringTableErrorDoorOpenedWhileLocked" : "en* T%FCr im verschlossenem Zustand ge%F6ffnet",
    "stringTableSabotageAcceleration" : "en* Sabotage Beschleunigungssensor",
    "stringTableSabotageBattery" : "en* Sabotage Batterie",
    "stringTableSabotageMagneticField" : "en* Sabotage Magnetsensor",
    "stringTableSabotageVertical" : "en* Sabotage Tilt-Sensor",

    "stringTableDoorStateTransceiverCalibrate" : "en* Kalibrieren",

    "stringTableDoorLockStateTransceiverLockTargetLevelResetTeachIn" : "en* T%FCrschloss-Anlern-Prozedur zur%FCcksetzen",
    "stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralLocked" : "en* Vormerken als Neutralstellung Verriegelt",
    "stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralUnlocked" : "en* Vormerken als Neutralstellung Entriegelt",
    "stringTableDoorLockStateTransceiverLockTargetLevelTestrunSaveLockUnlock" : "en* Endanschl%E4ge pr%FCfen (Fahrt: lock, open) und als Konfiguration speichern",

    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralUnlocked" : "en* Anlernfahrt starten bei ge%F6ffneter T%FCr (entriegelt)\n" +
      "und Schloss aktuell in Neutralstellung",
    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralVertical" : "en* Anlernfahrt  starten bei ge%F6ffneter T%FCr (entriegelt)\n" +
      "und Schloss mit Neutralstellung vertikal",
    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralHorizontal" : "en* Anlernfahrt starten bei ge%F6ffneter T%FCr (entriegelt)\n" +
      "und Schloss mit Neutralstellung horizontal",
    "stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationClosedDoor" : "en* Anlernen der Schlosslast bei geschlossener T%FCr (entriegelt)",
    "stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationOpenDoor" : "en* Anlernen der Schlosslast bei ge%F6ffneter T%FCr (entriegelt)",

    "stringTableAutoRelockState" : "en* Auto-Relock aktiv",

    "optionPermission" : "en* Berechtigung",
    "optionDoorLock" : "en* T%FCrschloss",
    "optionAutoRelock" : "en* Auto-Relock",

    "optionLocked" : "en* Verriegelt",
    "optionUnlocked" : "en* Entriegelt",

    "lblDoorClosed" : "en* T%FCr zu",
    "lblDoorOpen" : "en* T%FCr offen",

    "btnTeachInDoorLock" : "en* T%FCrschloss anlernen",
    "btnInfo" : "en* Info",

    "lblSabotage_A" : "en* Sabotage-Erkennung",
    "lblEventDelay_A" : "en* Meldeverz%F6gerung f%FCr Lageerkennung",

    "lblEventTimeOut_DLP" : "en* Meldedauer bei Ersch%FCtterung",

    "lblTriggerAngle_DLP" : "en* Lagetoleranz",

    "lblEventFilterPeriodB1" : "en* Meldungen bei ",
    "lblEventFilterPeriodB2" : "en* Ersch%FCtterungen innerhalb ",

    "optionPositionControl" : "en* Lage-%DCberwachung",
    "optionVibrationControl" : "en* Ersch%tterungs-%DCberwachung",
    "optionPositionVibrationControl" : "en* Lage- und Ersch%FCtterungs-%DCberwachung",
    "lblDeviceSensorSensibility_DLP" : "en* Ersch%FCtterungs-Empfindlichkeit",
    "triggerAngleDLP" : "en* Lagetoleranz",

    "stringTableEventFilterNumberDLP_A" : "en* Meldung bei",
    "stringTableEventFilterNumberDLP_B" : "en* Ersch%FCtterungen",

    "lblSensorSensibility_A" : "en* Schlosslast-Empfindlichkeit",

    "optionAutoCalibration" : "en* Automatische Kalibrierung",
    "optionDriftCompensationOn" : "en* Driftkompensation aktiv",
    "optionDriftCompensationAndCalibrationOn" : "en* Driftkompensation und Kalibrierung nach Schlosslasterkennung aktiv",
    "lblTableDeviceMagnetSensibility" : "en* Magnetfeld-Empfindlichkeit",

    "lblSensorVoltage" : "en* Betriebsspannung",
    "optionSensorVoltage_3_3" : "en* 3.3V",
    "optionSensorVoltage_5" : "en* 5.0V",
    "lblFilterSelect" : "en* Filter",
    "optionFilterSelectCurrent" : "en* Momentanwert",
    "optionSensoSelectMin" : "en* Minimaler Wert",
    "optionSensoSelectMax" : "en* Maximaler Wert",
    "optionSensoSelectAverage" : "en* Durchschnittswert",
    "optionSensoSelectAverageWoExtrema" : "en* Durchschnittswert ohne Extreme",
    "lblSensorReferenceHeight" : "en* Referenzh%F6he",
    "lblHeight" : "en* H%F6he",
    "lblDistance" : "en* Distanz",

    "optionSensitive" : "en* Empfindlich",

    "stringTableErrorObstacleFalse": "en* Kein Hindernis erkannt",
    "stringTableErrorObstacleTrue": "en* Hindernis erkannt",

    "lblDewPointControl" : "en* Taupunktkontrolle",
    "lblDewPointTemp" : "en* Taupunkttemperatur",

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