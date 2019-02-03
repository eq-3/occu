jQuery.extend(true,langJSON, {
  "en" : {

    "comment" : "This is for the Smoke-Detector certification",

    "checkSmokeDetectorSelfTest" : "en* Bitte vergewissern Sie sich, dass der Rauchmelder korrekt arbeitet, indem Sie einen Selbsttest durch Druck auf die Bedientaste durchf%FChren!",
    "hintActivateDetectorSelfTest" : "en* Das Firmware-Update wurde erfolgreich aufgespielt. ",
    "hintReInclusionDetectorFailed" : "en* Beim Aufspielen des Firmware-Updates ist ein Problem aufgetreten. ",

    "lblRename" : "Rename",
    "askRenameAllChannels" : "en* Standard-Kanalnamen automatisiert vergeben?",
    "lblDeviceName" : "en* Ger%E4tename",
    "lblChannelNames" : "en* Vorschau Kanalnamen",

    "stringTableDisplayContrast" : "Display contrast",

    "dialogFirmwareUpdateUnknownError" : "en* Es ist ein unbekannter Fehler aufgetreten<br/><br/>Bitte %FCberpr%FCfen Sie, ob das Ger%E4t erreichbar ist.",

    "lblHmIPWIdentification" : "en* Identification",
    "lbDisplayBacklight" : "en* Beleuchtung<br/>Display",
    "lblLightingKeyVisual" : "en* Beleuchtung<br/>Systemtaste",

    "optionUnit10SShort" : "en* 10 Sec",
    "optionUnit30SShort" : "en* 30 Sec",
    "optionUnit1MShort" : "en* 1 Min",
    "optionUnit5MSShort" : "en* 5 Min",
    "optionUnit10MShort" : "en* 10 Min",
    "optionUnit30MShort" : "en* 30 Min",

    "stringTableErrorCoProcessor" : "en* Der Kanal ist nicht ansprechbar.",
    "stringTableErrorRestartNeeded" : "en * Es ist ein Neutstart des Ger%E4tes n%F6tig.",

    "helpAccessPointOffline" :
      "en* F%FCr die <u>Inbetriebnahme</u> des Homematic IP Access Points wird <b>immer</b> eine Internetverbindung ben%F6tigt.<br/><br/>" +
      "Nach erfolgreicher Inbetriebnahme - die Systemtaste leuchtet t%FCrkis -, kann der Offlinebetrieb genutzt werden, " +
      "f%FCr den dann keine Internetverbindung mehr ben%F6tigt wird.<br/><br/>" +
      "Wenn Sie den Offlinebetrieb nutzen m%F6chten, verwenden Sie zum Anlernen neuer Ger%E4te im Anlerndialog das Feld <b>" + langJSON.de.dialogNewDevicesHmIPWithoutInternet +"</b>" +
      "Dazu geben Sie den KEY und die SGTIN des dem Ger%E4t beigef%FCgten Stickers ein.",

    "comment" : "Bis hier in Resource.xls übertragen",

    "drapMaxCurrentBus" : "en* Maximale Stromaufnahme des Bus",
    "drapHelpMaxCurrentBus" : "en* Dieser Wert muss in Abh%E4ngigkeit des verwendeten Netzteil konfiguriert werden.",
    "drapBusConfig" : "en* Buskonfiguration",
    "drapHelpBusConfig" : "en* Dieser Wert muss in Abh%E4ngigkeit der verwendeten Bustopologie konfiguriert werden",

    "optionRingMode" : "en* Ringtopologie",
    "optionTwoSeparateBusSystems" : "en* Zwei getrennte Bussysteme",

    "AccessPointConfigurationFinished" : "en* Die Einstellungen wurden erfolgreich %FCbernommen.",

    "dialogMigrationRCV50Title" : langJSON.en.dialogHint,

    "dialogMigrationRCV50" : "en* In diesem Release ist es erstmals m%F6glich, auch f%FCr Homematic IP 50 virtuelle Fernbedienungskan%E4le zu nutzen.<br/><br/>" +
    "Damit diese vollumf%E4nglich genutzt werden k%F6nnen, ist es erforderlich, Homematic IP Sensoren, welche in Programmen eingebunden sind, umzukonfigurieren. " +
    "Die %C4nderungen der Konfiguration werden automatisch im Hintergrund durchgef%FChrt. Dies macht sich durch entsprechende Service-Mitteilungen \"Konfigurationsdaten stehen zur %DCbertragung an\" bemerkbar. " +
    "Bitte nutzen sie die Virtuellen Fernbedienungskan%E4le erst, nachdem die Konfigurationsdaten %FCbertragen wurden. " +
    "Bestehende Programme und Verkn%FCpfungen werden von den %C4nderungen nicht beeinflusst.",

    "noMoreKeys" : ""
  }
});

langJSON.en.hintActivateDetectorSelfTest += langJSON.en.checkSmokeDetectorSelfTest;
langJSON.en.hintReInclusionDetectorFailed += langJSON.en.checkSmokeDetectorSelfTest;