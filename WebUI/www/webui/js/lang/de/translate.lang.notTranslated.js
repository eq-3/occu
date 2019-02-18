jQuery.extend(true,langJSON, {
  "de" : {

    "comment" : "This is for the Smoke-Detector certification",

    "checkSmokeDetectorSelfTest" : "Bitte vergewissern Sie sich, dass der Rauchmelder korrekt arbeitet, indem Sie einen Selbsttest durch Druck auf die Bedientaste durchf%FChren!",
    "hintActivateDetectorSelfTest" : "Das Firmware-Update wurde erfolgreich aufgespielt. ",
    "hintReInclusionDetectorFailed" : "Beim Firmware-Update ist ein Problem aufgetreten.  ",

    "lblRename" : "Umbenennen",
    "askRenameAllChannels" : "Standard-Kanalnamen automatisiert vergeben?",
    "lblDeviceName" : "Ger%E4tename",
    "lblChannelNames" : "Vorschau Kanalnamen",

    "stringTableDisplayContrast" : "Displaykontrast",

    "dialogFirmwareUpdateUnknownError" : "Es ist ein unbekannter Fehler aufgetreten<br/><br/>Bitte %FCberpr%FCfen Sie, ob das Ger%E4t erreichbar ist.",

    "lblHmIPWIdentification" : "Identifizierung",
    "lbDisplayBacklight" : "Beleuchtung<br/>Display",
    "lblLightingKeyVisual" : "Beleuchtung<br/>Systemtaste",

    "optionUnit10SShort" : "10 s",
    "optionUnit30SShort" : "30 s",
    "optionUnit1MShort" : "1 min",
    "optionUnit5MSShort" : "5 min",
    "optionUnit10MShort" : "10 min",
    "optionUnit30MShort" : "30 min",

    "stringTableErrorCoProcessor" : "Der Kanal ist nicht erreichbar.",
    "stringTableErrorRestartNeeded" : "Es ist ein Neutstart des Ger%E4tes n%F6tig.",

    "helpAccessPointOffline" :
      "F%FCr die <u>Inbetriebnahme</u> des Homematic IP Access Points wird eine Internetverbindung ben%F6tigt.<br/><br/>" +
      "Nach erfolgreicher Inbetriebnahme (die Systemtaste leuchtet t%FCrkis), kann der Offlinebetrieb genutzt werden. " +
      "F%FCr den weiteren Betrieb wird nun keine Internetverbindung mehr ben%F6tigt.<br/><br/>" +
      "Wenn Sie den Offlinebetrieb nutzen und weitere Wired Ger%E4te anlernen m%F6chten, verwenden Sie im Anlerndialog das Feld <b>" + langJSON.de.dialogNewDevicesHmIPWithoutInternet +"</b>" +
      "Geben Sie den KEY und die SGTIN des Ger%E4teaufklebers ein.",


    "drapMaxCurrentBus" : "Maximale Stromaufnahme<br/>des Bus",
    "drapHelpMaxCurrentBus" : "Dieser Wert muss in Abh%E4ngigkeit des verwendeten Netzteils konfiguriert werden.",
    "drapBusConfig" : "Buskonfiguration",
    "drapHelpBusConfig" : "Dieser Wert muss in Abh%E4ngigkeit der verwendeten Bustopologie konfiguriert werden.",

    "optionRingMode" : "Ringtopologie",
    "optionTwoSeparateBusSystems" : "Zwei getrennte Busstr%E4nge",

    "AccessPointConfigurationFinished" : "Die Einstellungen wurden erfolgreich %FCbernommen.",

    "dialogMigrationRCV50Title" : langJSON.de.dialogHint,

    "dialogMigrationRCV50" : "Ab diesem Release ist es erstmals m%F6glich, auch f%FCr Homematic IP 50 virtuelle Fernbedienungskan%E4le zu nutzen.<br/><br/>" +
    "Damit diese vollumf%E4nglich genutzt werden k%F6nnen, m%FCssen angelernte Homematic IP Sensoren, welche in Programmen eingebunden sind, umkonfiguriert werden. " +
    "Diese Konfiguration wird automatisch im Hintergrund durchgef%FChrt und durch entsprechende Service-Mitteilungen (\"Konfigurationsdaten stehen zur %DCbertragung an\") angezeigt. " +
    "Bitte nutzen sie die virtuellen Fernbedienungskan%E4le erst, nachdem die Konfigurationsdaten %FCbertragen wurden. " +
    "Bestehende Programme und Verkn%FCpfungen werden von den %C4nderungen nicht beeinflusst.",

    "btnAccessPointConfig" : "Konfiguration",

    "lblQueryConfig" : "Konfiguration abfragen",
    "lblSetConfig" : "Konfiguration speichern",
    "lblConfigNotChanged" : "Es wurde keine %C4nderung an der Konfiguration vorgenommen.",

    "noMoreKeys" : ""
  }
});

langJSON.de.hintActivateDetectorSelfTest += langJSON.de.checkSmokeDetectorSelfTest;
langJSON.de.hintReInclusionDetectorFailed += langJSON.de.checkSmokeDetectorSelfTest;
