jQuery.extend(true,langJSON, {
  "en" : {
    "stringTableValveMaximumPosition" :          "maximum valve opening position",
    "stringTableRouterModuleEnabled" :           "Device serves as router",
    "lblLocation" :                              "Place of residence",
    "lblMode" :                                  "Mode",
    "dialogSetWPModeTitle" :                     "Set mode",
    "stringTableTimeBottomTopUnit" :             "Unit movement time",
    "stringTableTimeTopBottomUnit" :             "Unit movement time",
    "stringTableTimeSlatsUnit" :                 "Unit slat adjustment time",
    "stringTableTimeBottomTopValue" :            "Value movement time",
    "stringTableTimeTopBottomValue" :            "Value movement time",
    "stringTableTimeSlatsValue" :                "Value slat adjustment time",
    "stringTableSelfCalibrationResultTrue" :     "Teach-in procedure successful",
    "stringTableSelfCalibrationResultFalse" :    "Calibration run not required",
    "stringTableSelfCalibrationStart" :          "Start calibration run",
    "stringTableSelfCalibrationStop" :           "End calibration run",
    "lblAutoCalibrationActiv" :                  "Auto calibration active",
    "stringTableBlindLevelOff" :                 "Moved down",
    "stringTableBlindLevelOnDelay" :             "Up-delay",
    "stringTableBlindLevelOn" :                  "Moved up",
    "stringTableBlindLevelOffDelay" :            "Down-delay",
    "stringTableWeekProgramChannelLocks" :       "Channels in auto mode",
    "stringTableWeekProgramTargetChannelLocks" : "Channels for mode week program (binary)",
    "stringTableWeekProgramTargetChannelLockManu" : "week program: Manually",
    "stringTableWeekProgramTargetChannelLockAutoReset" : "week program: Auto with reset (reset without function)",
    "stringTableWeekProgramTargetChannelLockAuto" : "week program: Auto without reset",
    "statePresenceFalse" :                       "No presence detected",
    "statePresenceTrue" :                        "Presence detected",
    "presenceDetectionFalse" :                   "Presence detection not active",
    "presenceDetectionTrue" :                    "Presence detection active",
    "btnPresenceDetectionFalse" :                "Switch on presence detection",
    "btnPresenceDetectionTrue" :                 "Switch off presence detection",
    "btnResetPresence" :                         "Reset status",
    "stringTableCurrentIllumination" :           "Unfiltered, current level of brightness",
    "stringTablePresenceDetectionActiveFalse" :  "Presence detector not active",
    "stringTablePresenceDetectionActiveTrue" :   "Presence detector active",
    "stringTablePresenceDetectionStateFalse" :   "No presence detected",
    "stringTablePresenceDetectionStateTrue" :    "Presence detected",
    "stringTableResetPresence" :                 "Reset presence",
    "stringTableShutterVirtualReceiverTitle" :   "Blind actuator",
    "stringTableBlindVirtualReceiverTitle" :     "Shutter actuator",
    "stringTablePresenceDetectorTitle" :         "Presence Sensor",
    "lblTDRegaVersion" :                         "Logic tier<br/>version",

    "lblTDReGaVersionHelp" :                     "Here you can specify which logic layer version of the CCU2 should be used. Select the version <b>'Standard'</b> to be able to use bug fixes in the time module as well as new features like mathematical operations in scripts. " +
                                                 "<br/><br/>Select the version <b>'Community'</b> for additional improvements to troubleshooting in scripts. Please note that in this version scripts may be cancelled even if these have been executed with previous versions of the CCU2 software. " +
                                                 "<br/><br/>If any problems have occurred after the update to the current CCU2 software has been performed, you can change back to the previous version by selecting <b>'Legacy'</b>." ,

    "optionReGaNORMAL" :                         "Standard",
    "optionReGaLEGACY" :                         "Legacy",
    "optionReGaCOMMUNITY" :                      "Community",
    "dialogRestart2ChanceReGaVersion" :          "For the change of the logic tier version to apply, the " +HMIdentifier.en.CCUShortName + " must be restarted.",
    "dialogBtnPerformLaterRestart" :             "Later",
    "stringTableBlindLevelUp" :                  "Shutter level moved up",
    "stringTableBlindLevelDown" :                "Shutter level moved down",
    "stringTableJalousieSlatsLevelUp" :          "Slat position moved up",
    "stringTableJalousieSlatsLevelDown" :        "Slat position moved down",

    "stringTableATCAdaptionInterval" : "Interval for temperature compensation of the sensors",
    "stringTableATCMode" : "Temperature compensation of the sensors",
    "stringTableSensorSensivity" : "Sensor sensitivity",

    "COMMENT" : "THIS is for the release C/2017",

    "stringTableEventBlindTime" : "*tr EVENT_BLINDTIME",
    "stringTableEventBlindTimeBase" : "*tr Einheit EVENT_BLINDTIME",
    "stringTableBlindTimeValue" : "*tr Wert EVENT_BLINDTIME",

    "stringTableEventTimeout" : "*tr EVENT_TIMEOUT",
    "stringTableEventTimeoutBase" : "*tr Einheit EVENT_TIMEOUT",
    "stringTableEventTimeoutValue" : "*tr Wert EVENT_TIMEOUT",

    "stringTableCondValuePassageDetectionLeft" : "*tr Gesendeter Entscheidungswert<br/>bei Durchgang von links nach rechts",
    "stringTableCondValuePassageDetectionRight" : "*tr Gesendeter Entscheidungswert<br/>bei Durchgang von rechts nach links",

    "stringTablePassageDetectionLeft" : "*tr Durchgangserkennung Links",
    "stringTablePassageDetectionRight" : "*tr Durchgangserkennung Rechts",

    "stringTablePassageDetectorCounterTransmitterChannelOperationMode" : "*tr CHANNEL_OPERATION_MODE",

    "optionPassageCounterDetectionLR" : "*tr optionPassageCounterDetectionLR",
    "optionPassageCounterDetectionL" : "*tr optionPassageCounterDetectionL",
    "optionPassageCounterDetectionR" : "*tr optionPassageCounterDetectionR",
    "optionPassageCounterDeltaLR" : "*tr optionPassageCounterDeltaLR",
    "optionPassageCounterDeltaL" : "*tr optionPassageCounterDeltaL",
    "optionPassageCounterDeltaR" : "*tr optionPassageCounterDeltaR",

    "stringTableTemperatureOutOfRangeFalse" : "*tr Umgebungstemperatur OK",
    "stringTableTemperatureOutOfRangeTrue" : "*tr Umgebungstemperatur unzul%E4ssing",

    "stringTableKeyTransceiverChannelOperationMode" : "*tr Kanalverhalten",
    "stringTableKeyTransceiverChannelOperationModeKeyBehavior" : "*tr Taster",
    "stringTableKeyTransceiverChannelOperationModeSwitchBehavior" : "*tr Schalter",
    "stringTableKeyTransceiverChannelOperationModeBinaryBehavior" : "*tr T%FCr-/Fensterkontakt",
    
    "noMoreKeys" : ""
  }
});
