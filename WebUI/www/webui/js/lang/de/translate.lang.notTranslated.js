// ä=%E4 ö=%F6 ü=%FC Ä=%C4 Ö=%D6 Ü=%DC ß=%DF

jQuery.extend(true, langJSON, {
  "de": {
    "lblCampfire" : "Lagerfeuer",
    "lblRainbow" : "Regenbogen",
    "lblSunrise" : "Sonnenaufgang",
    "lblSunset" : "Sonnenuntergang",
    "lblWaterfall" : "Wasserfall",
    "lblForest" : "Wald",
    "lblEffect7" : "Effekt 7",
    "lblEffect8" : "Effekt 8",
    "lblRedFlashing" : "rotes Blinken",
    "lblGreenWobble" : "gr%FCnes Wabern",

    "lblDisplayModeETRV" : "Displaymodus",
    "optionReducedMode" : "Reduzierter Modus",
    "optionFunctionalMode" : "Funktioneller Modus",

    "lblDisplayColor" : "Displayfarbe",
    "optionNormalColors" : "Normal",
    "optionInvertedColors" : "Invertiert",

    "optionAllowed" : "Berechtigt",
    "optionNotAllowed" : "Nicht berechtigt",

    "lblPermission" : "Berechtigung",

    "stringTablePermissionStateFalse" : "Kanal nicht berechtigt",
    "stringTablePermissionStateTrue" : "Kanal berechtigt",

    "lblAngle" : "Winkel",

    "lblInfoStatusControlDeviceFeedIn" : "Einspeisung Z%E4hler Ger%E4t",
    "lblInfoStatusControlFeedInCounter" : "Einspeisung Z%E4hler CCU",

    "hintHeatingCoolngNotAllowed" :
      "Die Anzeigefelder Heizen / K%FChlen zeigen den aktuell eingestellten Modus an.<br/><br/>" +
      "Ist <b><u>keine</u></b> Verkn%FCpfung zwischen einem HmIP Wandthermostaten und einem HmIP Fu%DFbodenheizungscontroller vorhanden, " +
      "l%E4%DFt sich der Modus hiermit aktiv wechseln.<br/><br/>" +
      "<b>In Heizungsgruppen dienen die beiden Felder nur zur Anzeige des eingestellten Modus. " +
      "Hier ist ein Wechsel nicht m%F6glich.</b>",

    "stringTableAbsoluteAngleStatus" : "Status",

    "stringTableAltitude" : "H%F6he %FCber NN",
    "stringTableAirPressure" : "Luftdruck",
    "lblMeter" : "Meter",

    "optionOneBtn" : "1 Taster",
    "optionTwoBtnLeftRRight" : "2 Taster links/rechts",
    "optionTwoBtnUpDDown" : "2 Taster oben/unten",
    "optionFourBtn" : "4 Taster",

    "lblHeaderFeedbackLevelMode" : "Feedback Helligkeit (Helligkeit der bet%E4tigten Taste)",
    "lblFeedbackLevelMode" : "Feedback Mode",
    "lblFeedbackLevelValue" : "Level Feedback",

    "lblHeaderActivateLevelMode" : "Aktive Helligkeit",

    "lblActivateLevelMode" : "Level Mode",
    "lblActivateLevelValue" : "Level aktive Helligkeit",
    "optionAbsolut" : "Absolut",
    "optionRelativ" : "Relativ",

    "stringTableActivateLevelOnTime" : "Einheit Einschaltdauer",

    "stringTableErrorTempSensor": "Fehler Temperatursensor",
    "stringTableErrorTempSensorFalse" : "Temperatursensor Ok",
    "stringTableErrorTempSensorTrue" : "Temperatursensor nicht Ok",

    "stringTableErrorTempSensor2" : "Fehler Temperatursensor 2",
    "stringTableErrorTempSensor2False" : "Temperatursensor 2 Ok",
    "stringTableErrorTempSensor2True" : "Temperatursensor 2 nicht Ok",

    "lblDisplayLayoutMode" : "Anzeigelayout",

    "hintPrgExists_WGT" : "Es besteht mindestens ein Programm. Daher ist die Umschaltung des Modus (Kanal 4) gesperrt.",
    "hintLinkExists_WGT" : "Es besteht mindestens eine Verkn%FCpfung. Daher ist die Umschaltung des Modus (Kanal 4) gesperrt.",

    "optionActual" : "Aktuelle Temperatur",
    "optionSetpoint" : "Solltemperatur",
    "optionActualHumidity" : "Aktuelle Temperatur / Feuchtigkeit",
    "optionCO2" : "CO2",
    "optionActualHumidityCO2" : "Aktuelle Temperatur / Feuchtigkeit / CO2",
    "optionHumidity" : "Feuchtigkeit",

    "modeBWTH" : "Wandthermostat",
    "modeSWITCH" : "Schaltaktor",

    "stringTableWaterFlow" : "Momentaner Durchfluss",
    "stringTableWaterVolume" : "Gesamt-Wassermenge",
    "stringTableWaterVolumeSinceOpen" : "Wassermenge seit %D6ffnung",

    "stringTableWaterFlowStatus" : "Status momentaner Durchfluss",
    "stringTableWaterFlowOverflowFalse" : "Z%E4hler-%DCberlauf: Nein",
    "stringTableWaterFlowOverflowTrue" : "Z%E4hler-%DCberlauf: Ja",
    "stringTableWaterVolumeSinceOpenOverflowFalse" : "Z%E4hler-%DCberlauf seit %D6ffnung: Nein",
    "stringTableWaterVolumeSinceOpenOverflowTrue" : "Z%E4hler-%DCberlauf seit %D6ffnung: Ja",

    "msgResetWaterCounter" : "Hiermit setzten Sie den Z%E4hler der Gesamt-Wassermenge zur%FCck auf 0.00 L",

    "lblValve" : "Ventil",
    "btnWaterOff" : "Geschlossen",
    "btnWaterOn" : "Ge%F6ffnet",

    "stringTableErrorErrorFrostProtection" : "Frostschutz-Fehlfunktion",
    "stringTableErrorErrorFrostProtectionFalse" : "Frostschutz-Fehlfunktion: Nein",
    "stringTableErrorErrorFrostProtectionTrue" : "Frostschutz-Fehlfunktion: Ja",

    "stringTableErrorValveFailure" : "Ventil-Fehlfunktion",
    "stringTableErrorValveFailureFalse" : "Ventil-Fehlfunktion: Nein",
    "stringTableErrorValveFailureTrue" : "Ventil-Fehlfunktion: Ja",

    "stringTableErrorWaterFailure" : "Problem Wasserdurchfluss",
    "stringTableErrorWaterFailureFalse" : "Problem Wasserdurchfluss: Nein",
    "stringTableErrorWaterFailureTrue" : "Problem Wasserdurchfluss: Ja",

    "stringTableValveStateErrorPosition" : "Ventil in Fehlerposition",
    "stringTableValveStateErrorPositionFalse" : "Ventil in Fehlerposition: Nein",
    "stringTableValveStateErrorPositionTrue" : "Ventil in Fehlerposition: Ja",
    "stringTableValveStateTooTight" : "Ventil schwerg%E4ngig / Ventil klemmt",
    "stringTableValveStateTooTightFalse" : "Ventil schwerg%E4ngig / Ventil klemmt: Nein",
    "stringTableValveStateTooTightTrue" : "Ventil schwerg%E4ngig / Ventil klemmt: Ja",
    "stringTableValveStateAdjTooBig" : "Ventilstellbereich zu gro%DF",
    "stringTableValveStateAdjTooBigFalse" : "Ventilstellbereich zu gro%DF: Nein",
    "stringTableValveStateAdjTooBigTrue" : "Ventilstellbereich zu gro%DF: Ja",
    "stringTableValveStateAdjTooSmall" : "Ventilstellbereich zu klein",
    "stringTableValveStateAdjTooSmallFalse" : "Ventilstellbereich zu klein: Nein",
    "stringTableValveStateAdjTooSmallTrue" : "Ventilstellbereich zu klein: Ja",

    "stringTableSoilMoistureTransmitterFilterSize" : "Filtergr%F6%DFe",
    "stringTableMeasurementInterval" : "Messintervall",
    "stringTableMeasurementIntervalUnit" : "Einheit Messintervall",
    "stringTableMeasurementIntervalValue" : "Wert des Messintervalls",
    "stringTableRefMin0" : "Referenzwert 0 % Bodenfeuchte",
    "stringTableRefMax100" : "Referenzwert 100 % Bodenfeuchte",

    "stringTableSoilMoisture" : "Bodenfeuchte",
    "stringTableSoilMoistureRaw" : "Rohwert Bodenfeuchte",
    "stringTableSoilTemperature" : "Bodentemperatur",

    "hintAutomaticDeviceUpdate" : "Das Update wird automatisch im Hintergrund durchgef%FChrt.",

    "stringTableWeatherReceiverDataId" : "Bild ID",
    "optionPictureID" : "ID&nbsp;",

    "optionAutoDetection" : "Automatische Erkennung",
    "optionTrailingEdge" : "Phasenabschnitt",
    "optionLeadingEdge" : "Phasenanschnitt",

    "comment" : "Release A/2026",

    "lblDoorLockDirection" : "Drehrichtung zum Verschlie%DFen",
    "lblDoorEndStopOffsetLocked" : "Winkel von neutral unverschlossen nach geschlossen",
    "lblDoorEndStopOffsetOpen" : "Winkel von neutral unverschlossen nach offen",
    "lblDoorLockTurns" : "Umdrehungen von unverschlossen nach verschlossen",
    "lblDoorLockNeutralPos" : "Neutrale Schl%FCsselposition",
    "lblDoorOpeningDirection" : "%D6ffnungsrichtung",

    "lblAutomaticLock" : "Reaktion auf T%FCrzustandssensor",

    "optionIgnoreDoorOpen" : "T%FCrzustand ignorieren",
    "optionSkipHoldTimeOpening" : "Fallen-Haltezeit %FCberspringen",
    "optionSkipRelockDelayClosing" : "Auto-Relock-Delay %FCberspringen",
    "optionSkipHoldTimeOpeningRelockDelayClosing" : "Fallen-Haltezeit und Auto-Relock-Delay %FCberspringen ",

    "optionInwards" : "nach innen",
    "optionOutwards" : "nach au%DFen",

    "btnAutoRelockOff" : "Auto-Relock Aus",
    "btnAutoRelockOn" : "Auto-Relock Ein",

    "dialogSetDLPTargetLevelTitle" : "T%FCrschloss anlernen",

    "stringTableLoadTooLow" : "LoadTooLow",
    "stringTableNoEndStopLock" : "NoEndStopLock",
    "stringTableNoEndStopUnLock" : "NoEndStopUnLock",

    "stringTableLockState" : "Schlosszustand",
    "stringTableLockStateReason" : "Ausl%F6ser",

    "stringTableLockTeachInState" : "Status Anlernprozess T%FCrschloss",

    "neutralPositionLockedSet" : "Neutralstellung Verriegelt vorgemerkt",
    "neutralPositionUnlockedSet" : "Neutralstellung Entriegelt vorgemerkt",
    "neutralPositionBothSet" : "beide Neutralstellungen vorgemerkt, bereit f%FCr Anlernfahrt",
    "teachInDriveRunning" : "Anlernfahrt l%E4uft",
    "teachInSuccessful" : "Anlernprozess T%FCrschloss erfolgreich abgeschlossen.",
    "errorNeutralPositionIncomplete" : "Neutralstellungen Fehler: keine ganzzahligen Umdrehungen zwischen Ver- und Entriegelt",
    "errorNeutralPositionLessOneTurn" : "Neutralstellungen Fehler: weniger als 1 Umdrehung zwischen Ver- und Entriegelt",
    "errorEndStopDriveLockBeforeNeutralPosition" : "Anlernfahrt Fehler: Endanschlag lock vor Neutralstellung Verriegelt",
    "errorEndStopDriveUnlockBeforeNeutralPosition" : "Anlernfahrt Fehler: Endanschlag open vor Neutralstellung Entriegelt",
    "errorTeachInDriveCanceled" : "Abbruch durch anderes Kommando / Ereignis",
    "errorTeachInDriveBatteryLow" : "Batterien zu schwach",
    "teachInError" : "Anlernprozess T%FCrschloss Fehler: sonstige",

    "stringTableLastLockDriveLoad" : "Schlosslast der letzten Schlie%DFfahrt",

    "dlpLockState_0" : "unbekannt",
    "dlpLockState_1" : "verriegelt",
    "dlpLockState_2" : "entriegelt",
    "dlpLockState_3" : "ung%FCltig",

    "dlpLockStateReason_0" : "unbekannt",
    "dlpLockStateReason_1" : "Motorisch",
//        "dlpLockStateReason_2" : "Motorisch, durch interne Taste",
//        "dlpLockStateReason_3" : "Motorisch, durch Wochenprogramm",
//        "dlpLockStateReason_4" : "Motorisch, durch Auto-Relock nach Timeout",
//        "dlpLockStateReason_5" : "Motorisch, durch Auto-Relock nach T%FCrzustands%E4nderung",
    "dlpLockStateReason_2" : "Motorisch, nach Open, ACKed (kein neues Open-Ereignis)",
    "dlpLockStateReason_3" : "Motorisch nach Open",
//        "dlpLockStateReason_8" : "Motorisch nach Open durch interne Taste",
    "dlpLockStateReason_4" : "Manuell, von au%DFen",
    "dlpLockStateReason_5" : "Manuell, von innen",
    "dlpLockStateReason_6" : "Manuell",

    "dlpLockTeachInState_0" : "Anlernprozess T%FCrschloss nicht aktiv",
    //  "dlpLockTeachInState_1" : "Neutralstellung Verriegelt vorgemerkt",
    //  "dlpLockTeachInState_2" : "Neutralstellung Entriegelt vorgemerkt",
    //  "dlpLockTeachInState_3" : "beide Neutralstellungen vorgemerkt, bereit f%FCr Endanschlagsfahrt",
    "dlpLockTeachInState_1" : "Anlernfahrt l%E4uft",
    "dlpLockTeachInState_2" : "T%FCrschloss-Anlern-Prozedur erfolgreich abgeschlossen (keine Aussage %FCber Parameter-%DCbertragung)",
    //  "dlpLockTeachInState_6" : "Neutralstellungen Fehler: ganzzahliges Vielfaches von 360° zwischen Ver- und Entriegelt",
    "dlpLockTeachInState_3" : "Neutralstellungen Fehler: weniger als 1 Umdrehung zwischen Ver- und Entriegelt",
    //  "dlpLockTeachInState_8" : "Endanschlagsfahrt Fehler: Endanschlag lock vor Neutralstellung Verriegelt",
    //  "dlpLockTeachInState_9" : "Endanschlagsfahrt Fehler: Endanschlag open vor Neutralstellung Entriegelt",
    "dlpLockTeachInState_4" : "Anlernfahrt Fehler: Abbruch durch anderes Kommando / Ereignis",
    "dlpLockTeachInState_5" : "Anlernfahrt Fehler: Batterien zu schwach",
    "dlpLockTeachInState_6" : "T%FCrschloss-Anlern-Prozedur Fehler: sonstige",

    "stringTableErrorDoorLockedWhileOpen" : "Verschlossen bei offener T%FCr",
    "stringTableErrorDoorOpenedWhileLocked" : "T%FCr im verschlossenem Zustand ge%F6ffnet",
    "stringTableSabotageAcceleration" : "Sabotage Beschleunigungssensor",
    "stringTableSabotageBattery" : "Sabotage Batterie",
    "stringTableSabotageMagneticField" : "Sabotage Magnetsensor",
    "stringTableSabotageVertical" : "Sabotage Tilt-Sensor",

    "stringTableDoorStateTransceiverCalibrate" : "Kalibrieren",

    "stringTableDoorLockStateTransceiverLockTargetLevelResetTeachIn" : "T%FCrschloss-Anlern-Prozedur zur%FCcksetzen",
    "stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralLocked" : "Vormerken als Neutralstellung Verriegelt",
    "stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralUnlocked" : "Vormerken als Neutralstellung Entriegelt",
    "stringTableDoorLockStateTransceiverLockTargetLevelTestrunSaveLockUnlock" : "Endanschl%E4ge pr%FCfen (Fahrt: lock, open) und als Konfiguration speichern",

    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralUnlocked" : "Anlernfahrt starten bei ge%F6ffneter T%FCr (entriegelt)\n" +
      "und Schloss aktuell in Neutralstellung",
    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralVertical" : "Anlernfahrt  starten bei ge%F6ffneter T%FCr (entriegelt)\n" +
      "und Schloss mit Neutralstellung vertikal",
    "stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralHorizontal" : "Anlernfahrt starten bei ge%F6ffneter T%FCr (entriegelt)\n" +
      "und Schloss mit Neutralstellung horizontal",
    "stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationClosedDoor" : "Anlernen der Schlosslast bei geschlossener T%FCr (entriegelt)",
    "stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationOpenDoor" : "Anlernen der Schlosslast bei ge%F6ffneter T%FCr (entriegelt)",

    "stringTableAutoRelockState" : "Auto-Relock aktiv",

    "optionPermission" : "Berechtigung",
    "optionDoorLock" : "T%FCrschloss",
    "optionAutoRelock" : "Auto-Relock",

    "optionLocked" : "Verriegelt",
    "optionUnlocked" : "Entriegelt",

    "lblDoorClosed" : "T%FCr zu",
    "lblDoorOpen" : "T%FCr offen",

    "btnTeachInDoorLock" : "T%FCrschloss anlernen",
    "btnInfo" : "Info",

    "lblSabotage_A" : "Sabotage-Erkennung",
    "lblEventDelay_A" : "Meldeverz%F6gerung f%FCr Lageerkennung",

    "lblEventTimeOut_DLP" : "Meldedauer bei Ersch%FCtterung",

    "lblTriggerAngle_DLP" : "Lagetoleranz",

    "lblEventFilterPeriodB1" : "Meldungen bei ",
    "lblEventFilterPeriodB2" : "Ersch%FCtterungen innerhalb ",

    "optionPositionControl" : "Lage-%DCberwachung",
    "optionVibrationControl" : "Ersch%FCtterungs-%DCberwachung",
    "optionPositionVibrationControl" : "Lage- und Ersch%FCtterungs-%DCberwachung",
    "lblDeviceSensorSensibility_DLP" : "Ersch%FCtterungs-Empfindlichkeit",
    "triggerAngleDLP" : "Lagetoleranz",

    "stringTableEventFilterNumberDLP_A" : "Meldung bei",
    "stringTableEventFilterNumberDLP_B" : "Ersch%FCtterungen",

    "lblSensorSensibility_A" : "Schlosslast-Empfindlichkeit",

    "optionAutoCalibration" : "Automatische Kalibrierung",
    "optionDriftCompensationOn" : "Aktiv",
    "optionDriftCompensationAndCalibrationOn" : "Aktiv mit Kalibrierung nach Schlosslast-Erkennung",
    "lblTableDeviceMagnetSensibility" : "Magnetfeld-Empfindlichkeit",

    "lblSensorVoltage" : "Betriebsspannung",
    "optionSensorVoltage_3_3" : "3.3V",
    "optionSensorVoltage_5" : "5.0V",
    "lblFilterSelect" : "Filter",
    "optionFilterSelectCurrent" : "Momentanwert",
    "optionSensoSelectMin" : "Minimaler Wert",
    "optionSensoSelectMax" : "Maximaler Wert",
    "optionSensoSelectAverage" : "Durchschnittswert",
    "optionSensoSelectAverageWoExtrema" : "Durchschnittswert ohne Extreme",
    "lblSensorReferenceHeight" : "Referenzh%F6he",
    "lblHeight" : "H%F6he",
    "lblDistance" : "Distanz",

    "optionSensitive" : "Empfindlich",

    "stringTableErrorObstacleFalse": "Kein Hindernis erkannt",
    "stringTableErrorObstacleTrue": "Hindernis erkannt",

    "lblDewPointControl" : "Taupunktkontrolle",
    "lblDewPointTemp" : "Taupunkttemperatur",

    "lblSpeedSeclect_1" : "Geschwindigkeit f%FCr fremdausgel%F6ste Fahrten",
    "lblSpeedSeclect_2" : "Geschwindigkeit f%FCr selbstausgel%F6ste Fahrten",

    "noMoreKeys" : ""
  }
});

/*
langJSON.de.helpLockTargetLevel_A = "A = " + langJSON.de.lblLock + "<br/>";
langJSON.de.helpLockTargetLevel_B = "B = " + langJSON.de.lblUnlock + "<br/>";
langJSON.de.helpLockTargetLevel_C = "C = " + langJSON.de.lblOpen + "<br/>";
langJSON.de.helpLockTargetLevel_D = "D = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelResetTeachIn + "<br/>";
langJSON.de.helpLockTargetLevel_E = "E = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralLocked + "<br/>";
langJSON.de.helpLockTargetLevel_F = "F = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelSetNeutralUnlocked + "<br/>";
langJSON.de.helpLockTargetLevel_G = "G = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelTestrunSaveLockUnlock + "<br/>";
*/
langJSON.de.helpLockTargetLevel_H = "A = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralUnlocked + "<br/>";
langJSON.de.helpLockTargetLevel_I = "B = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralVertical + "<br/>";
langJSON.de.helpLockTargetLevel_J = "C = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelTeachInDriveOpenDoorNeutralHorizontal + "<br/>";
//langJSON.de.helpLockTargetLevel_K = "D = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationClosedDoor + "<br/>";
langJSON.de.helpLockTargetLevel_L = "D = " + langJSON.de.stringTableDoorLockStateTransceiverLockTargetLevelLoadCalibrationOpenDoor;

langJSON.de.helpLockTargetLevel =
  /*
  langJSON.de.helpLockTargetLevel_A +
  langJSON.de.helpLockTargetLevel_B +
  langJSON.de.helpLockTargetLevel_C +
  langJSON.de.helpLockTargetLevel_D +
  langJSON.de.helpLockTargetLevel_E +
  langJSON.de.helpLockTargetLevel_F +
  langJSON.de.helpLockTargetLevel_G +
  */
  langJSON.de.helpLockTargetLevel_H +
  langJSON.de.helpLockTargetLevel_I +
  langJSON.de.helpLockTargetLevel_J +
//  langJSON.de.helpLockTargetLevel_K;
  langJSON.de.helpLockTargetLevel_L;


