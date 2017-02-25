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
    "motionDetectorSendMotionWithinDetectionSpan" : "Innerhalb des Sendeabstandes erkannte Bewegung senden&nbsp;",
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

    "motionDetectorMessageMovement" : "Meldung im Zustand Bewegung",
    "motionDetectorMessageNoMovement" : "Meldung im Zustand Ruhe",
    "motionDetectorNotificationMovement" : "Benachrichtigungston Bewegung",
    "motionDetectorNotificationNoMovement" : "Benachrichtigungston Ruhe",
    "motionDetectorSensorSensivity" : "Empfindlichkeit des Sensors bei Ersch%FCtterung",
    "motionDetectorTriggerAngle" : "Winkel f%FCr die Lageerkennung",

    "motionDetectorOptionNoMessage" : "Keine Meldung",
    "motionDetectorOptionMotion": "Bewegung",
    "motionDetectorOptionNoMotion": "Ruhe",

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
    "motionDetectorSendMotionWithinDetectionSpan" : "Send motion detected within transmission interval",
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

    "motionDetectorMessageMovement" : "Message in motion status",
    "motionDetectorMessageNoMovement" : "Message in standby status",
    "motionDetectorNotificationMovement" : "Sound notification motion",
    "motionDetectorNotificationNoMovement" : "Sound notification standby",
    "motionDetectorSensorSensivity" : "Sensor sensitivity during vibration",
    "motionDetectorTriggerAngle" : "Angle for position detection",

    "motionDetectorOptionNoMessage" : "No message",
    "motionDetectorOptionMotion": "Motion",
    "motionDetectorOptionNoMotion": "Standby",

    "motionDetectorSensorRange2GPlusSen" : "2G+",
    "motionDetectorSensorRange2G2PlusSens" : "2G++",
    "motionDetectorSensorRange2G" : "2G",
    "motionDetectorSensorRange4G" : "4G",
    "motionDetectorSensorRange8G" : "8G",
    "motionDetectorSensorRange16G" : "16G"

  },

  "tr" : {
    "mdTrigger" : "...'de devreye girer ",
    "motionDetectorOnAirInterval" : "Iletim mesafesi",
    "motionDetectorMinimumOnAirInterval" : "Asgari iletim mesafesi",
    "motionDetectorOnAirIntervalMode" : "Iletim mesafesini secme",
    "motionDetectorOnAirIntervalModeClassic" : "klasik",
    "motionDetectorOnAirIntervalModeDynamic" : "dinamik",
    "motionDetectorRetentionTime" : "Bekleme s&uuml;resi",
    "motionDetectorMinimumRetentionTime" : "Asgari bekleme s&uuml;resi",
    "motionDetectorEventFilterNumberA" : "her",
    "motionDetectorEventFilterNumberB" : " Sens&ouml;r impulsu",
    "motionDetectorEventFilterNumberC" : " Saniyeler icindeki sens&ouml;r ",
    "motionDetectorEventFilterNumberD" : " impulslari",
    "motionDetectorSendMotionWithinDetectionSpan" : "Iletim mesafesi icinde algilanan hareketleri ilet;",
    "motionDetectorMinumumOfLastValuesA" : "Aktarilan parlaklik",
    "motionDetectorMinumumOfLastValuesB0" : "son tespit edilen deger",
    "motionDetectorMinumumOfLastValuesB1" : "son degerlerin ",
    "motionDetectorMinumumOfLastValuesC" : " minimumu",
    "motionDetectorMinumumOfLastValuesD" : " (her 6 dakikada bir &ouml;lc&uuml;m)",
    "motionDetectorHelp" : "<hr><font size='3'><span style=\"text-decoration:underline; font-weight:bold\">Iletim mesafesinin secilmesi</span><br><br></font>Direkt baglantilar olusturuldugunda bekleme s&uuml;resi minimuma ayarlanmissa (standart tutum) iletim mesafesinin secimi dogrudan t&uuml;keticinin (akt&uuml;at&ouml;r&uuml;n) minimum bekleme s&uuml;resine etki eder.<br><br>Bu durumda su iliski gecerli olur:<br><br><span style=\"text-decoration:underline; font-weight:bold\">Klasik ayar:</span><br><br>Bu ayar klasik bir hareket alarminin fonksiyonunu yansitir. Iletim mesafesi sabit 240 saniye olarak (+ %10 tolerans) &ouml;nceden belirlenmistir. Bunun anlami: Hareket alarmi algilanan ilk hareketi bildirir, diger hareketleri ise tekrar yakl. 240 saniye sonra bildirir. &Ouml;rn. bir kablosuz saltere (aydinlatmayi acmak icin) dogrudan baglanti yapilmissa, bu aydinlatma otomatik olarak 5 dakikalik bir acik kalma s&uuml;resine sahip olur. Yani aydinlatma, algilanan hareketten en erken 5 dakika sonra kendini kapatir. S&uuml;rekli hareket varsa acik kalma s&uuml;resi otomatik olarak her defasinda 5 dakika uzar.<br><br>Bunun avantaji: T&uuml;keticinin &ouml;nceden belirlenmis sabit acik kalma s&uuml;resine sahip olmasi ve hareket alarminin bataryayi koruyacak sekilde calismasi.<br><br>Dezavantaj: 5 dakikadan daha kisa acik kalma s&uuml;releri m&uuml;mk&uuml;n degil.<br><br><span style=\"text-decoration:underline; font-weight:bold\">Dinamik ayar:</span><br><br>Iletim mesafesi kendini otomatik olarak oda icindeki harekete uyarlar. Minimum deger &ouml;nceden belirlenebilir, bu esnada girilecek k&uuml;c&uuml;k degerler bataryanin &ouml;mr&uuml;n&uuml; kisaltir. Hareket alarmi algiladigi ilk hareketi bildirir, sonraki hareketleri ise &ouml;ncelikle girilen minimum s&uuml;re sonrasinda bildirir (&ouml;rn. 30 saniye). &Ouml;rn. bir kablosuz saltere (bir aydinlatmayi acmak icin) dogrudan baglanti yapilmissa, bu durumda bu aydinlatma da minimum 30 saniyelik bir acik kalma s&uuml;resine sahip olur. Aydinlatma 30 saniye sonunda kapanir. S&uuml;rekli hareket olmasi halinde hareket alarmi iletim mesafesini kendi basina adim adim (dinamik sekilde) ve dolayisiyla da buna dogrudan bagli bir t&uuml;keticinin acik kalma s&uuml;resini de 10 dakikaya kadar uzatir.<br><br>Avantaj: Az hareketin oldugu ortamlarda dogrudan bagli t&uuml;keticilerin acik kalma s&uuml;resi kisa ayarlanabilir (enerji tasarrufu icin).<br><br>Dezavantaj: Acik kalma s&uuml;resi &ouml;nceden tahmin edilemez ve duruma g&ouml;re 10 dakikayi bulabilir. Hareket alarmina ait bataryanin &ouml;mr&uuml;n&uuml; kisaltir.<br><br>",

    "motionDetectorFilterPeriod" : "Time for switching back to standby <br/>after the last vibration has been detected",
    "motionDetectorChannelOperationMode" : "Detection method",
    "motionDetectorChannelOperationModeOff" : "Sensor not active",
    "motionDetectorChannelOperationModeAnyMotion" : "Vibration",
    "motionDetectorChannelOperationModeFlat" : "Position change",

    "motionDetectorMessageMovement" : "Message in motion status",
    "motionDetectorMessageNoMovement" : "Message in standby status",
    "motionDetectorNotificationMovement" : "Sound notification motion",
    "motionDetectorNotificationNoMovement" : "Sound notification standby",
    "motionDetectorSensorSensivity" : "Sensor sensitivity during vibration",
    "motionDetectorTriggerAngle" : "Angle for position detection",

    "motionDetectorOptionNoMessage" : "No message",
    "motionDetectorOptionMotion": "Motion",
    "motionDetectorOptionNoMotion": "Standby",

    "motionDetectorSensorRange2GPlusSen" : "2G+",
    "motionDetectorSensorRange2G2PlusSens" : "2G++",
    "motionDetectorSensorRange2G" : "2G",
    "motionDetectorSensorRange4G" : "4G",
    "motionDetectorSensorRange8G" : "8G",
    "motionDetectorSensorRange16G" : "16G"
  }
});

