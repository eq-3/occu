jQuery.extend(true,langJSON, {
  "de" : {

    "comment" : "This is for the Smoke-Detector certification",

    "checkSmokeDetectorSelfTest" : "Bitte vergewissern Sie sich, dass der Rauchmelder korrekt arbeitet, indem Sie einen Selbsttest durch Druck auf die Bedientaste durchf%FChren!",
    "hintActivateDetectorSelfTest" : "Das Firmware-Update wurde erfolgreich aufgespielt. ",
    "hintReInclusionDetectorFailed" : "Beim Aufspielen des Firmware-Updates ist ein Problem aufgetreten. ",

    "lblRename" : "Umbenennen",
    "askRenameAllChannels" : "Standard-Kanalnamen automatisiert vergeben?",
    "lblDeviceName" : "Ger%E4tename",
    "lblChannelNames" : "Vorschau Kanalnamen",

    "stringTableDisplayContrast" : "Display Kontrast",

    "dialogFirmwareUpdateUnknownError" : "Es ist ein unbekannter Fehler aufgetreten<br/><br/>Bitte %FCberpr%FCfen Sie, ob das Ger%E4t erreichbar ist.",

    "lblHmIPWIdentification" : "Identifizierung",
    "lbDisplayBacklight" : "Beleuchtung<br/>Display",
    "lblLightingKeyVisual" : "Beleuchtung<br/>Systemtaste",

    "optionUnit10SShort" : "10 Sec",
    "optionUnit30SShort" : "30 Sec",
    "optionUnit1MShort" : "1 Min",
    "optionUnit5MSShort" : "5 Min",
    "optionUnit10MShort" : "10 Min",
    "optionUnit30MShort" : "30 Min",

    "stringTableErrorCoProcessor" : "Der Kanal ist nicht ansprechbar.",
    "stringTableErrorRestartNeeded" : "Es ist ein Neutstart des Ger%E4tes n%F6tig.",

    "helpAccessPointOffline" :
      "F%FCr die <u>Inbetriebnahme</u> des Homematic IP Access Points wird <b>immer</b> eine Internetverbindung ben%F6tigt.<br/><br/>" +
      "Nach erfolgreicher Inbetriebnahme - die Systemtaste leuchtet t%FCrkis -, kann der Offlinebetrieb genutzt werden, " +
      "f%FCr den dann keine Internetverbindung mehr ben%F6tigt wird.<br/><br/>" +
      "Wenn Sie den Offlinebetrieb nutzen m%F6chten, verwenden Sie zum Anlernen neuer Ger%E4te im Anlerndialog das Feld <b>" + langJSON.de.dialogNewDevicesHmIPWithoutInternet +"</b>" +
      "Dazu geben Sie den KEY und die SGTIN des dem Ger%E4t beigef%FCgten Stickers ein.",

    "comment" : "Bis hier in Resource.xls %FCbertragen",

    "drapMaxCurrentBus" : "Maximale Stromaufnahme des Bus",
    "drapHelpMaxCurrentBus" : "Dieser Wert muss in Abh%E4ngigkeit des verwendeten Netzteil konfiguriert werden.",
    "drapBusConfig" : "Buskonfiguration",
    "drapHelpBusConfig" : "Dieser Wert muss in Abh%E4ngigkeit der verwendeten Bustopologie konfiguriert werden",

    "optionRingMode" : "Ringtopologie",
    "optionTwoSeparateBusSystems" : "Zwei getrennte Bussysteme",

    "AccessPointConfigurationFinished" : "Die Einstellungen wurden erfolgreich %FCbernommen.",

    "dialogMigrationRCV50Title" : langJSON.de.dialogHint,

    "dialogMigrationRCV50" : "In diesem Release ist es erstmals m%F6glich, auch f%FCr Homematic IP 50 virtuelle Fernbedienungskan%E4le zu nutzen.<br/><br/>" +
    "Damit diese vollumf%E4nglich genutzt werden k%F6nnen, ist es erforderlich, Homematic IP Sensoren, welche in Programmen eingebunden sind, umzukonfigurieren. " +
    "Die %C4nderungen der Konfiguration werden automatisch im Hintergrund durchgef%FChrt. Dies macht sich durch entsprechende Service-Mitteilungen \"Konfigurationsdaten stehen zur %DCbertragung an\" bemerkbar. " +
    "Bitte nutzen sie die Virtuellen Fernbedienungskan%E4le erst, nachdem die Konfigurationsdaten %FCbertragen wurden. " +
    "Bestehende Programme und Verkn%FCpfungen werden von den %C4nderungen nicht beeinflusst.",
    
    "noMoreKeys" : ""
  }
});

langJSON.de.hintActivateDetectorSelfTest += langJSON.de.checkSmokeDetectorSelfTest;
langJSON.de.hintReInclusionDetectorFailed += langJSON.de.checkSmokeDetectorSelfTest;
