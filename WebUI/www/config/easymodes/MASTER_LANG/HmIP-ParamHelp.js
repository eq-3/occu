jQuery.extend(true,langJSON, {
  "de" : {
    "HelpTitle" : "Hilfe",
    "ROUTER_MODULE_ENABLED" : "<b>Ger%E4t dient als Router</b><br/><br/>Durch diese Option kann das Ger%E4t Homematic IP Funkbefehle weiterleiten. Es dient somit als Reichweitenverl%E4ngerung f%FCr abgesetzte Komponenten.",
    "ENABLE_ROUTING" : "<b>Routing aktiv</b><br/><br/>Durch diese Option versucht das Ger%E4t %FCber einen Homematic IP Router zu kommunizieren, sobald es den Empf%E4nger nicht direkt erreichen kann. Die Routingfunktion kann beispielsweise bei den Homematic IP Schalt-Mess- und Schaltsteckdosen mit aktueller Firmware aktiviert werden.",
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
          "<b>5 -Differenz der Durchg%E4nge - Links </b><br/>" +
            "In diesem Modus wird eine interne Z%E4hlervariable bei erkanntem Durchgang nach LINKS um 1 erh%F6ht und bei " +
            "erkanntem Durchgang nach RECHTS um 1 verringert. Der Minimalwert der internen Z%E4hlervariablen ist NULL der Maximalwert ist 1000.<br/><br/>" +
            "Mit dem einstellbaren oberen und unteren Differenzwert wird eine Hysterese erzeugt. Erreicht der interne Z%E4hler den " +
            "oberen Differenzwert, wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert an den/die " +
            "Verkn%FCpfungspartner gesendet. Durchg%E4nge dar%FCber hinaus werden bis zum Maximalwert weitergez%E4hlt, f%FChren aber " +
            "zu keinem weiteren Schaltbefehl. Erst mit erreichen des unteren Differenzwertes, wird ein Schaltbefehl mit dem " +
            "unteren Entscheidungswert an den/die Verkn%FCpfungspartner gesendet." +
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>6 - \${optionPassageCounterDeltaR}</b><br/>" +
          "<b>6 -Differenz der Durchg%E4nge - Rechts </b><br/>" +
            "In diesem Modus wird eine interne Z%E4hlervariable bei erkanntem Durchgang nach RECHTS um 1 erh%F6ht und bei " +
            "erkanntem Durchgang nach LINKS um 1 verringert. Der Minimalwert der internen Z%E4hlervariablen ist NULL der Maximalwert ist 1000.<br/><br/>" +
            "Mit dem einstellbaren oberen und unteren Differenzwert wird eine Hysterese erzeugt. Erreicht der interne Z%E4hler den " +
            "oberen Differenzwert, wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert an den/die " +
            "Verkn%FCpfungspartner gesendet. Durchg%E4nge dar%FCber hinaus werden bis zum Maximalwert weitergez%E4hlt, f%FChren aber " +
            "zu keinem weiteren Schaltbefehl. Erst mit erreichen des unteren Differenzwertes, wird ein Schaltbefehl mit dem " +
            "unteren Entscheidungswert an den/die Verkn%FCpfungspartner gesendet." +
             "</li>" +
      "</ul>",

    "hintPERMANENT_FULL_RX" :
      "Bitte beachten Sie:<br/>"+
      "Im Batteriebetrieb ist dieses Ger%E4t nicht in st%E4ndiger H%F6rbereitschaft. In diesem Fall kann die Unterdr%FCckung der Bewegungserkennung (Empfangskanal) " +
      "nicht in einer Verkn%FCpfung verwendet werden. Im Batteriebetrieb ist dieses nur mit den ger%E4teeigenen Tasten des HmIP-SMI55 m%F6glich. "+
      "Gleiches gilt in Programmen f%FCr das Ein-/Ausschalten der Bewegungserkennung.",

    "EVENT_FILTER_NUMBER_motionDetect":
      "Hier k%F6nnen Sie die Empfindlichkeit der Bewegungserkennung einstellen. Dabei bedeutet ein hoher Wert eine h%F6here Empfindlichkeit.",

    "ALARM_MODE_ZONE_1 - currently not in use" :
      "F%FCr den Fall, dass die "+ HMIdentifier.de.CCUShortName + " aus irgendwelchen Gr%FCnden nicht erreichbar ist, k%F6nnen Sie hier die Zonen w%E4hlen, " +
      "die dann ............",
    "MIN_INTERVAL" :
      "Der Bewegungsmelder meldet die erste erkannte Bewegung sofort, weitere Bewegungen dann erneut wieder nach der hier gew%E4hlten Zeit.",
    "MIN_INTERVAL_PRESENCE" :
      "Der Pr%E4senzmelder meldet die erste erkannte Bewegung sofort, weitere Bewegungen dann erneut wieder nach der hier gew%E4hlten Zeit.",

    "LOCAL_RESET_DISABLED" : "Bitte beachten Sie, dass dieses Ger%E4t nach Aktivierung dieser Funktion nicht mehr %FCber die Ger%E4tetaste zur%FCckgesetzt werden kann. " +
    "Ein Zur%FCcksetzen des Ger%E4tes ist in diesem Fall nur noch %FCber die Zentrale m%F6glich.<br/><br/>" +
    "<b>Bitte erstellen Sie vor Aktivierung der Funktion ein Backup Ihrer Zentrale, in dem dieses Ger%E4t bereits enthalten ist.</b>",

    "BRIGHTNESS_FILTER" : "Der Helligkeitsfilter im Bewegungsmelder misst etwa alle 6 Minuten einen Helligkeitswert. %DCber den Dropdown-Button bestimmen Sie, wie viele dieser Werte gespeichert werden. Der niedrigste der gespeicherten Werten wird f%FCr die Auswertung verwendet.",

    "CONTACT_BOOST" : "Um dem Korrodieren und m%F6glichen Funktionseinschr%E4nkungen der Taster bzw. Schalter vorzubeugen, kann der 'Korrosionsschutz' aktiviert werden. " +
    "Dieser sorgt daf%FCr, dass kurzzeitig ein erh%F6hter Strom durch einen angeschlossenen Taster oder Schalter flie%DFt, wenn er bet%E4tigt wird. Der Stromimpuls wirkt der Korrosion entgegen.",

    "repetitionOffTimeSound" : "W%E4hlen Sie mit der Ausschaltdauer die Pause zwischen den Wiederholungen. Wird eine dauerhafte Ausschaltdauer gew%E4hlt, wird der Parameter Wiederholungen ignoriert.",
    "repetitionOffTimeDimmer" : "W%E4hlen Sie mit der Ausschaltdauer die Pause zwischen den Wiederholungen. Wird eine dauerhafte Einschaltdauer oder Ausschaltdauer gew%E4hlt, wird der Parameter Wiederholungen ignoriert.",

    "CYCLIC_INFO_MSG" : 
    "Ist der Parameter <b>${stringTableCyclicInfoMsg}</b> nicht aktiviert, wird der Status regelm%E4%DFig in einem bestimmten Zeitraster gesendet. " +
    "Dieses Zeitraster ist von Ger%E4t zu Ger%E4t unterschiedlich und kann zwischen einer und 24 Stunden liegen.<br/><br/>" +
    "Ist der Parameter aktiviert, wird der Status <u>zus%E4tzlich</u> in einem Zeitraster nach folgender Formel gesendet:<br/><br/> " +
    "<div style=\"margin-left:20px\">" +
      "Zeit f%FCr eine Statusmeldung, wenn sich der Status %E4ndert:<br>" +
      "(A+1) x C Sekunden<br/><br/>" +
      "Zeit f%FCr eine Statusmeldung, wenn sich der Status nicht %E4ndert:<br/>" +
      "(A+1) x (B+1) x C Sekunden<br/><br/>" +
    "</div>" +
    "Dabei gilt:<br/><br/>"+
    "<b>A = ${stringTableCyclicInfoMsgDis}</br><br/>" +
    "B = ${stringTableCyclicInfoMsgDisUnChangedwoBR}</br><br/>" +
    "C = Zuf%E4llige Zeit zwischen 120 und 184 Sekunden</b></br><br/>",

    "OPTIMUM_START_STOP" : "Die Optimum-Start-/Stopp-Funktion berechnet automatisch die ben%F6tigte Vorlaufzeit, um eine gew%FCnschte Temperatur zum eingestellten Zeitpunkt im Heizprofil bereits erreicht zu haben. Das Heizprofil wird dabei vorausschauend betrachtet.",

    "noMoreHelp" : ""
  },

  "en" : {
    "HelpTitle" : "Help",
    "ROUTER_MODULE_ENABLED" : "<b>The device acts as router</b><br/><br/>This option allows the Homematic IP device to forward wireless commands. It therefore is used to increase the reach of standalone components.",
    "ENABLE_ROUTING" : "<b>Routing active</b><br/><br/>Through this option the device attempts to communicate via a Homematic IP router as soon as it cannot directly reach the receiver. For example, the routing function may be activated on Homematic IP pluggable switch and meter with current firmware.",
    "BLIND_REFERENCE_RUNNING_TIME" : "After you have manually changed the movement time value, the CCU has no information anymore on the blind/shutter position. You should therefore perform a calibration run (once completely to up and down). This ensures that the CCU is updated on the blind/shutters exact position.<br/><br/>" +
      "This applies also to devices with automatic calibration run if you decide to manually change the movement time value.",
    "BLIND_AUTOCALIBRATION" : "The automatic calibration run determines how long the shutter/blind needs to move to the desired level. The time for adjusting the slats is not considered and has to be entered manually.",


    "BLOCKING_PERIOD" :
    "The motion and presence detection can be deactivated for the time defined here, by linking a push-button or similar to this channel. " +
    "As soon as the channel receives a switching command, the detection is muted for the time defined. After the time has expired the motion detector/presence sensor continues normal operation.",

    "PERMANENT_FULL_RX" :
      "To keep the energy consumption of battery operated devices at a low level, the devices are not permanently listening in the default settings. " +
      "Changes that are made e.g. on this configuration page are transferred only after the device has been operated or sends a status.<br/><br/>" +
      "This parameter can be used to change the behaviour to permanent listening. Thus, changes are adapted immediately but however the battery lifetime will be reduced faster.",


    "COND_TX_DECISION_ABOVE_BELOW" :
      "Change this parameter only if it is really necessary. Changing this value can lead to " +
      "incorrect operation of connections with this channel.",

    "DELAY_COMPENSATION" : "Some motors start running after switching on with a certain delay. The parameter can be used to adjust the duration of the delay.",

    "SPDR_CHANNEL_MODE" :
    "<ul>" +
            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>1 - \${optionInactiv}</b><br/>" +
              "Deactivate counter-based switching of sensor"+
            "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>2 - \${optionPassageCounterDetectionLR}</b><br/>" +
              "If the desired number of passages is reached, the defined decision value will be sent "+
              "and direct connections that react to this value are triggered.<br/><br/>" +
              "In this mode, the sensor reacts to passages from both directions." +
            "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>3 - \${optionPassageCounterDetectionL}</b><br/>" +
              "Here, the same applies as for item 2. The sensor only reacts on passages from right to left."+
             "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>4 - \${optionPassageCounterDetectionR}</b><br/>" +
              "Here, also the same applies as for item 2. The sensor only reacts to passages from left to right."+
             "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              //"<b>5 - \${optionPassageCounterDeltaL}</b><br/>" +
              "<b>5 -Difference of passages - left </b><br/>" +
                "In this mode an internal counter variant is increased by 1 on detected passage to LEFT and " +
                "reduced by 1 on passage detected to RIGHT. The mimium value of the internal counter variable is ZERO and the maximum value is 1000.<br/><br/>" +
                "The adjustable upper and lower difference value is used to create a hysteresis. If the internal counter reaches the " +
                "upper difference value, a switching command is send with the upper decision value to the " +
                "connection partner(s). Additional passages are counted until the maximum value but will not cause " +
                "additional switching commands. Only when reaching the lower difference value, a switching command " +
                "with the lower decision value is sent to the connection partner(s)." +
             "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              //"<b>6 - \${optionPassageCounterDeltaR}</b><br/>" +
              "<b>6 -Difference of passages - right </b><br/>" +
                "In this mode an internal counter variant is increased by 1 on detected passage to RIGHT and " +
                "reduced by 1 on passage detected to LEFT. The mimium value of the internal counter variable is ZERO and the maximum value is 1000.<br/><br/>" +
                "The adjustable upper and lower difference value is used to create a hysteresis. If the internal counter reaches the " +
                "upper difference value, a switching command is send with the upper decision value to the " +
                "connection partner(s). Additional passages are counted until the maximum value but will not cause " +
                "additional switching commands. Only when reaching the lower difference value, a switching command " +
                "with the lower decision value is sent to the connection partner(s)." +
                 "</li>" +
          "</ul>",


    "hintPERMANENT_FULL_RX" :
      "Please note:<br/>"+
      "In battery mode, this device is not permanently listening. In this case, muting of motion detection (receiver channel) " +
      "cannot be used in a connection. In battery mode, this is only possible using the push-buttons of HmIP-SMI55. The same applies to programmes for switching motion detection on or off.",

    "EVENT_FILTER_NUMBER_motionDetect":
      "You can adjust the sensitivity of the motion detection here. A higher value is equal to a higher sensitivity level.",

    "ALARM_MODE_ZONE_1 - currently not in use" :
      "en* F%FCr den Fall, dass die "+ HMIdentifier.en.CCUShortName + " aus irgendwelchen Gr%FCnden nicht erreichbar ist, k%F6nnen Sie hier die Zonen w%E4hlen, " +
      "die dann ............",
    "MIN_INTERVAL" :
      "The motion detector reports the first detected movement immediately, then further movements again after the time selected here.",
    "MIN_INTERVAL_PRESENCE" :
      "The presence sensor reports the first detected movement immediately, then further movements again after the time selected here.",

    "LOCAL_RESET_DISABLED" : "Please note that the factory settings of this device can no longer be restored via the device button after activating this function. " +
    "In this case, the device reset is only possible via the Central Control Unit.<br/><br/>" +
    "<b>Before activation of this function, please create a backup of your Central Control Unit that already includes this device.</b>",

    "BRIGHTNESS_FILTER" : "The brightness filter of the motion detector measures the brightness approximately every 6 minutes. Use the dropdown button to determine how many of these brightness values are saved. The lowest of the stored values is used for the evaluation.",

    "CONTACT_BOOST" : "In order to prevent corrosion and possible functional restrictions of the buttons or switches, the 'corrosion protection' can be activated. " +
    "This ensures that an increased current flows briefly through a connected pushbutton or switch when it is actuated. The current pulse counteracts corrosion.",

    "repetitionOffTimeSound" : "Select the pause between the repetitions with the off duration. If a permanent off time is selected, the Repeats parameter is ignored.",
    "repetitionOffTimeDimmer" : "Select the pause between the repetitions with the off duration. If a permanent on-time or off-time is selected, the Repeats parameter is ignored.",

    "CYCLIC_INFO_MSG" :
    "If parameter <b>${stringTableCyclicInfoMsg}</b> is not active, status is sent at specific regular intervals. " +
    "These intervals differ from one appliance to the next and can be anywhere between one and 24 hours.<br/><br/>" +
    "If the parameter is active, status is <u>additionally </u> sent at intervals calculated using the following equation:<br/><br/> " +
    "<div style=\"margin-left:20px\">" +
    "Timing of a status report if status changes:<br>" +
    "(A+1) x C seconds<br/><br/>" +
    "Timing of a status report if status does not change:<br/>" +
    "(A+1) x (B+1) x C seconds<br/><br/>" +
    "</div>" +
    "Where:<br/><br/>"+
    "<b>A = ${stringTableCyclicInfoMsgDis}</br><br/>" +
    "B = ${stringTableCyclicInfoMsgDisUnChangedwoBR}</br><br/>" +
    "C = Random time between 120 and 184 seconds</b></br><br/>",

    "OPTIMUM_START_STOP" : "The optimum start/stop function automatically calculates the required lead time to achieve a desired temperature already at the set time in the heating profile. The heating profile is considered in advance.",

    "noMoreHelp" : ""
    }
});
