jQuery.extend(true,langJSON, {
  "de" : {
    "mdTrigger" : "Ausl&ouml;sen bei ",
    "motionDetectorOnAirInterval" : "Sendeabstand",
    "motionDetectorMinimumOnAirInterval" : "Mindestsendeabstand",
    "motionDetectorOnAirIntervalMode" : "Wahl des Sendeabstandes",
    "motionDetectorOnAirIntervalModeClassic" : "klassisch",
    "motionDetectorOnAirIntervalModeDynamic" : "dynamisch",
    "motionDetectorRetentionTime" : "Verweildauer",
    "motionDetectorMinimumRetentionTime" : "Mindestverweildauer",
    "motionDetectorEventFilterNumberA" : "jedem",
    "motionDetectorEventFilterNumberB" : " Sensor-Impuls",
    "motionDetectorEventFilterNumberC" : " Sensor-Impulsen innerhalb ",
    "motionDetectorEventFilterNumberD" : " Sekunden",
    "motionDetectorSendMotionWithinDetectionSpan" : "Innerhalb des Sendeabstandes erkannte<br/>Bewegung senden&nbsp;",
    "motionDetectorLEDDisableChannelState" : "Deaktivierung der Signalisierung erkannter<br/>Bewegung durch die Ger%E4tetaste",
    "motionDetectorMinumumOfLastValuesA" : "Die &uuml;bertragene Helligkeit ist",
    "motionDetectorMinumumOfLastValuesB0" : "der zuletzt ermittelte Wert",
    "motionDetectorMinumumOfLastValuesB1" : "das Minimum der letzten ",
    "motionDetectorMinumumOfLastValuesC" : " Werte",
    "motionDetectorMinumumOfLastValuesD" : " (Messung alle 6 Minuten)",
    "motionDetectorHelp" : "<hr><font size='3'><span style=\"text-decoration:underline; font-weight:bold\">Wahl des Sendeabstandes</span><br><br></font>Wenn beim Anlegen direkter Verkn&uuml;pfungen die &quot;Art der Verweildauer&quot; auf &quot;minimal&quot; gestellt ist (Standardverhalten),&nbsp;dann wirkt sich die Wahl des Sendeabstandes direkt auf die Mindestverweildauer des Verbrauchers (Aktors) aus.<br><br>Es gilt dann folgende Beziehung:<br><br><span style=\"text-decoration:underline; font-weight:bold\">Einstellung klassisch:</span><br><br>Diese Einstellung gibt die Funktion eines klassischen Bewegungsmelders wieder.&nbsp;Der Sendeabstand ist fest auf 240 Sekunden (+ 10% Toleranz) vorgegeben.&nbsp;Dies bedeutet: Der Bewegungsmelder meldet die erste erkannte Bewegung sofort, weitere Bewegungen&nbsp;dann erneut wieder nach einer Zeit von ca. 240 Sekunden. Bei direkten Verkn&uuml;pfungen z. B. mit&nbsp;einem Funk-Schalter (zum Einschalten der Beleuchtung) hat die Beleuchtung damit automatisch&nbsp;eine Einschaltzeit von min. 5 Minuten. D. h., die Beleuchtung schaltet sich fr&uuml;hestens&nbsp;5 Minuten nach der erkannten Bewegung wieder aus. Bei st&auml;ndiger Bewegung wird die Einschaltdauer&nbsp;automatisch immer um 5 Minuten verl&auml;ngert.<br><br>Vorteil: Fest vorbestimmte Einschaltdauer des Verbrauchers und batterieschonender Betrieb des&nbsp;Bewegungsmelders.<br><br>Nachteil: Keine k&uuml;rzeren Einschaltzeiten als 5 Minuten m&ouml;glich.<br><br><span style=\"text-decoration:underline; font-weight:bold\">Einstellung dynamisch:</span><br><br>Der Sendeabstand passt sich automatisch der im Raum vorhandenen Bewegung an. Der&nbsp;Minimalwert kann vorgegeben werden, wobei kleine Werte zu Lasten der Batterielebensdauer gehen.&nbsp;Der Bewegungsmelder meldet die erste erkannte Bewegung sofort, weitere Bewegungen dann zun&auml;chst&nbsp;nach der eingegebenen Minimalzeit (z. B. 30 Sekunden). Bei direkten Verkn&uuml;pfungen z. B. mit einem&nbsp;Funk-Schalter (zum Einschalten einer Beleuchtung) hat die Beleuchtung damit auch eine&nbsp;Mindesteinschaltzeit von 30 Sekunden. Die Beleuchtung schaltet sich nach 30 Sekunden ab. Bei&nbsp;st&auml;ndiger Bewegung verl&auml;ngert der Bewegungsmelder selbstst&auml;ndig schrittweise (dynamisch) seinen&nbsp;Sendeabstand und damit auch gleichzeitig die Einschaltdauer eines direkt vekn&uuml;pften Verbrauchers auf&nbsp;bis zu 10 Minuten.<br><br>Vorteil: Bei Umgebungen mit wenig Bewegung kann die Einschaltdauer direkt verkn&uuml;pfter Verbraucher&nbsp;klein gehalten werden (energiesparend).<br><br>Nachteil: Die Einschaltdauer ist nicht vorhersehbar und kann u. U. bis zu 10 Minuten betragen. Verk&uuml;rzte&nbsp;Batterielebensdauer des Bewegungsmelder.<br><br>",

    "motionDetectorFilterPeriod" : "Zeit, bis von der zuletzt erkannten Ersch%FCtterung<br/>zur%FCck auf Ruhe gewechselt werden kann",

    "motionDetectorChannelOperationMode" : "Art der Bewegungserkennung",
    "motionDetectorChannelOperationModeOff" : "Sensor nicht aktiv",
    "motionDetectorChannelOperationModeAnyMotion" : "Ersch%FCtterung",
    "motionDetectorChannelOperationModeFlat" : "Lage%E4nderung",

    "motionDetectorMessageMovement_1" : "<span name=\"messageMovement\">Meldung im Zustand Bewegung</span>",
    "motionDetectorMessageMovement_2" : "<span name=\"messageMovement\">Meldung im Zustand Senkrecht</span>",
    "motionDetectorMessageNoMovement_1" : "<span name=\"messageNoMovement\">Meldung im Zustand Ruhe</span>",
    "motionDetectorMessageNoMovement_2" : "<span name=\"messageNoMovement\">Meldung im Zustand Waagerecht</span>",
    "motionDetectorNotificationMovement_1" : "<span name=\"NotiMovement\">Benachrichtigungston Bewegung</span>",
    "motionDetectorNotificationMovement_2" : "<span name=\"NotiMovement\">Benachrichtigungston Senkrecht</span>",
    "motionDetectorNotificationNoMovement_1" : "<span name=\"NotiNoMovement\">Benachrichtigungston Ruhe</span>",
    "motionDetectorNotificationNoMovement_2" : "<span name=\"NotiNoMovement\">Benachrichtigungston Waagerecht</span>",
    "motionDetectorSensorSensivity" : "Empfindlichkeit des Sensors bei Ersch%FCtterung",
    "motionDetectorTriggerAngle" : "Winkel f%FCr die Lageerkennung",

    "motionDetectorOptionNoMessage" : "Keine Meldung",
    "motionDetectorOptionMotion_1": "<span name=\"motion\">Bewegung</span>",
    "motionDetectorOptionMotion_2": "<span name=\"motion\"> Senkrecht</span>",
    "motionDetectorOptionNoMotion_1": "<span name=\"noMotion\">Ruhe</span>",
    "motionDetectorOptionNoMotion_2": "<span name=\"noMotion\">Waagerecht</span>",

    "motionDetectorSensorRange2GPlusSens" : "2G+",
    "motionDetectorSensorRange2G2PlusSense" : "2G++",
    "motionDetectorSensorRange2G" : "2G",
    "motionDetectorSensorRange4G" : "4G",
    "motionDetectorSensorRange8G" : "8G",
    "motionDetectorSensorRange16G" : "16G"


  },

  "en" : {
    "mdTrigger" : "Execute if ",
    "motionDetectorOnAirInterval" : "Transmission interval",
    "motionDetectorMinimumOnAirInterval" : "Min. transmission interval",
    "motionDetectorOnAirIntervalMode" : "Select transmission interval",
    "motionDetectorOnAirIntervalModeClassic" : "classic",
    "motionDetectorOnAirIntervalModeDynamic" : "dynamic",
    "motionDetectorRetentionTime" : "Duration",
    "motionDetectorMinimumRetentionTime" : "Min. duration",
    "motionDetectorEventFilterNumberA" : "every",
    "motionDetectorEventFilterNumberB" : " sensor impulse",
    "motionDetectorEventFilterNumberC" : " sensor impulses within ",
    "motionDetectorEventFilterNumberD" : " seconds",
    "motionDetectorSendMotionWithinDetectionSpan" : "Send motion detected within<br/>transmission interval",
    "motionDetectorLEDDisableChannelState" : "Deactivating the signaling of detected<br/>movement by the device key",
    "motionDetectorMinumumOfLastValuesA" : "The transmitted brightness value is",
    "motionDetectorMinumumOfLastValuesB0" : "the last determined value",
    "motionDetectorMinumumOfLastValuesB1" : "the minimum of the last ",
    "motionDetectorMinumumOfLastValuesC" : " values",
    "motionDetectorMinumumOfLastValuesD" : " (measuring every 6 minutes)",
    "motionDetectorHelp" : "<hr><font size='3'><span style=\"text-decoration:underline; font-weight:bold\">Selecting the transmission interval</span><br><br></font>If the &quot;Type of duration period&quot; will be set to &quot;minimal&quot; (default) when creating a new direct device connection, the transmission interval will have immediate effect on the min. duration period of the consumer load (actuator).<br><br>Then, the following relation applies:<br><br><span style=\"text-decoration:underline; font-weight:bold\">Set to classic:</span><br/><br>In this setting, the functions of a classical motion detector will apply. &nbsp;The transmission interval is set to 240 seconds (+ 10% tolerance).&nbsp;This means: The motion detector immediately informs about the first recognized movements&nbsp;newly recognized movements will be send again after about 240 seconds. In case of direct device connections, e.g. with a wireless switch (to switch on the lighting) the lighting will automatically be switched on for 5 minutes. Thus, the lighting will be switched off at earliest &nbsp;5 minutes after the recognized movement. In case of continuous movement, the switch-on duration&nbsp;will automatically be extended by 5 minutes.<br><br>Advantage: Pre-determined switch-on time of loads and stand-bye mode of&nbsp;motion detector.<br><br>Disadvantage: Switch-on time shorter than 5 minutes impossible.<br><br><span style=\"text-decoration:underline; font-weight:bold\">Set to dynamic:</span><br><br>The transmission interval will automatically adapt to the movement in the room. The &nbsp;minimum value can be adjusted. Please note, that smaller values will decrease the battery life.&nbsp;The motion detector immediately informs about the first recognized movements&nbsp;newly recognized movements will be send again after the entered minimum time (e.g. 30 seconds). In case of direct device connections,&nbsp;e.g. with a wireless switch (to switch on the lighting) the lighting will automatically be switched on for 30 seconds. The lighting will be switched off after 30 seconds. In case of continuous movement, the motion detector will automatically extend the transmission interval step-by-step (dynamic) and the switch-on duration of a directly connected device&nbsp;by up to 10 minutes.<br><br>Advantage: For surroundings with little movements the switch-on time for directly connected devices can be kept short to save energy.<br><br>Disadvantage: The switch-on time is unforeseeable and can take up to 10 minutes. Shortened&nbsp;battery life of motion detector.<br><br>",

    "motionDetectorFilterPeriod" : "Time for switching back to standby <br/>after the last vibration has been detected",
    "motionDetectorChannelOperationMode" : "Detection method",
    "motionDetectorChannelOperationModeOff" : "Sensor not active",
    "motionDetectorChannelOperationModeAnyMotion" : "Vibration",
    "motionDetectorChannelOperationModeFlat" : "Position change",

    "motionDetectorMessageMovement_1" : "<span name=\"messageMovement\">Message in motion status</span>",
    "motionDetectorMessageMovement_2" : "<span name=\"messageMovement\">Message when vertical</span>",
    "motionDetectorMessageNoMovement_1" : "<span name=\"messageNoMovement\">Message in standby status</span>",
    "motionDetectorMessageNoMovement_2" : "<span name=\"messageNoMovement\">Message when horizontal</span>",
    "motionDetectorNotificationMovement_1" : "<span name=\"NotiMovement\">Sound notification motion</span>",
    "motionDetectorNotificationMovement_2" : "<span name=\"NotiMovement\">Sound notification Vertical</span>",
    "motionDetectorNotificationNoMovement_1" : "<span name=\"NotiNoMovement\">Sound notification standby</span>",
    "motionDetectorNotificationNoMovement_2" : "<span name=\"NotiNoMovement\">Sound notification horizontal</span>",

    "motionDetectorSensorSensivity" : "Sensor sensitivity during vibration",
    "motionDetectorTriggerAngle" : "Angle for position detection",

    "motionDetectorOptionNoMessage" : "No message",
    "motionDetectorOptionMotion_1": "<span name=\"motion\">Motion</span>",
    "motionDetectorOptionMotion_2": "<span name=\"motion\">Vertical</span>",
    "motionDetectorOptionNoMotion_1": "<span name=\"noMotion\">Standby</span>",
    "motionDetectorOptionNoMotion_2": "<span name=\"noMotion\">Horizontal</span>",

    "motionDetectorSensorRange2GPlusSens" : "2G+",
    "motionDetectorSensorRange2G2PlusSense" : "2G++",
    "motionDetectorSensorRange2G" : "2G",
    "motionDetectorSensorRange4G" : "4G",
    "motionDetectorSensorRange8G" : "8G",
    "motionDetectorSensorRange16G" : "16G"

  }
});

