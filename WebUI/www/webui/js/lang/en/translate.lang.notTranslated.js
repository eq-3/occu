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
    "lblDutyCycle" : "Duty Cycle CCU: ",
    "lblDutyCycleA" : "Duty Cycle CCU",

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

    "comment" : "***** D/2019 *****",
    "lblBrightnessLuxA" : "Enter brightness in lux",
    "lblBrightnessLuxB" : "and confirm",

    "hintInternalLinkExists" :
      "If the channel behaviour changes, the internal connection of the device should be deleted and recreated.<br/> " +
      " Otherwise the internal connection will no longer behave as expected.",

    "comment" : "Error codes service messages DRAP",
    "stringTablelErrorBusConfigMismatchFalse" : "The actual bus topology corresponds to the configured bus topology.",
    "stringTablelErrorBusConfigMismatchTrue" : "The actual Bus topology is different to the configured Bus topology.",

    "stringTableErrorPowerShortCircuitBus1False" : "No short circuit between the power lines of Bus 1 detected.",
    "stringTableErrorPowerShortCircuitBus1True" : "A short circuit between the power lines of Bus 1 was detected.",

    "stringTableErrorPowerShortCircuitBus2False" : "No short circuit between the power lines of Bus 2 detected.",
    "stringTableErrorPowerShortCircuitBus2True" : "A short circuit between the power lines of Bus 2 was detected.",

    "stringTableErrorShortCircuitDataLineBus1False" : "No short circuit between 24V line and the Data line A and/or B of Bus 1 detected.",
    "stringTableErrorShortCircuitDataLineBus1True" : "A short circuit between 24V line and the Data line A and/or B of Bus 1 was detected.",

    "stringTableErrorShortCircuitDataLineBus2False" : "No short circuit between 24V line and the Data line A and/or B of Bus 2 detected.",
    "stringTableErrorShortCircuitDataLineBus2True" : "A short circuit between 24V line and the Data line A and/or B of Bus 2 was detected.",

    "hintDevFwUpdateDCHigh" :
      "<b><span class='attention'>Please note: The duty cycle of the "+HMIdentifier.en.CCUShortName+" is currently very high!</span></b><br/><br/>" +
      "A device firmware update is therefore currently not possible.<br/><br/>"+
      "Wait until the duty cycle has fallen below 80% and then try again.",

    "lblSelectTargetChannels" : "Select<br /> target channels",
    "btnSelect1stVirTargetChannels" : "1. Virt",
    "btnSelectAllTargetChannels" : "All",
    "btnSelectNoTargetChannels" : "None",

    "hintWeeklyProgramActiveExpertChannel" :
      "The expert mode is not active. However, since at least one expert target channel is activated for at least one switching time, " +
      "the target channels are still displayed in expert mode.",

    "helpBlindParamLevel2" :
      "In order for a change in the slat position to take effect at this point, <u>also</u> the shutter height must be defined as the second parameter.<br/><br/>" +
      "If you only want to change the slat position, use the parameter 'Channel action' and select the value 'Ignore' for the shutter height.",

    "stringTableOnMinLevel" : "Valve position changeover value",
    "stringTablePWMatLowValvePosition" : "Automatic changeover from continuous to PWM<br/>(with small valve positions)",

    "alertUsernameForbiddenChars" : "The user name shall not contain a space character.",
    "addFirmwareFailedMinCCUVersion" : "This device-firmware update is not supported by the firmware of your CCU. Please update the CCU firmware first.",

    "stringTableAbortEventSendingChannels" :
      "Faster reaction to a new button press by cancelling old transmission processes",

    "lblStopRunningLink" : "Cancel old transmissions<br/>of this buttons",

    "stringTableElsterCompatibilityMode" : "Elster compatibility mode",

    "addFirmwareFailedNotValidatable" : "The compatibility of this device-firmware update is not validatable. Please download the device-firmware one more time and try again.",

    "hintVirtualChannelChanged" : "Attention! Important note!",
    "hintVirtualChannelChangedMsg" :
      "In simplified mode the channel is switched by the 1st virtual channel. The 2nd and 3rd virtual channel is not displayed. If these do not correspond to the default state, " +
      "the status displayed in the WebUI does eventually not correspond to the actual value. This seems to be the case here.<br/><br/>" +
      "You can check this by deactivating the simplified connection configuration in the user administration and then coming back here.",

    "lblLowBattery" : "Battery empty",
    "lblDisarmed" : "Alarm deactivated",
    "lblExternallyArmed" : "External alarm activated",
    "lblInternallyArmed" : "Internal alarm activated",
    "lblDelayExternalArming" : "External alarm activated with delay",
    "lblDelayInternalArming" : "Internal alarm activated with delay",
    "lblEvent" : "Event",


    "comment" : "***** A/2020 *****",

    "dlgLoadLicense" : "Loading the license",
    "dlgErrorLoadLicense" : "The software license cannot be loaded. Please check the Internet connection of the CCU.",


    "comment" : "NOT YET TRANSLATED",

    "noMoreKeys" : ""
  }
});

langJSON.en.hintActivateDetectorSelfTest += langJSON.en.checkSmokeDetectorSelfTest;
langJSON.en.hintReInclusionDetectorFailed += langJSON.en.checkSmokeDetectorSelfTest;
