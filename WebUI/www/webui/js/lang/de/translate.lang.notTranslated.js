jQuery.extend(true, langJSON, {
  "de": {

    "helpAlarmSwitchParamDurationValue":
      "Aufrund gesetzlicher Vorgaben ist die Zeitdauer des Alarms auf 10 Minuten begrenzt.  " +
      "Das hei%DFt, eine Eingabe von Werten gr%F6sser 10 Minuten bzw. 600 Sekunden wird ignoriert.",

    "cpSecurityHttpsRedirectTitle" : "Automatische Umleitung auf HTTPS",
    "cpSecurityHttpsRedirectLabel" : "Umleitung auf HTTPS aktiv:",
    "cpSecurityHttpsRedirectDescription" : "Ist die Funktion aktiviert, erfolgt bei Zugriff auf die WebUI %FCber HTTP eine automatische Umleitung auf HTTPS",

    /* LanRoutingV2 */

    "stringTableBrightnessVisKey": "Helligkeit der Systemtaste",
    "stringTableDisplayLightingDuration": "Beleuchtungsdauer Display",

    "lblBus": "BUS",

    "lblOperatingVoltage": "Ausgangsspannung",
    "lblOperatingVoltageStatus": "Status Ausgangsspannung",
    "lblOperationPowerConsumptionState": "Status Stromaufnahme",

    "lblCurrentPowerConsumption": "Aktuelle Stromaufnahme",
    "lblCurrentOperatingVoltage": "Aktuelle Betriebsspannung",

    "comment": "lt. D. Stueben 06.02.2020",
    "lblVoltageStatus_0": "Normal",
    "lblVoltageStatus_1": "Unbekannt",
    "lblVoltageStatus_2": "%DCberspannung",
    "lblVoltageStatus_3": "Ext. Spannungsversorgung",


    "lblPowerConsumptionStatus_0": "Normal",
    "lblPowerConsumptionStatus_1": "Unbekannt",
    "lblPowerConsumptionStatus_2": "Stromaufnahme zu hoch",

    "stringTableOperationPowerConsumptionState": "Status Stromaufnahme",
    "lblOperationTemp": "Betriebstemperatur",

    "lblDutyCycle": "Duty Cycle",
    "lblCarrierSense": "Carrier Sense",

    "comment": "NEW for the DRAP migration",
    "headerDrapUpdateNecessary": 
      "Mit diesem Update wird durch Advanced Routing eine verbesserte Kommunikation zwischen den Homematic IP Funk- und den Homematic IP Wired-Komponenten etabliert. " +
      "Dazu ist es erforderlich, dass ein Firmware-Update des Homematic IP Wired Access Point durchgef%FChrt wird.<br><br>Der Homematic IP Wired Access Point befindet sich " +
      "nach diesem Update im Posteingang und muss dort konfiguriert werden.<br>Alle bereits angelernten und konfigurierten Wired-Ger%E4te in der Installation arbeiten nach dem Update wie gewohnt weiter.",

    "drapUpdateNecessary": "Folgende Wired Access Points mit einer inkompatiblen Firmware wurden gefunden und m%FCssen aktualisiert werden:<br/><br/>",

    "comment": "SPHM-537",
    "stringTableErrorCoProcessor": "Der Kanal ist nicht erreichbar. Bitte pr%FCfen Sie die Spannungsversorgung des Kanals oder deaktivieren Sie diesen in der WebUI.",

    "lblSeeServiceMessage": "Siehe Servicemeldung!",

    "lblAllChannelsVisible": "Alle Kan%E4le sichtbar:",

    "thAvailableVersion": "Verf%FCgbare Version",
    "thInstalledVersion": "Installierte Version",
    "btnReload": "Neu laden",

    "btnAccessPoints": "Access Points mit</br>inkompatibler FW updaten",
    "lblShowAllAPs": "Access Points mit inkompatibler FW updaten",
    "lblGotoUpdate" : "Zum Update",

    "apSearchMigrationDescription":
      "F%FCr die Aktualisierung werden das Passwort des Homematic IP Access Points sowie eine aktive Internetverbindung ben%F6tigt. Das Passwort (PW) finden Sie auf dem Aufkleber am Ger%E4t.",

    "apSearchDescription": "F%FCr die Aktualisierung wird das Passwort des Homematic IP Access Points ben%F6tigt. Das Passwort (PW) finden Sie auf dem Aufkleber am Ger%E4t.",

    "password": "Passwort",
    "apSearchWaitText": "Access Points werden im Netzwerk gesucht. Bitte warten Sie, bis die Suche abgeschlossen ist.",
    "apMigrationNoApToUpdate" : "Es wurden keine Access Points gefunden, deren Firmware aktualisiert werden muss.",

    "apMigrationConfigureForUpdateFailed" : "Beim Starten des Access Point-Updates ist ein Fehler aufgetreten. Bitte %FCberpr%FCfen Sie das Passwort und versuchen Sie es erneut.",

    "apMigrationUpdateSuccessful" : "Die Aktualisierung der Firmware wurde erfolgreich abgeschlossen.",
    "apMigrationUpdateSuccessfulTitle" : "Firmware aktualisisert",

    "apMigrationErrorOrTimeout" : "Bei dem Firmware-Update ist ein Fehler aufgetreten. Bitte aktualisieren Sie die Ansicht und versuchen Sie es erneut.",

    "apMigrationUpdateSuccessfulAddition" : "Sie k%F6nnen den Access Point jetzt %FCber &ldquo;Ger%E4te anlernen&rdquo; anlernen.",
    "apMigrationUpdateSuccessfulAdditionMigrationMode" : "Der Access Point befindet sich jetzt im Posteingang.",

    "hintDeviceDoesNotSupportAction" : "Die aktuell installierte GerÃ¤te-Firmware unterstÃ¼tzt diese Funktion nicht.",

    "stringTableTempHumidityParticulateMatterUnit" : "Einheit der automatischen Sensorreinigung",
    "stringTableTempHumidityParticulateMatterValue" : "Wert der automatischen Sensorreinigung",

    "lblDifferentialTemperature": "Differenz-Temperatur T1 - T2",
    "noUpdateNeeded" : "Kein Update erforderlich.",
     "notCompatible" : "Nicht kompatibel",

    "stringTableMassConc25" : "Massenkonzentration PM2.5",
    "stringTableMassConc100" : "Massenkonzentration PM10",
    "stringTableNumberConc25" : "Mengenkonzentration PM2.5",
    "stringTableNumberConc100" : "Mengenkonzentration PM10",
    "stringTableTypicalParticelSize" : "Typische Partikelgr%F6%DFe",

    "aqiGood" : "Gut",
    "aqiModerate" : "M%E4%DFig",
    "aqiUnhealty1" : "Ungesund f%FCr empf. Personen",
    "aqiUnhealty2" : "Ungesund",
    "aqiUnhealty3" : "Sehr ungesund",
    "aqiHazardous" : "Gesundheitsgef%E4hrdend",
    "lblLocationA" : "Standort",
    "Europe" : "Europa",
    "USA" : "USA",

    "hintGroupDevice" : "Achtung! Dieses Ger%E4t ist Teil einer Heizgruppe.<br/>Anpassungen an den Temperaturprofilen sollten in der Gruppe vorgenommen werden.",

    "lblChnNotAllowedInRoom" : "Dieser Kanal kann keinem Raum zugewiesen werden!",
    "lblChnNotAllowedInFunc" : "Dieser Kanal kann keinem Gewerk zugewiesen werden!",

    "stringTableMulticastRouterModuleEnabled" : "MultiCast-Routing",
    "lblErrorSensor" : "Sensorfehler",

    "lblOutputSwap" : "Ausg%E4nge tauschen",
    "optionOutputNotSwapped" : "Nein",
    "optionOutputSwapped" : "Ja",

    "hintSetReady" : "Bitte bet%E4tigen Sie den Fertig Button und konfigurieren das Ger%E4t in der Ger%E4teliste",

    "drapRescueIntroTitle" : "HmIP-DRAP Vorbereitungsupdate",
    "drapRescueIntroText" : "Dieser HmIP-DRAP mit der Firmware Version 2.0.16 erfordert ein Zwischenupdate, bevor das eigentliche Update ausgef%FChrt werden kann.</br>Geben Sie hierf%FCr das auf dem HmIP-DRAP aufgedruckte Passwort (PW) ein und klicken Sie anschlie%DFend auf &bdquo;OK&ldquo;",
    "drapRescueUpdateSuccessful" : "Das Zwischenupdate wurde erfolgreich abgeschlossen.</br>Warten Sie, bis die LED des HmIP-DRAP blau blinkt, bzw. t%FCrkis leuchtet. Starten Sie dann das eigentliche Update, indem Sie erneut den &ldquo;Update&rdquo; Button klicken.",
    "comment" : "Noch nicht bei der TecDocu gewesen",

    "noMoreKeys" : ""
  }
});

