jQuery.extend(true,langJSON, {
  "en" : {

    "comment" : "********** Start translated section (already translated by K. Rosenfeld) **********",
    "dlgAdminPasswdHint1" :
      "Before you put your CCU into operation, you need to enter an administrator password. " +
        "Be sure to choose a password that you can easily remember and do not share it with anyone else.<br/><br/>" +
        "Additional users with restricted rights can be set up in the CCU user management area.",

    "dlgUserPasswdHint1" :
    "Before you put your CCU into operation, you need to enter a password. " +
      "Be sure to choose a password that you can easily remember and do not share it with anyone else.<br/><br/>",

    "showHelpSecurityHigh" : "<h1><h1>Maximum security level</h1><p><ul><li>Firewall ports: Closed as standard (incoming connections)</li></ul></p>",
    "showHelpSecurityMid" : "<h1>Standard security level</h1> <p><ul><li>Firewall ports: Closed as standard (incoming connections)</li><li>Authentication for Homematic XML-RPC API and Remote Homematic Script API: Activated</li><li>Remote access to Homematic XML-RPC API: Restricted</li><li>Remote access to Homematic Script API: Restricted</li></ul></p>",
    "showHelpSecurityLow" : "<h1>Minimum security level</h1> <p><ul><li>Firewall ports: Open as standard</li><li>Authentication for Homematic XML-RPC API and Remote Homematic Script API: Deactivated</li><li>Remote access to Homematic XML-RPC API: Full access</li><li>Remote access to Homematic Script API: Restricted</li></ul></p>",
    "showHelpSecurityCustom": "<h1>Custom security level</h1> <p>One or more settings deviate from the default settings for the security levels.<br>If &quot;Custom&quot; is retained here, no settings are changed.</p>",

    "secLevelHigh" : "Maximum security",
    "secLevelMid" : "Restricted",
    "secLevelLow" : "Relaxed",
    "secLevelCustom" : "Custom",

    "secLevelHighCaptionA" : "I am familiar with how to set individual services (such as programming interfaces) via the CCU security options. This setting only permits access to the online interface.",
    "secLevelHighCaptionB" : "This security level does not permit access to the Mediola software. This can be modified via the CCU firewall settings.",
    "secLevelMidCaption" : "This safety level permits access to interfaces, additional software and the Mediola software.",
    "secLevelLowCaptionA" : "I am familiar with how to protect the CCU against unauthorised access.",
    "secLevelUserHint" : "A security level does not prevent subsequent opening of ports, for example, in the firewall setting. The security level would then switch, for example, from 'Maximum security' to 'Custom'.",

    "dialogSetSecurityLevelExpress"  : "Express",
    "dialogSetSecurityLevelUserDefined"  : "Custom",
    "dlgSecurityLevelHeader" : "Security level",
    "noPasswdSet" : "No password set!",
    "passwdNotIdentical" : "Passwords do not match!",

    "adminPasswordTitle" : "<u>Administrator password</u>",
    "userPasswordTitle" : "<u>User password</u>",
    "portEnablingTitle" : "<b>Port opening:</b>",
    "portEnablingCaption" : "This is where required ports can be opened. Enter the ports in a list separated by ';'.",

    "securitySettingsTitle" : HMIdentifier.en.CCUShortName + " Security setting",
    "btnSecuritySettings" : "Security<br/>wizard",
    "lblSecuritySettings1" : "Express",
    "lblSecuritySettings2" : "Custom",

    "dialogSettingsFirewallLblFWPolicy" : "<b>Firewall policy:</b>",
    "dialogSettingsFirewallLblPortAccess" : "<b>Port access:</b>",
    "dialogSettingsFirewallLblPortsRestricted" : "Ports blocked",
    "dialogSettingsFirewallLblPortsOpen" : "Ports open",
    "dialogSettingsFirewallLblHintPortAccess" : "Port access settings",

    "lblSetting" : "Setting",

    "dialogSettingsFirewallLblMediola" : "<b>Mediola access:</b>",
    "dialogSettingsFirewallLblHintMediola" : "Enables access to the Mediola service",

    "toolTipFirewallAccessModes" : "<ul>" +
      "<li>Full access: Remote and local access granted</li>" +
      "<li>Restricted: Local access only</li>" +
      "<li>No access: Access not granted</li>" +
    "<ul>",
    "dialogSettingsFirewallLblHintIPAddresses" : "You can enable access for individual IP addresses or entire address ranges for both IPv4 and IPv6. Enter the addresses in a list separated by ';'.",

    "comment" : "********** Start translated section (already translated by K. Rosenfeld B2) **********",

    "dglUserNewFwSettingsTitle" : "Please note!",
    "dglUserNewFwSettingsContent" : "The firewall settings have changed. In case of problems, e.g. with additional software, please contact the admin.",


    "stringTableContactBoost" : "Corrosion protection",
    "lblJalousieBlind" : "Operating mode blind / shutter",
    "optionBlind" : "Blind",
    "optionShutter" : "Shutter",
    "hintBlindModeChanged" : "Transfer the configuration before you continue.",

    "dialogSettingsStorageTitleLEDS" : "Info LED",
    "dialogSettingsStorageSettingsLblServiceLed" : "Service messages:",
    "dialogSettingsStorageSettingsLblAlarmLed" : "Alarm messages:",
    "dialogSettingsStorageHintLEDS" : "Switching the Info LED flashing on or off in case of service and alarm messages",

    "HmIPWPSlatPosHelpTitle" : "Information about slats position",
    "HmIPWPSlatPosHelp" : "Please note that the slats position can be used only for blind actuators and not for shutter actuators.",

    "dialogSettingsSecurityTDSNMP" : "SNMP",
    "dialogSettingsSecurityLblActivateSNMP" : "SNMP active:",
    "dialogSettingsSecurityTDSNMPExplanation" : "After activation, the SNMP service is active. Only SNMPv3 with SHA and AES is supported.",
    "dialogSettingsSecurityPasswordHint" : "Please note that the password must contain at least 8 characters.",
    "dialogSettingsSecurityUserHint" : "Please enter a user name.",

    "hintWiredBlindLinksAvailable" : "Please note: Connections have been found. The operation mode can therefore not be changed.",
    "hintWiredBlindProgramsAvailable" : "Please note: Programs have been found. The operation mode can therefore not be changed.",

    "hintWiredBlindLinksAndProgramsAvailable" : "Please note: Connections and programs have been found. The operation mode can therefore not be changed.",
    "hintCheckChannels" : "<br/>Check the following channels:  ",

    "lblSoundFileNr" : "MP3 file",
    "lblColorNr" : "Colour",
    "lblColorSongNr" : "MP3 file<br/>colour",
    "internalSystemSound" : "Internal sound",
    "randomPlayback" : "Shuffle",
    "soundOldValue" : "Last MP3 file played",
    "colorOldValue" : "Last colour selected",
    "soundColorOldValue" : "MP3 file/colour = last value",
    "soundColorRandomPlayback" : "MP3 file/colour = shuffle",
    "soundColorInternal" : "Internal sound/no colour",
    "hintSoundFileRandom20" : "Random playback of one of the first 20 MP3 files.",

    "optionNoRepetition" : "No repetition",
    "optionInfiniteRepetition" : "Permanent",

    "stringTableInternalSoundFile" : "Internal device sound",
    "stringTableRandomSoundFile" : "Shuffle",
    "stringTableOldValueSoundFile" : "Title last played",
    "stringTableDoNotCareSoundFile" : "Proceed with current title",

    "stringTableAcousticSignalVirtualReceiverTitle" : "MP3-Player",

    "comment" : "********** END translated section **********",

    "comment" : "This is for the Smoke-Detector certification",

    "checkSmokeDetectorSelfTest" : "en* Bitte vergewissern Sie sich, dass der Rauchmelder korrekt arbeitet, indem Sie einen Selbsttest durch Druck auf die Bedientaste durchf%FChren!",
    "hintActivateDetectorSelfTest" : "en* Das Firmware-Update wurde erfolgreich aufgespielt. ",
    "hintReInclusionDetectorFailed" : "en* Beim Aufspielen des Firmware-Updates ist ein Problem aufgetreten. ",

    "noMoreKeys" : ""
  }
});

langJSON.en.hintActivateDetectorSelfTest += langJSON.en.checkSmokeDetectorSelfTest;
langJSON.en.hintReInclusionDetectorFailed += langJSON.en.checkSmokeDetectorSelfTest;