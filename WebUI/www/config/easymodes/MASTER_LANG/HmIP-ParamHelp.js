jQuery.extend(true,langJSON, {
  "de" : {
    "HelpTitle" : "Hilfe",
    "ROUTER_MODULE_ENABLED" : "<b>Ger%E4t dient als Router</b><br/><br/>Durch diese Option kann das Ger%E4t Homematic IP Funkbefehle weiterleiten. Es dient somit als Reichweitenverl%E4ngerung f%FCr abgesetzte Komponenten.",
    "ENABLE_ROUTING" : "<b>Routing aktiv</b><br/><br/>Durch diese Option versucht das Ger%E4t %FCber einen Homematic IP Funk Router zu kommunizieren, sobald es den Empf%E4nger nicht direkt erreichen kann. Die Routingfunktion kann beispielsweise bei den Homematic IP Schalt-Mess- und Schaltsteckdosen mit aktueller Firmware aktiviert werden.",
    "BLIND_REFERENCE_RUNNING_TIME" : "Nachdem Sie den Wert der Fahrzeit per Hand ge%E4ndert haben, ist der CCU die Position der Jalousie/Rolllade nicht mehr bekannt. Daher sollten sie anschlie%DFend eine Kalibrierfahrt (einmal ganz hoch oder herunter) durchf&uuml;hren. Dadurch stellen sie sicher, dass der CCU die genaue Position der Jalousie/Rolllade wieder bekannt ist.<br/><br/>" +
      "Das gilt auch f%FCr Ger%E4te mit automatischer Kalibrierfahrt, wenn Sie sich entschlie%DFen, den Wert der Fahrzeit per Hand zu %E4ndern.",
    "BLIND_AUTOCALIBRATION" : "Die automatische Kalibrierfahrt ermittelt die Fahrzeit f%FCr die Behangh%F6he. Die Lamellenverstellzeit ist davon nicht betroffen und muss von Hand eingetragen werden.",

    "BLOCKING_PERIOD" :
      "Die Bewegungs-/Pr%E4senzerkennung kann f%FCr die hier gew%E4hlte Zeit deaktiviert werden, indem ein Taster o. %E4. mit diesem Kanal verkn%FCpft wird. " +
      "Sobald der Kanal einen Schaltbefehl empf%E4ngt, wird die Erkennung f%FCr die gew%E4hlte Zeit unterdr%FCckt. Nach Ablauf der Zeit, arbeitet der Bewegungs-/Pr%E4senzmelder wieder wie gewohnt.",

    "PERMANENT_FULL_RX" :
      "Um den Stromverbrauch batteriebetriebener Ger%E4te m%F6glichst gering zu halten, sind diese Ger%E4te per default nicht in st%E4ndiger H%F6rbereitschaft. " +
      "%C4nderungen, die Sie z. B. auf dieser Kanalkonfigurationsseite vornehmen, werden dadurch erst dann %FCbertragen, wenn das Ger%E4t bet%E4tigt wird oder seinen Status sendet.<br/><br/>" +
      "Mit diesem Parameter k%F6nnen Sie dieses Verhalten auf Kosten der Batterielebensdauer %E4ndern, so dass sich das Ger%E4t in st%E4ndiger H%F6rbereitschaft befindet und %C4nderungen unverz%FCglich %FCbernommen werden.",

    "COND_TX_DECISION_ABOVE_BELOW" :
      "%C4ndern Sie diesen Parameter nur, wenn es wirklich notwendig ist. Eine %C4nderung dieses Wertes kann dazu f%FChren, " +
      "dass Verkn%FCpfungen mit diesem Kanal nicht mehr erwartungsgem%E4%DF arbeiten.",

    "DELAY_COMPENSATION" : "Es gibt Motoren, die nach dem Einschalten mit einer gewissen Verz%F6gerung loslaufen. Dieser Parameter bietet Ihnen die M%F6glichkeit, den Wert der Verz%F6gerung einzustellen.",

    "SPDR_CHANNEL_MODE" :
      "<ul>" +
        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>1 - \${optionInactiv}</b><br/>" +
          "Z%E4hlabh%E4ngiges Schalten des Sensors deaktiviert."+
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>2 - \${optionPassageCounterDetectionLR}</b><br/>" +
          "Ist die Anzahl der gew%FCnschten Durchg%E4nge erreicht, wird der gew%E4hlte Entscheidungswert gesendet "+
          "und direkte Verkn%FCpfungen, die auf diesen Wert reagieren, getriggert.<br/><br/>" +
          "In diesem Modus reagiert der Sensor auf Durchg%E4nge aus beiden Richtungen." +
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>3 - \${optionPassageCounterDetectionL}</b><br/>" +
          "Hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Rechts nach Links."+
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>4 - \${optionPassageCounterDetectionR}</b><br/>" +
          "Auch hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Links nach Rechts."+
         "</li>" +

        // "<li class='diagramHelpCustomModeLi1'>" +
        //   "<b>5 - \${optionPassageCounterDeltaLR}</b><br/>" +
        //   " not in use "+
        // "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>5 - \${optionPassageCounterDeltaL}</b><br/>" +
          "<b>5 - Obere Anzahl der Durchg%E4nge nach links</b><br/>" +
          "In diesem Modus wird die Differenz aller Durchg%E4nge (rechts und links) gebildet. " +
          "Nach links wird bis zu einem Maximalwert (1000) hochgez%E4hlt. Nach rechts wird bis auf NULL heruntergez%E4hlt. " +
          "Mit den einstellbaren Schwellwerten wird eine Hysterese erzeugt. Bei Erreichen des oberen Differenzwertes " +
          "wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert gesendet. Durchg%E4nge dar%FCber hinaus werden bis zu einem Maximum weitergez%E4hlt. " +
          "Danach wird bei Erreichen des unteren Schwellwertes ein Schaltbefehl mit dem unteren Entscheidungswert gesendet." +
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>6 - \${optionPassageCounterDeltaR}</b><br/>" +
          "<b>6 - Obere Anzahl der Durchg%E4nge nach rechts</b><br/>" +
          "In diesem Modus wird die Differenz aller Durchg%E4nge (rechts und links) gebildet. " +
          "Nach rechts wird bis zu einem Maximalwert (1000) hochgez%E4hlt. Nach links wird bis auf NULL heruntergez%E4hlt. " +
          "Mit den einstellbaren Schwellwerten wird eine Hysterese erzeugt. Bei Erreichen des oberen Differenzwertes " +
          "wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert gesendet. Durchg%E4nge dar%FCber hinaus werden bis zu einem Maximum weitergez%E4hlt. "+
          "Danach wird bei Erreichen des unteren Schwellwertes ein Schaltbefehl mit dem unteren Entscheidungswert gesendet." +
         "</li>" +
      "</ul>"

  },

  "en" : {
    "HelpTitle" : "Help",
    "ROUTER_MODULE_ENABLED" : "<b>The device acts as router</b><br/><br/>This option allows the Homematic IP device to forward wireless commands. It therefore is used to increase the reach of standalone components.",
    "ENABLE_ROUTING" : "<b>Routing active</b><br/><br/>Through this option the device attempts to communicate via a Homematic IP radio router as soon as it cannot directly reach the receiver. For example, the routing function may be activated on Homematic IP pluggable switch and meter with current firmware.",
    "BLIND_REFERENCE_RUNNING_TIME" : "After you have manually changed the movement time value, the CCU has no information anymore on the blind/shutter position. You should therefore perform a calibration run (once completely to up and down). This ensures that the CCU is updated on the blind/shutters exact position.<br/><br/>" +
      "This applies also to devices with automatic calibration run if you decide to manually change the movement time value.",
    "BLIND_AUTOCALIBRATION" : "The automatic calibration run determines how long the shutter/blind needs to move to the desired level. The time for adjusting the slats is not considered and has to be entered manually.",

    "BLOCKING_PERIOD" :
      "*en Die Bewegungs-/Pr%E4senzerkennung kann f%FCr die hier gew%E4hlte Zeit deaktiviert werden, indem ein Taster o. %E4. mit diesem Kanal verkn%FCpft wird. " +
      "Sobald der Kanal einen Schaltbefehl empf%E4ngt, wird die Erkennung f%FCr die gew%E4hlte Zeit unterdr%FCckt. Nach Ablauf der Zeit, arbeitet der Bewegungs-/Pr%E4senzmelder wieder wie gewohnt.",

    "PERMANENT_FULL_RX" :
      "*en Um den Stromverbrauch batteriebetriebener Ger%E4te m%F6glichst gering zu halten, sind diese Ger%E4te per default nicht in st%E4ndiger H%F6rbereitschaft. " +
      "%C4nderungen, die Sie z. B. auf dieser Kanalkonfigurationsseite vornehmen, werden dadurch erst dann %FCbertragen, wenn das Ger%E4t bet%E4tigt wird oder seinen Status sendet.<br/><br/>" +
      "Mit diesem Parameter k%F6nnen Sie dieses Verhalten auf Kosten der Batterielebensdauer %E4ndern, so dass sich das Ger%E4t in st%E4ndiger H%F6rbereitschaft befindet und %C4nderungen unverz%FCglich %FCbernommen werden.",

    "COND_TX_DECISION_ABOVE_BELOW" :
      "*en %C4ndern Sie diesen Parameter nur, wenn es wirklich notwendig ist. Eine %C4nderung dieses Wertes kann dazu f%FChren, " +
      "dass Verkn%FCpfungen mit diesem Kanal nicht mehr erwartungsgem%E4%DF arbeiten.",

    "DELAY_COMPENSATION" : "*en Es gibt Motoren, die nach dem Einschalten mit einer gewissen Verz%F6gerung loslaufen. Dieser Parameter bietet Ihnen die M%F6glichkeit, den Wert der Verz%F6gerung einzustellen.",

    "SPDR_CHANNEL_MODE" :
      "<ul>" +
        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>1 - \${optionInactiv}</b><br/>" +
          "*en Z%E4hlabh%E4ngiges Schalten des Sensors deaktiviert."+
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>2 - \${optionPassageCounterDetectionLR}</b><br/>" +
          "*en Ist die Anzahl der gew%FCnschten Durchg%E4nge erreicht, wird der gew%E4hlte Entscheidungswert gesendet "+
          "und direkte Verkn%FCpfungen, die auf diesen Wert reagieren, getriggert.<br/><br/>" +
          "In diesem Modus reagiert der Sensor auf Durchg%E4nge aus beiden Richtungen." +
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>3 - \${optionPassageCounterDetectionL}</b><br/>" +
          "*en Hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Rechts nach Links."+
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>4 - \${optionPassageCounterDetectionR}</b><br/>" +
          "*en Auch hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Links nach Rechts."+
         "</li>" +
        
        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>5 - \${optionPassageCounterDeltaL}</b><br/>" +
          "<b>5 - Obere Anzahl der Durchg%E4nge nach links</b><br/>" +
          "*en In diesem Modus wird die Differenz aller Durchg%E4nge (rechts und links) gebildet. " +
          "Nach links wird bis zu einem Maximalwert (1000) hochgez%E4hlt. Nach rechts wird bis auf NULL heruntergez%E4hlt. " +
          "Mit den einstellbaren Schwellwerten wird eine Hysterese erzeugt. Bei Erreichen des oberen Differenzwertes " +
          "wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert gesendet. Durchg%E4nge dar%FCber hinaus werden bis zu einem Maximum weitergez%E4hlt. " +
          "Danach wird bei Erreichen des unteren Schwellwertes ein Schaltbefehl mit dem unteren Entscheidungswert gesendet." +
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>6 - \${optionPassageCounterDeltaR}</b><br/>" +
          "<b>6 - Obere Anzahl der Durchg%E4nge nach rechts</b><br/>" +
          "*en In diesem Modus wird die Differenz aller Durchg%E4nge (rechts und links) gebildet. " +
          "Nach rechts wird bis zu einem Maximalwert (1000) hochgez%E4hlt. Nach links wird bis auf NULL heruntergez%E4hlt. " +
          "Mit den einstellbaren Schwellwerten wird eine Hysterese erzeugt. Bei Erreichen des oberen Differenzwertes " +
          "wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert gesendet. Durchg%E4nge dar%FCber hinaus werden bis zu einem Maximum weitergez%E4hlt. "+
          "Danach wird bei Erreichen des unteren Schwellwertes ein Schaltbefehl mit dem unteren Entscheidungswert gesendet." +
         "</li>" +
      "</ul>"

  },

  "tr" : {
    "HelpTitle" : "Help",
    "ROUTER_MODULE_ENABLED" : "<b>The device acts as router</b><br/><br/>This option allows the Homematic IP device to forward wireless commands. It therefore is used to increase the reach of standalone components.",
    "ENABLE_ROUTING" : "<b>Routing active</b><br/><br/>Through this option the device attempts to communicate via a Homematic IP radio router as soon as it cannot directly reach the receiver. For example, the routing function may be activated on Homematic IP pluggable switch and meter with current firmware.",
    "BLIND_REFERENCE_RUNNING_TIME" : "After you have manually changed the movement time value, the CCU has no information anymore on the blind/shutter position. You should therefore perform a calibration run (once completely to up and down). This ensures that the CCU is updated on the blind/shutters exact position.<br/><br/>" +
      "This applies also to devices with automatic calibration run if you decide to manually change the movement time value.",
    "BLIND_AUTOCALIBRATION" : "The automatic calibration run determines how long the shutter/blind needs to move to the desired level. The time for adjusting the slats is not considered and has to be entered manually.",

    "BLOCKING_PERIOD" :
      "*tr Die Bewegungs-/Pr%E4senzerkennung kann f%FCr die hier gew%E4hlte die Zeit deaktiviert werden, indem ein Taster o. %E4. mit diesem Kanal verkn%FCpft wird. " +
      "Sobald der Kanal einen Schaltbefehl empf%E4ngt, wird die Erkennung f%FCr gew%E4hlte Zeit unterdr%FCckt. Nach Ablauf der Zeit, arbeitet der Bewegungs-/Pr%E4senzmelder wieder wie gewohnt.",

    "PERMANENT_FULL_RX" :
      "*tr Um den Stromverbrauch batteriebetriebener Ger%E4te m%F6glichst gering zu halten, sind diese Ger%E4te per default nicht in st%E4ndiger H%F6rbereitschaft. " +
      "%C4nderungen, die Sie z. B. auf dieser Kanalkonfigurationsseite vornehmen, werden dadurch erst dann %FCbertragen, wenn das Ger%E4t bet%E4tigt wird oder seinen Status sendet.<br/><br/>" +
      "Mit diesem Parameter k%F6nnen Sie dieses Verhalten auf Kosten der Batterielebensdauer %E4ndern, so dass sich das Ger%E4t in st%E4ndiger H%F6rbereitschaft befindet und %C4nderungen unverz%FCglich %FCbernommen werden.",

    "COND_TX_DECISION_ABOVE_BELOW" :
      "*tr %C4ndern Sie diesen Parameter nur, wenn es wirklich notwendig ist. Eine %C4nderung dieses Wertes kann dazu f%FChren, " +
      "dass Verkn%FCpfungen mit diesem Kanal nicht mehr erwartungsgem%E4%DF arbeiten.",

    "DELAY_COMPENSATION" : "*tr Es gibt Motoren, die nach dem Einschalten mit einer gewissen Verz%F6gerung loslaufen. Dieser Parameter bietet Ihnen die M%F6glichkeit, den Wert der Verz%F6gerung einzustellen.",

    "SPDR_CHANNEL_MODE" :
      "<ul>" +
        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>1 - \${optionInactiv}</b><br/>" +
          "*tr Z%E4hlabh%E4ngiges Schalten des Sensors deaktiviert."+
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>2 - \${optionPassageCounterDetectionLR}</b><br/>" +
          "*tr Ist die Anzahl der gew%FCnschten Durchg%E4nge erreicht, wird der gew%E4hlte Entscheidungswert gesendet "+
          "und direkte Verkn%FCpfungen, die auf diesen Wert reagieren, getriggert.<br/><br/>" +
          "In diesem Modus reagiert der Sensor auf Durchg%E4nge aus beiden Richtungen." +
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>3 - \${optionPassageCounterDetectionL}</b><br/>" +
          "*tr Hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Rechts nach Links."+
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>4 - \${optionPassageCounterDetectionR}</b><br/>" +
          "*tr Auch hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Links nach Rechts."+
         "</li>" +
        
        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>5 - \${optionPassageCounterDeltaL}</b><br/>" +
          "<b>5 - Obere Anzahl der Durchg%E4nge nach links</b><br/>" +
          "*tr In diesem Modus wird die Differenz aller Durchg%E4nge (rechts und links) gebildet. " +
          "Nach links wird bis zu einem Maximalwert (1000) hochgez%E4hlt. Nach rechts wird bis auf NULL heruntergez%E4hlt. " +
          "Mit den einstellbaren Schwellwerten wird eine Hysterese erzeugt. Bei Erreichen des oberen Differenzwertes " +
          "wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert gesendet. Durchg%E4nge dar%FCber hinaus werden bis zu einem Maximum weitergez%E4hlt. " +
          "Danach wird bei Erreichen des unteren Schwellwertes ein Schaltbefehl mit dem unteren Entscheidungswert gesendet." +
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>6 - \${optionPassageCounterDeltaR}</b><br/>" +
          "<b>6 - Obere Anzahl der Durchg%E4nge nach rechts</b><br/>" +
          "*tr In diesem Modus wird die Differenz aller Durchg%E4nge (rechts und links) gebildet. " +
          "Nach rechts wird bis zu einem Maximalwert (1000) hochgez%E4hlt. Nach links wird bis auf NULL heruntergez%E4hlt. " +
          "Mit den einstellbaren Schwellwerten wird eine Hysterese erzeugt. Bei Erreichen des oberen Differenzwertes " +
          "wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert gesendet. Durchg%E4nge dar%FCber hinaus werden bis zu einem Maximum weitergez%E4hlt. "+
          "Danach wird bei Erreichen des unteren Schwellwertes ein Schaltbefehl mit dem unteren Entscheidungswert gesendet." +
         "</li>" +
      "</ul>"

  }
});

