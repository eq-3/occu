jQuery.extend(true,langJSON, {
  "de" : {
    "comment" : "********** Start translated section (already translated by K. Rosenfeld) **********",
    "dlgAdminPasswdHint1" :
      "Bevor Sie Ihre CCU in Betrieb nehmen, vergeben Sie ein Administrator-Passwort. " +
        "Merken Sie sich das Passwort gut und geben es nicht weiter!<br/><br/>" +
        "Weitere Benutzer mit eingeschr%E4nkten Rechten k%F6nnen %FCber die Benutzerverwaltung der CCU eingerichtet werden.",

    "dlgUserPasswdHint1" :
      "Bevor Sie Ihre CCU in Betrieb nehmen, vergeben Sie bitte ein Passwort. " +
        "Merken Sie sich das Passwort gut und geben es nicht weiter!<br/><br/>",

    "showHelpSecurityHigh" : "<h1>H%F6chste Sicherheitsstufe</h1> <p><ul><li>Firewall Ports: Standardm%E4%DFig geschlossen (eingehende Verbindungen)</li></ul></p>",
    "showHelpSecurityMid" : "<h1>Mittlere Sicherheitsstufe</h1> <p><ul><li>Firewall Ports: Standardm%E4%DFig geschlossen (eingehende Verbindungen)</li><li>Authentifizierung f%FCr Homematic XML-RPC API und Remote Homematic Script API: Aktiviert</li><li>Remote Zugriff auf Homematic XML-RPC API: Eingeschr%E4nkt</li><li>Remote Zugriff auf Homematic-Script API: Eingeschr%E4nkt</li></ul></p>",

    "showHelpSecurityLow" : "<h1>Geringste Sicherheitsstufe</h1> <p><ul><li>Firewall Ports: Standardm%E4%DFig offen</li><li>Authentifizierung f%FCr Homematic XMLRPC-API und Remote Homematic Script API: Deaktiviert</li><li>Remote Zugriff auf Homematic XML-RPC API: Vollzugriff</li><li>Remote Zugriff auf Homematic Script API: Eingeschr%E4nkt</li></ul></p>",

    "showHelpSecurityCustom": "<h1>Benutzerdefinierte Sicherheitsstufe</h1><p>Eine oder mehrere Einstellungen weichen von denen der Voreinstellungen der Sicherheitsstufen ab.<br>Wird &quot;Benutzerdefiniert&quot; hier beibehalten, werden keine Einstellungen ver%E4ndert.</p>",

    "secLevelHigh" : "Maximal gesichert",
    "secLevelMid" : "Restriktiv",
    "secLevelLow" : "Relaxed",
    "secLevelCustom" : "Benutzerdefiniert",

    "secLevelHighCaptionA" : "Ich kenne mich gut damit aus, einzelne Dienste (wie z. B. Programmierschnittstellen) &uuml;ber die Sicherheitsoptionen der CCU einstellen zu k&ouml;nnen. In dieser Einstellung ist ausschlie%DFlich der Zugriff auf die Web Oberfl%E4che m%F6glich.",

    "secLevelHighCaptionB" : "Bei dieser Sicherheitsstufe ist der Zugriff auf die Mediola-Software nicht verf%FCgbar. Sie k&ouml;nnen dies &uuml;ber die Firewall-Einstellungen der CCU anpassen.",
    "secLevelMidCaption" : "Bei dieser Sicherheitsstufe ist der Zugriff auf Schnittstellen, Zusatzsoftware und die Mediola-Software verf%FCgbar. ",
    "secLevelLowCaptionA" : "Ich kenne mich gut genug damit aus, die CCU gegen Zugriff Unbefugter sch&uuml;tzen zu k&ouml;nnen.",
    "secLevelUserHint" : "Eine Sicherheitsstufe verhindert nicht das nachtr&auml;gliche %D6ffnen von z. B. Ports in der Firewall-Einstellung. Die Sicherheitsstufe springt dann z. B. von 'Maximal gesichert' auf 'Benutzerdefiniert'.",

    "dialogSetSecurityLevelExpress"  : "Express",
    "dialogSetSecurityLevelUserDefined"  : "Benutzerdefiniert",
    "dlgSecurityLevelHeader" : "Sicherheitsstufe",
    "noPasswdSet" : "Kein Passwort gesetzt!",
    "passwdNotIdentical" : "Passw%F6rter nicht identisch!",

    "adminPasswordTitle" : "<u>Administrator Passwort</u>",
    "userPasswordTitle" : "<u>Benutzer Passwort</u>",
    "portEnablingTitle" : "<b>Port-Freigabe:</b>",
    "portEnablingCaption" : "Hier k%F6nnen ben%F6tigte Ports freigegeben werden. Geben Sie die Ports durch ein ';' getrennt ein.",

    "securitySettingsTitle" : HMIdentifier.de.CCUShortName + " Sicherheitseinstellung",
    "btnSecuritySettings" : "Sicherheits-<br/>Assistent",
    "lblSecuritySettings1" : "Express",
    "lblSecuritySettings2" : "Benutzerdefiniert",

    "dialogSettingsFirewallLblFWPolicy" : "<b>Firewall-Richtlinie:</b>",
    "dialogSettingsFirewallLblPortAccess" : "<b>Port Zugriff:</b>",
    "dialogSettingsFirewallLblPortsRestricted" : "Ports blockiert",
    "dialogSettingsFirewallLblPortsOpen" : "Ports offen",
    "dialogSettingsFirewallLblHintPortAccess" : "Zugriffseinstellungen der Ports",

    "lblSetting" : "Einstellung",
    "" : "",

    "dialogSettingsFirewallLblMediola" : "<b>Mediola-Zugriff:</b>",
    "dialogSettingsFirewallLblHintMediola" : "Erm%F6glicht den Zugriff auf den Mediola-Service",

    "toolTipFirewallAccessModes" : "<ul>" +
      "<li>Vollzugriff: Remote und lokaler Zugriff erlaubt</li>" +
      "<li>Eingeschr%E4nkt: Nur lokaler Zugriff erlaubt</li>" +
      "<li>Kein Zugriff: Zugriff nicht gestattet</li>" +
    "<ul>",

    "dialogSettingsFirewallLblHintIPAddresses" : "Sie k%F6nnen den Zugriff f%FCr einzelne IP-Adressen oder ganze Adressbereiche sowohl f%FCr IPv4 als auch f%FCr IPv6 freigeben. Geben Sie die Adressen durch ein ';' getrennt ein.",

    "comment" : "********** Start translated section (already translated by K. Rosenfeld B2) **********",

    "dglUserNewFwSettingsTitle" : "Bitte beachten!",
    "dglUserNewFwSettingsContent" : "Die Firewalleinstellungen wurden ge%E4ndert. Bei Problemen, z. B. mit Zusatzsoftware, wenden Sie sich bitte an den Administrator.",


    "stringTableContactBoost" : "Korrosionsschutz",
    "lblJalousieBlind" : "Betriebsmodus Jalousie / Rolllade",
    "optionBlind" : "Jalousie",
    "optionShutter" : "Rolllade",
     "hintBlindModeChanged" : "%DCbertragen Sie die Konfiguration, bevor Sie fortfahren.",

    "dialogSettingsStorageTitleLEDS" : "Info-LED",
    "dialogSettingsStorageSettingsLblServiceLed" : "Servicemeldungen:",
    "dialogSettingsStorageSettingsLblAlarmLed" : "Alarmmeldungen:",
    "dialogSettingsStorageHintLEDS" : "Ein- bzw. Ausschalten des Blinkens der Info-LED bei Service- und Alarmmeldungen",

    "HmIPWPSlatPosHelpTitle" : "Hinweis zur Lamellenposition",
    "HmIPWPSlatPosHelp" : "Bitte beachten Sie, dass die Lamellenposition nur f%FCr Jalousieaktoren und nicht f%FCr Rollladenaktoren genutzt werden kann.",

    "dialogSettingsSecurityTDSNMP" : "SNMP",
    "dialogSettingsSecurityLblActivateSNMP" : "SNMP aktiv:",
    "dialogSettingsSecurityTDSNMPExplanation" : "Bei Aktivierung ist der SNMP Dienst aktiv. Unterst%FCtzt wird ausschlie%DFlich SNMPv3 mit SHA und AES.",
    "dialogSettingsSecurityPasswordHint" : "Bitte beachten Sie, dass das Passwort mindestens 8 Zeichen lang sein muss.",
    "dialogSettingsSecurityUserHint" : "Bitte geben Sie einen Benutzernamen ein.",

    "hintWiredBlindLinksAvailable" : "Achtung: Es bestehen Verkn%Fcpfungen. Der Betriebsmodus kann daher nicht ge%E4ndert werden.",
    "hintWiredBlindProgramsAvailable" : "Achtung: Es bestehen Programme. Der Betriebsmodus kann daher nicht ge%E4ndert werden.",
    "hintWiredBlindLinksAndProgramsAvailable" : "Achtung: Es bestehen Verkn%FCpfungen und Programme. Der Betriebsmodus kann daher nicht ge%E4ndert werden.",

    "hintCheckChannels" : "<br/>Pr%FCfen Sie bitte folgende Kan%E4le: ",


    "lblSoundFileNr" : "MP3-Datei",
    "lblColorNr" : "Farbe",
    "lblColorSongNr" : "MP3-Datei<br/>Farbe",
    "internalSystemSound" : "Interner Sound",
    "randomPlayback" : "Zufallswiedergabe",
    "soundOldValue" : "Zuletzt gespielte MP3-Datei",
    "colorOldValue" : "Zuletzt gew%E4hlte Farbe",
    "soundColorOldValue" : "MP3-Datei/Farbe = letzter Wert",
    "soundColorRandomPlayback" : "MP3-Datei/Farbe = Zufallswiedergabe",
    "soundColorInternal" : "Interner Sound/keine Farbe",
    "hintSoundFileRandom20" : "Zuf%E4llige Wiedergabe einer der ersten 20 MP3-Dateien.",

    "optionNoRepetition" : "Keine Wiederholung",
    "optionInfiniteRepetition" : "Dauerhaft",

    "stringTableInternalSoundFile" : "Interner Ger%E4tesound",
    "stringTableRandomSoundFile" : "Zufallswiedergabe",
    "stringTableOldValueSoundFile" : "Zuletzt gespielter Titel",
    "stringTableDoNotCareSoundFile" : "Mit dem aktuellen Titel fortfahren",

    "stringTableAcousticSignalVirtualReceiverTitle" : "MP3-Player",

    "comment" : "********** END translated section **********",

    "comment" : "This is for the Smoke-Detector certification",

    "checkSmokeDetectorSelfTest" : "Bitte vergewissern Sie sich, dass der Rauchmelder korrekt arbeitet, indem Sie einen Selbsttest durch Druck auf die Bedientaste durchf%FChren!",
    "hintActivateDetectorSelfTest" : "Das Firmware-Update wurde erfolgreich aufgespielt. ",
    "hintReInclusionDetectorFailed" : "Beim Aufspielen des Firmware-Updates ist ein Problem aufgetreten. ",

    "noMoreKeys" : ""
  }
});

langJSON.de.hintActivateDetectorSelfTest += langJSON.de.checkSmokeDetectorSelfTest;
langJSON.de.hintReInclusionDetectorFailed += langJSON.de.checkSmokeDetectorSelfTest;
