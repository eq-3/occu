jQuery.extend(true,langJSON, {
  "de" : {
    "descriptionMeasurementPOWER" : "Leistungs-Sensor",
    "xOptionNotInUse" : "Nicht aktiv",
    "powerOptionExpert" : "Experte",
    "powerOptionHi" : "Schaltbefehl bei &Uuml;berschreiten der Leistung",
    "powerOptionLo" : "Schaltbefehl bei Unterschreiten der Leistung",
    "powerOptionMasterSlave" : "Schaltbefehl bei &Uuml;ber- bzw. Unterschreiten der Leistung",
    "descriptionMeasurementCURRENT" : "Strom-Sensor",
    "currentOptionExpert" : "Experte",
    "currentOptionHi" : "Schaltbefehl bei &Uuml;berschreiten der Stromst&auml;rke",
    "currentOptionLo" : "Schaltbefehl bei Unterschreiten der Stromst&auml;rke",
    "currentOptionMasterSlave" : "Schaltbefehl bei &Uuml;ber- bzw. Unterschreiten der Stromst&auml;rke",
    "descriptionMeasurementVOLTAGE" : "Spannungs-Sensor",
    "voltageOptionExpert" : "Experte",
    "voltageOptionHi" : "Schaltbefehl bei &Uuml;berschreiten der Spannung",
    "voltageOptionLo" : "Schaltbefehl bei Unterschreiten der Spannung",
    "voltageOptionMasterSlave" : "Schaltbefehl bei &Uuml;ber- bzw. Unterschreiten der Spannung",
    "descriptionMeasurementFREQUENCY" : "Frequenz-Sensor",
    "frequencyOptionExpert" : "Experte",
    "frequencyOptionHi" : "Schaltbefehl bei &Uuml;berschreiten der Frequenz",
    "frequencyOptionLo" : "Schaltbefehl bei Unterschreiten der Frequenz",
    "frequencyOptionMasterSlave" : "Schaltbefehl bei &Uuml;ber- bzw. Unterschreiten der Frequenz",
    "stringTableCondTxCyclicAbove" : "Entscheidungswert zyklisch senden",
    "stringTableCondTxCyclicBelow" : "Entscheidungswert zyklisch senden",
    "stringTableSendSwitchCommandCyclically" : "Schaltbefehl zyklisch senden",
    "stringTableCondTxDecisionAbove" : "Gesendeter Entscheidungswert, wenn oberer Grenzwert &uuml;berschritten",
    "stringTableCondTxDecisionBelow" : "Gesendeter Entscheidungswert, wenn unterer Grenzwert unterschritten",

    "stringTableCondTxDecisionPassageRL_A" : "Gesendeter Entscheidungswert,<br/>wenn Anzahl Durchg&auml;nge rechts -> links erreicht",
    "stringTableCondTxDecisionPassageLR_A" : "Gesendeter Entscheidungswert,<br/>wenn Anzahl Durchg&auml;nge links -> rechts erreicht",

    "stringTableCondTxDecisionPassageRL_B" : "Gesendeter oberer Entscheidungswert,<br/>wenn der obere Differenzwert erreicht wurde.",
    "stringTableCondTxDecisionPassageLR_B" : " Gesendeter unterer Entscheidungswert,<br/>wenn der untere Differenzwert erreicht und<br/>zuvor der oberer Grenzwert erreicht wurde.",


    "stringTableCondTxFalling" : "Bei Unterschreitung des unteren Grenzwertes Entscheidungswert senden,<br/>" +
      "wenn vorher der obere Grenzwert &uuml;berschritten wurde.",
    "stringTableCondTxFallingA" : "Bei Unterschreitung des unteren Grenzwertes Entscheidungswert (",
    "stringTableCondTxFallingB" : ") senden,<br/>wenn vorher der obere Grenzwert &uuml;berschritten wurde.",
    "stringTableCondTxFallingTemp" : "Bei Unterschreitung der unteren Temperaturschwelle den Schaltbefehl senden,<br/>" +
      "wenn vorher die obere Temperaturschwelle &uuml;berschritten wurde.",

    "stringTableCondTxRising" : "Bei &Uuml;berschreitung des oberen Grenzwertes Entscheidungswert senden,<br/>" +
      "wenn vorher der untere Grenzwert unterschritten wurde.",
    "stringTableCondTxRisingA" : "Bei &Uuml;berschreitung des oberen Grenzwertes Entscheidungswert (",
    "stringTableCondTxRisingB" : ") senden,<br/>wenn vorher der untere Grenzwert unterschritten wurde.",
    "stringTableCondTxRisingTemp" : "Bei &Uuml;berschreitung der oberen Temperaturschwell den Schaltbefehl senden,<br/>" +
      "wenn vorher die untere Temperaturschwelle unterschritten wurde.",

    "stringTableCondTxFallingRisingA": "Entscheidungswert (",
    "stringTableCondTxFallingRisingB": ") bei &Uuml;berschreitung des oberen Grenzwertes senden,<br/>wenn vorher der untere Grenzwert unterschritten wurde, oder Entscheidungswert (",
    "stringTableCondTxFallingRisingC": ") bei Unterschreitung des unteren Grenzwertes senden,<br/>wenn vorher der obere Grenzwert &uuml;berschritten wurde.",

    "stringTableCondTxNotActive": "Der Sensorkanal ist nicht aktiv.",
    "stringTableCondThresholdHi" : "Oberer Grenzwert",
    "stringTableCondThresholdLo" : "Unterer Grenzwert",


    "numberOfPassesBeforeSendingDecisionVal" : "Anzahl der Durchg&auml;nge, bevor Entscheidungswert gesendet wird:<br/><br>",
    "deltaOfPassesBeforeSendingDecisionVal" : "Differenz der Durchg&auml;nge, bevor Entscheidungswert gesendet wird:<br/><br>",
    "stringTableCondThresholdPassageRL_A" : "Anzahl Durchg&auml;nge von rechts -> links",
    "stringTableCondThresholdPassageLR_A" : "Anzahl Durchg&auml;nge von links -> rechts",
    "stringTableCondThresholdPassageRL_B" : " Oberer Differenzwert 'Durchg&auml;nge nach Links zu Durchg&auml;nge nach Rechts'",
    "stringTableCondThresholdPassageLR_B" : "Unterer Differenzwert 'Durchg&auml;nge nach Links zu Durchg&auml;nge nach Rechts'",
    "stringTableCondThresholdPassageRL_B1" : " Oberer Differenzwert 'Durchg&auml;nge nach Rechts zu Durchg&auml;nge nach Links'",
    "stringTableCondThresholdPassageLR_B1" : "Unterer Differenzwert 'Durchg&auml;nge nach Rechts zu Durchg&auml;nge nach Links'",
    "stringTableCondTxDecisionRainDetected" : "Gesendeter Entscheidungswert, wenn Regen erkannt wird",
    "stringTableCondTxDecisionNoRainDetected" : "Gesendeter Entscheidungswert, wenn Trockenheit erkannt wird",

    "stringTableLEDOntime" : "LED-Leuchtzeit (gn/rt)",
    "stringTableTransmitTryMax" : "Max. Sendeversuche",
    "stringTableUpperVal" : "Oberer Grenzwert",
    "stringTableLowerVal" : "Unterer Grenzwert",
    "PMSwMeasurementHiLoAlert_0" : "Der obere Grenzwert muss gr%F6sser als der untere Grenzwert sein.",
    "PMSwMeasurementHiLoAlert_1" : "Der untere Wert der Hysterese muss kleiner als der obere Grenzwert sein.",
    "PMSwMeasurementHiLoAlert_2" : "Der obere Wert der Hysterese muss gr%F6sser als der untere Grenzwert sein.",
    "PMSwMeasurementHiLoAlert_3" : "Der obere Grenzwert muss gr%F6sser als der untere Grenzwert sein.",
    "PMSwChannel2Header" : "Strom-/Spannungs-/Leistungs- und Frequenzmesser",
    "PMSwChannel2HintHeader" : "Ein Wert wird gesendet, wenn sich seit der letzten Sendung",
    "PMSwAveraging" : "Mittelwertbildung &uuml;ber",
    "PMSwChannel2Hint_Power" : "die Leistung um",
    "PMSwChannel2Hint_Current" : "oder der Strom um",
    "PMSwChannel2Hint_Voltage" : "oder die Spannung um",
    "PMSwChannel2Hint_Frequency" : "oder die Frequenz um",
    "PMSwChannel2Hint_Footer" : "ge&auml;ndert hat.",
    "PMSwChannel2MinDelay" : "Mindestpause nach<br/>der letzten Sendung",

    "hintCondTransmitterLinkAvailable" : "Es existiert eine Verkn&uuml;pfung mit diesem Kanal.<br/> Damit diese korrekt ausgef&uuml;hrt werden kann, muss der obige Parameter aktiviert werden.",

    "dummy" : ""
  },

  "en" : {
    "descriptionMeasurementPOWER" : "Power sensor",
    "xOptionNotInUse" : "Not active",
    "powerOptionExpert" : "Expert",
    "powerOptionHi" : "Switching command if power is exceeded",
    "powerOptionLo" : "Switching command if power falls below threshold",
    "powerOptionMasterSlave" : "Switching command if power is exceeded or falls below threshold",
    "descriptionMeasurementCURRENT" : "Current sensor",
    "currentOptionExpert" : "Expert",
    "currentOptionHi" : "Switching command if current is exceeded",
    "currentOptionLo" : "Switching command if current falls below threshold",
    "currentOptionMasterSlave" : "Switching command if current is exceeded or falls below threshold",
    "descriptionMeasurementVOLTAGE" : "Voltage sensor",
    "voltageOptionExpert" : "Expert",
    "voltageOptionHi" : "Switching command if voltage is exceeded",
    "voltageOptionLo" : "Switching command if voltage falls below threshold",
    "voltageOptionMasterSlave" : "Switching command if voltage is exceeded or falls below threshold",
    "descriptionMeasurementFREQUENCY" : "Frequency sensor",
    "frequencyOptionExpert" : "Expert",
    "frequencyOptionHi" : "Switching command if frequency is exceeded",
    "frequencyOptionLo" : "Switching command if frequency falls below threshold",
    "frequencyOptionMasterSlave" : "Switching command if frequency is exceeded or falls below threshold",
    "stringTableCondTxCyclicAbove" : "Send decision value cyclically",
    "stringTableCondTxCyclicBelow" : "Send decision value cyclically",
    "stringTableSendSwitchCommandCyclically" : "Send switch command cyclically",
    "stringTableCondTxDecisionAbove" : "Sent decision value if upper limit is exceeded",
    "stringTableCondTxDecisionBelow" : "Sent decision value if lower limit falls below threshold",

    "stringTableCondTxDecisionPassageRL_A" : "Sent decision value<br/>if number of passages right -> left reached",
    "stringTableCondTxDecisionPassageLR_A" : "Sent decision value<br/>if number of passages left -> right reached",

    "stringTableCondTxDecisionPassageRL_B" : "Sent upper decision value,<br/>wenn der obere Differenzwert erreicht wurde.",
    "stringTableCondTxDecisionPassageLR_B" : "Sent lower decision value,<br/>when the lower differential value has been reached and the upper limit has been reached previously.",

    "stringTableCondTxFalling" : "Send decision value if lower limit falls below threshold<br/>" +
       "and if the upper limit has been exceeded previously.",
    "stringTableCondTxFallingA" : "Send decision value (",
    "stringTableCondTxFallingB" : ") if lower limit falls below threshold<br/>and if the upper limit has been exceeded previously.",
    "stringTableCondTxFallingTemp" : "Send switch command if lower temperature falls below threshold<br/>" +
       "and if the upper temperatrue has been exceeded previously.",

    "stringTableCondTxRising" : "Send decision value if upper limit is exceeded<br/>" +
      "and if the lower limit has fallen below threshold previously.",
    "stringTableCondTxRisingA" : "Send decision value (",
    "stringTableCondTxRisingB" : ") if upper limit is exceeded<br/>and if the lower limit has fallen below threshold previously.",
    "stringTableCondTxRisingTemp" : "Send switch command if upper temperature is exceeded<br/>" +
      "and if the lower temperature has fallen below threshold previously.",

    "stringTableCondTxFallingRisingA": "Send decision value (",
    "stringTableCondTxFallingRisingB": ") if upper limit has been exceeded and the lower limit<br/>has fallen below threshold previously or send decision value (",
    "stringTableCondTxFallingRisingC": ") if the lower limit<br/>falls below threshold and the upper limit has been exceeded previously.",
    "stringTableCondTxNotActive": "This sensor channel is not active.",
    "stringTableCondThresholdHi" : "Upper limit",
    "stringTableCondThresholdLo" : "Lower limit",
    
    
    "numberOfPassesBeforeSendingDecisionVal" : "Number of passages before the decision value is sent:<br/><br>",
    "deltaOfPassesBeforeSendingDecisionVal" : "Difference of passages before the decision value is sent:<br/><br>",
    "stringTableCondThresholdPassageRL_A" : "Number of passages from right -> left",
    "stringTableCondThresholdPassageLR_A" : "Number of passages from left -> right",
    "stringTableCondThresholdPassageRL_B" : "Upper difference value 'Passages left to passages right'",
    "stringTableCondThresholdPassageLR_B" : "Lower difference value 'Passages left to passages right'",
    "stringTableCondThresholdPassageRL_B1" : "Upper difference value 'Passages right to passages left'",
    "stringTableCondThresholdPassageLR_B1" : "Lower difference value 'Passages right to passages left'",
    "stringTableCondTxDecisionRainDetected" : "Decision value sent if rain is detected",
    "stringTableCondTxDecisionNoRainDetected" : "Decision value sent if draught is detected",
    
    
    "stringTableLEDOntime" : "LED on time (gn/rd)",
    "stringTableTransmitTryMax" : "Max. number of transmission attempts",
    "stringTableUpperVal" : "Upper limit",
    "stringTableLowerVal" : "Lower limit",
    "PMSwMeasurementHiLoAlert_0" : "The upper limit has to be higher than the lower limit.",
    "PMSwMeasurementHiLoAlert_1" : "The lower value of the hysteresis has to be less than the upper limit.",
    "PMSwMeasurementHiLoAlert_2" : "The upper value of the hysteresis has to be higher than the lower limit.",
    "PMSwMeasurementHiLoAlert_3" : "The upper limit has to be higher than the lower limit.",
    "PMSwChannel2Header" : "Current-/voltage-/power- and frequency meter",
    "PMSwChannel2HintHeader" : "A value will be send if since the last transmission",
    "PMSwAveraging" : "Averaging via",
    "PMSwChannel2Hint_Power" : "the power has changed by",
    "PMSwChannel2Hint_Current" : "or the current has changed by",
    "PMSwChannel2Hint_Voltage" : "or the voltage has changed by",
    "PMSwChannel2Hint_Frequency" : "or the frequency has changed by",
    "PMSwChannel2Hint_Footer" : "",
    "PMSwChannel2MinDelay" : "Minimum pause after<br/>last transmission",

    "hintCondTransmitterLinkAvailable" : "There is a link with this channel.<br/> To execute this correctly, the above parameter must be activated.",

    "dummy" : ""
  }
});

