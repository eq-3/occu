jQuery.extend(true,langJSON, {
  "de" : {
    "comment" : "***** C/2019 *****",

    "setAllHmIPDevices" :
      "Soll diese Position auf die entsprechenden HmIP-Ger%E4te %FCbertragen werden?\n\n"  +
        "Bedenken Sie, dass es dann wegen des erh%F6hten Funkaufkommens eventuell zu Kommunikationsst%F6rungen kommen kann.",
    "dialogSettingsTimePositionMessageSetPositionSucceedIncludingAllDevices" :
      "Positionsangabe wurde gespeichert.<br/><br/>" +
        "Die Standortdaten der enstprechenden HmIP-Ger%E4te werden angepasst.",

    "stringTableAnalogInputTransmitterFilterSize" : "Anzahl der Messungen, die f%FCr die Mittelwertbildung<br/>der Eingangsspannung genutzt werden",
    "stringTableAnalogInputTransmitterVoltage" : "Eingangsspannung",
    "stringTableAnalogInputVoltageStatus" : "Eingangsspannung",

    "lblDutyCycleBidCosRF" : "Duty Cycle BidCos:",
    "lblDutyCycleHmIP" : "Duty Cycle HmIP: ",
    "lblDutyCycle" : "Duty Cycle CCU: ",
    "lblDutyCycleA" : "Duty Cycle CCU",

    "stringTableDZGCompatibilityMode" : "DZG Kompatibilit%E4tsmodus",
    "PowerMeterProtocolModeModeOptionSML" : "SML-Protokoll",

    "lblRepetitions" : "Wiederholungen",
    "optionRepetition" : "Wiederholung",
    "optionRepetitions" : "Wiederholungen",
    "lblSoundfileList" : "Titel",
    "btnChooseSongs"  : "Titelauswahl",

    "lblPlaylist" : "Wiedergabeliste",

    "stringTableLogicSwitchAND" : "AND (ein, wenn beide Werte ein)",
    "stringTableLogicSwitchANDINVERS" : "AND_INVERS (AND mit vorheriger Invertierung des Kanal-Zustands)",
    "stringTableLogicSwitchNAND" : "NAND (ein, wenn mindestens ein Wert aus)",
    "stringTableLogicSwitchNOR" : "NOR (ein, wenn beide Werte aus)",
    "stringTableLogicSwitchOR" : "OR (ein, wenn mindestens ein Wert ein)",
    "stringTableLogicSwitchORINVERS" : "OR_INVERS (OR mit vorheriger Invertierung des Kanal-Zustands)",
    "stringTableLogicSwitchXOR" : "XOR (ein, wenn nur genau ein Wert ein)",

    "drapFwNotCompatWithCCUFW" : "Die Accesspoint-Firmware ist nicht kompatibel mit der CCU.\n\nBitte aktualisieren Sie Ihre CCU!",

    "comment" : "***** D/2019 *****",
    "lblBrightnessLuxA" : "Helligkeit in Lux",
    "lblBrightnessLuxB" : "eingeben und %FCbernehmen",

    "hintExternalLinkExists" :
      "Bei %C4nderung des Kanalverhaltens, sollte die interne Verkn%FCpfung des Ger%E4tes gel%F6scht und neu erstellt werden.<br/>" +
      "Andernfalls wird die interne Verkn%FCpfung sich nicht mehr erwartungsgem%E4%DF verhalten.",

    "comment" : "Error codes service messages DRAP",
    "stringTablelErrorBusConfigMismatchFalse" : "Die tats%E4chliche Bustopologie entspricht der konfigurierten Bustopologie.",
    "stringTablelErrorBusConfigMismatchTrue" : "Die tats%E4chliche Bustopologie entspricht nicht der konfigurierten Bustopologie.",

    "stringTableErrorPowerShortCircuitBus1False" : "Kein Kurzschluss zwischen den Stromleitungen von Bus 1 festgestellt.",
    "stringTableErrorPowerShortCircuitBus1True" : "Ein Kurzschluss zwischen den Stromleitungen von Bus 1 wurde festgestellt.",

    "stringTableErrorPowerShortCircuitBus2False" : "Kein Kurzschluss zwischen den Stromleitungen von Bus 2 festgestellt.",
    "stringTableErrorPowerShortCircuitBus2True" : "Ein Kurzschluss zwischen den Stromleitungen von Bus 2 wurde festgestellt.",


    "stringTableErrorShortCircuitDataLineBus1False" : "Kein Kurzschluss zwischen der 24V-Leitung und der Datenleitung A und/oder B von Bus 1 festgestellt.",
    "stringTableErrorShortCircuitDataLineBus1True" : "Ein Kurzschluss zwischen der 24V-Leitung und der Datenleitung A und/oder B von Bus 1 wurde festgestellt.",

    "stringTableErrorShortCircuitDataLineBus2False" : "Kein Kurzschluss zwischen der 24V-Leitung und der Datenleitung A und/oder B von Bus 2 festgestellt.",
    "stringTableErrorShortCircuitDataLineBus2True" : "Ein Kurzschluss zwischen der 24V-Leitung und der Datenleitung A und/oder B von Bus 2 wurde festgestellt.",

    "hintDevFwUpdateDCHigh" : 
      "<b><span class='attention'>Achtung: Der Duty Cycle der "+HMIdentifier.de.CCUShortName+" ist derzeit sehr hoch!</span></b><br/><br/>" +
      "Ein Ger%E4tefirmwareupdate ist daher im Moment nicht m%F6glich.<br/><br/>"+
      "Warten Sie, bis der Duty Cycle unter 80% gesunken ist und versuchen Sie es dann erneut.",

    "lblSelectTargetChannels" : "Zielkan%E4le<br /> w%E4hlen",
    "btnSelect1stVirTargetChannels" : "1. Virt",
    "btnSelectAllTargetChannels" : "Alle",
    "btnSelectNoTargetChannels" : "Keine",

    "hintWeeklyProgramActiveExpertChannel" :
      "Der Expertenmodus ist nicht aktiv. Da jedoch bei mindestens einem Schaltzeitpunkt zumindest ein Experten-Zielkanal aktiviert ist, " +
      "werden die Zielkan%E4le dennoch im Expertenmodus dargestellt.",

    "helpBlindParamLevel2" :
      "Damit eine %C4nderung der Lamellenposition an dieser Stelle wirksam wird, muss <u>zus%E4tzlich</u> als zweiter Parameter die Behangh%F6he festgelegt werden.<br/><br/>" +
      "M%F6chten Sie nur die Lamellenposition %E4ndern, verwenden Sie den Parameter Kanalaktion und w%E4hlen f%FCr die Behangh%F6he den Wert 'Ignorieren'.",

    "stringTableOnMinLevel" : "Ventilposition Umschaltwert",
    "stringTablePWMatLowValvePosition" : "Automatische Umschaltung von Stetig auf PWM<br/>(bei kleinen Ventilpositionen)",

    "alertUsernameForbiddenChars" : "Der Benutzername darf kein Leerzeichen enthalten.",
    "addFirmwareFailedMinCCUVersion" : "Dieses Ger%E4te-Firmware Update wird von der Firmware Ihrer CCU nicht unterst%FCtzt. Bitte aktualisieren Sie zun%E4chst Ihre CCU Firmware.",

    "stringTableAbortEventSendingChannels" :
      "Schnellere Reaktion bei erneutem Tastendruck durch Abbruch alter Sendevorg%E4nge",
    "lblStopRunningLink" : "Alte Sendevorg%E4nge<br/>dieser Tasten abbrechen",

    "stringTableElsterCompatibilityMode" : "Elster Kompatibilit%E4tsmodus",

    "addFirmwareFailedNotValidatable" : "Die Kompatibil%E4t dieses Ger%E4te-Firmware Updates kann nicht %FCberpr%FCft werden. Bitte laden Sie die Firmware erneut herunter und versuchen sie noch einmal.",

    "hintVirtualChannelChanged" : "Achtung! Wichtiger Hinweis!",
    "hintVirtualChannelChangedMsg" :
      "Im vereinfachten Modus wird der Kanal mittels des 1. virtuellen Kanal geschaltet. Der  2. und 3. virtuelle Kanal wird nicht angezeigt. Wenn diese nicht dem Default-Zustand entsprechen, " +
      "entspricht der in der WebUI angezeigte Status unter Umst%E4nden nicht dem tats%E4chlichen Wert. Das scheint hier der Fall zu sein.<br/><br/>" +

      "Sie k%F6nnen das %FCberpr%FCfen, indem Sie in der Benutzerverwaltung die vereinfachte Verkn%FCpfungskonfiguration deaktivieren und anschließend hierher zur%FCckkommen. ",

    "lblLowBattery" : "Batterie leer",
    "lblDisarmed" : "Alarm aus",
    "lblExternallyArmed" : "Externer Alarm aktiviert",
    "lblInternallyArmed" : "Interner Alarm aktiviert",
    "lblDelayExternalArming" : "Externer Alarm verz%F6gert aktiviert",
    "lblDelayInternalArming" : "Interner Alarm verz%F6gert aktiviert",
    "lblEvent" : "Event",

    "noMoreKeys" : ""

  }
});

langJSON.de.hintActivateDetectorSelfTest += langJSON.de.checkSmokeDetectorSelfTest;
langJSON.de.hintReInclusionDetectorFailed += langJSON.de.checkSmokeDetectorSelfTest;


