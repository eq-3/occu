jQuery.extend(true,langJSON, {
  "en" : {
    "comment" : "***** C/2019 *****",

    "setAllHmIPDevices" :
      "Do you want to transfer this position to the corresponding HmIP devices?\n\n"  +
        "Please bear in mind that this may result in communication problems due to the increased radio traffic.",

    "dialogSettingsTimePositionMessageSetPositionSucceedIncludingAllDevices" :
      "Position information was saved.<br/><br/>" +
        "The location data of the corresponding HmIP devices will be adjusted.",

    "stringTableAnalogInputTransmitterFilterSize" : "Number of measurements used for the average value<br/>of the input voltage.",
    "stringTableAnalogInputTransmitterVoltage" : "Input voltage",
    "stringTableAnalogInputVoltageStatus" : "Input voltage",

    "lblDutyCycleBidCosRF" : "Duty Cycle BidCos:",
    "lblDutyCycleHmIP" : "Duty Cycle HmIP: ",
    "lblDutyCycle" : "Duty Cycle: ",

    "stringTableDZGCompatibilityMode" : "DGZ compatibility mode",
    "PowerMeterProtocolModeModeOptionSML" : "SML protocol",

    "lblRepetitions" : "Repetitions",
    "optionRepetition" : "repetition",
    "optionRepetitions" : "repetitions",
    "lblSoundfileList" : "Title list",
    "btnChooseSongs"  : "Title selection",

    "lblPlaylist" : "Playlist",

    "stringTableLogicSwitchAND" : "AND (on if both values are on)",
    "stringTableLogicSwitchANDINVERS" : "AND_INVERS (AND with previous inverting of channel condition)",
    "stringTableLogicSwitchNAND" : "NAND (on if at least one value is off)",
    "stringTableLogicSwitchNOR" : "NOR (on if both values are on)",
    "stringTableLogicSwitchOR" : "OR (on if at least one value on)",
    "stringTableLogicSwitchORINVERS" : "OR_INVERS (OR with previous inverting of channel condition)",
    "stringTableLogicSwitchXOR" : "XOR (on if exactly one value on)",

    "drapFwNotCompatWithCCUFW" : "The Access Point firmware is not compatible to the CCU.\n\nPlease update your CCU!",

    "noMoreKeys" : ""
  }
});

langJSON.en.hintActivateDetectorSelfTest += langJSON.en.checkSmokeDetectorSelfTest;
langJSON.en.hintReInclusionDetectorFailed += langJSON.en.checkSmokeDetectorSelfTest;