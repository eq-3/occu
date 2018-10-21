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
      "<li>Full access: Remote and local access granted<</li>" +
      "<li>Restricted: Local access only</li>" +
      "<li>No access: Access not granted</li>" +
    "<ul>",
    "dialogSettingsFirewallLblHintIPAddresses" : "You can enable access for individual IP addresses or entire address ranges for both IPv4 and IPv6. Enter the addresses in a list separated by ';'.",

    "comment" : "********** END translated section **********",

    "dglUserNewFwSettingsTitle" : "en* Bitte beachten!",
    "dglUserNewFwSettingsContent" : "en* Die Firewalleinstellungen wurden ge%E4ndert. Bei Problemen mit z. B. Zusatzsoftware, wenden Sie sich bitte an den Administrator.",


    "stringTableContactBoost" : "Corrosion protection",
    "lblJalousieBlind" : "Operation mode blind / shutter",
    "optionBlind" : "Blind",
    "optionShutter" : "Shutter",
    "hintBlindModeChanged" : "en* %DCbertragen Sie bitte die Konfiguration, bevor Sie weitermachen",

    "dialogSettingsStorageTitleLEDS" : "en* Info LED",
    "dialogSettingsStorageSettingsLblServiceLed" : "en* Servicemeldungen:",
    "dialogSettingsStorageSettingsLblAlarmLed" : "en* Alarmmeldungen:",
    "dialogSettingsStorageHintLEDS" : "en* Ein- bzw. Abschalten des Blinkens der Info LED bei Service- und Alarmmeldungen",

    "HmIPWPSlatPosHelpTitle" : "en* Hinweis zur Lamellenposition",
    "HmIPWPSlatPosHelp" : "en* Bitte bedenken Sie, dass die Lammellenposition nur f%FCr Jalousieaktoren gilt und bei Rollladenaktoren keine Funktion hat.",

    "dialogSettingsSecurityTDSNMP" : "en* SNMP",
    "dialogSettingsSecurityLblActivateSNMP" : "en* SNMP aktiv:",
    "dialogSettingsSecurityTDSNMPExplanation" : "en* Bei Aktivierung ist der SNMP Dienst aktiv. Unterstützt wird ausschließlich SNMPv3 mit SHA und AES.",
    "dialogSettingsSecurityPasswordHint" : "en* Bitte beachten Sie, dass das Passwort mindestens 8 Zeichen lang sein muss.",
    "dialogSettingsSecurityUserHint" : "en* Bitte geben Sie einen Benutzernamen ein.",

    "hintWiredBlindLinksAvailable" : "en* Achtung, es bestehen Verkn%FCpfungen! Der Betriebsmodus kann daher nicht ge%E4ndert werden.",
    "hintWiredBlindProgramsAvailable" : "en* Achtung, es bestehen Programme! Der Betriebsmodus kann daher nicht ge%E4ndert werden.",

    "hintWiredBlindLinksAndProgramsAvailable" : "en* Achtung, es bestehen Verkn%FCpfungen und Programme. Der Betriebsmodus kann daher nicht ge%E4ndert werden.",
    "hintCheckChannels" : "<br/>en* Pr%FCfen Sie bitte folgende Kan%E4le: ",

    "lblSoundFileNr" : "en* MP3-Datei",
    "lblColorNr" : "en* Farbe",
    "lblColorSongNr" : "en* MP3-Datei<br/>Farbe",
    "internalSystemSound" : "en* Interner Sound",
    "randomPlayback" : "en* Zufallswiedergabe",
    "soundOldValue" : "en* Zuletzt gespielte MP3-Datei",
    "colorOldValue" : "en* Zuletzt gew%E4hlte Farbe",
    "soundColorOldValue" : "en* MP3-Datei/Farbe = letzter Wert",
    "soundColorRandomPlayback" : "en* MP3-Datei/Farbe = Zufallswiedergabe",
    "soundColorInternal" : "en* Interner Sound/keine Farbe",
    "hintSoundFileRandom20" : "en* Zuf%E4llige Wiedergabe einer der ersten 20 MP3-Dateien.",

    "optionNoRepetition" : "en* Keine Wiederholung",
    "optionInfiniteRepetition" : "en* Dauerhaft",

    "noMoreKeys" : ""
  }
});
