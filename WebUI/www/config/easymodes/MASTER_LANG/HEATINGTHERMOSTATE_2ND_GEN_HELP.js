jQuery.extend(true,langJSON, {
  "de" : {
    "HelpTitle" : "Hilfe",
    "BURST_RX" : "BURST_RX<br/><br/>Hilfetext",
    "BUTTON_LOCK" : "Die Bedienung am Ger&auml;t kann gesperrt werden, um das ungewollte Ver&auml;ndern von Einstellungen, z.B. durch versehentliches Ber&uuml;hren, zu verhindern. Die lokale Bediensperre sperrt die Bedienung am Ger&auml;t.<br/><br/>Die Bediensperre kann am Ger&auml;t wieder aufgehoben werden.",
    "GLOBAL_BUTTON_LOCK" : "Die Bedienung am Ger&auml;t kann gesperrt werden, um das ungewollte Ver&auml;ndern von Einstellungen, z.B. durch versehentliches Ber&uuml;hren, zu verhindern.<br/><br/>Die globale Bediensperre sperrt die Bedienung am Ger&auml;t und kann nur &uuml;ber die WebUI (nicht am Ger&auml;t) deaktiviert werden.",
    "MODUS_BUTTON_LOCK" : "Bei aktivierter Modus-Bediensperre kann das Ger&auml;t nur im aktuell eingestellten Modus bedient werden. Ein Wechsel zwischen den Betriebsmodi (Auto, Manu, Urlaub oder Boost) ist nicht m&ouml;glich.<br/><br/>Die Modus Bediensperre kann nur &uuml;ber die WebUI (nicht am Ger&auml;t) deaktiviert werden.",

    //TODO activate with homematic version 2.8 (party)
    //"TEMPERATUREFALL_MODUS" : "Hier k&ouml;nnen Sie Modus-Einstellungen f&uuml;r die Temperatursturz-<br/>erkennung vornehmen:<br/><br/><ul><li>Inaktiv: Temperatursturzerkennung inaktiv</li><li>Auto-Modus: Temperatursturzerkennung nur im Automodus aktiv</li><li>Auto + Manu-Modus: Temperatursturzerkennung nur im Auto- und Manu-Modus aktiv</li><li>Auto + Party-Modus: Temperatursturzerkennung nur im Auto- und Party-Modus aktiv</li><li>Aktiv: Temperatursturzerkennung f&uuml;r alle Modi aktiv (Standard)</li></ul>",
    "TEMPERATUREFALL_MODUS" : "Hier k&ouml;nnen Sie Modus-Einstellungen f&uuml;r die Temperatursturz-<br/>erkennung vornehmen:<br/><br/><ul><li>Inaktiv: Temperatursturzerkennung inaktiv</li><li>Auto-Modus: Temperatursturzerkennung nur im Automodus aktiv</li><li>Auto + Manu-Modus: Temperatursturzerkennung nur im Auto- und Manu-Modus aktiv</li><li>Aktiv: Temperatursturzerkennung f&uuml;r alle Modi aktiv (Standard)</li></ul>",
    "TEMPERATUREFALL_WINDOW_OPEN_TIME_PERIOD" : "Hier k&ouml;nnen Sie die Zeitdauer der Temperatursturzerkennung einstellen.<br/><br/>Diese Funktion ist nicht in Verbindung mit einem HomeMatic Fensterkontakt m&ouml;glich.",
    "DECALCIFICATION_TIME" : "Zum Schutz vor Ventilverkalkung wird einmal w&ouml;chentlich eine Entkalkungsfahrt des Heizk&ouml;rperthermostat durchgef&uuml;hrt. Dabei wird das Ventil einmal komplett ge&ouml;ffnet und anschlie&szlig;end wieder geschlossen. Dadurch wird verhindert, dass sich der Ventilstift durch Kalkablagerungen festsetzt. W&auml;hrend dieses kurzen Zeitraums ist keine Bedienung m&ouml;glich.<br/><br>Werkseitig ist f&uuml;r die w&ouml;chentliche Entkalkungsfahrt Samstag, 11:00 Uhr festgelegt. Sie k&ouml;nnen den  Zeitpunkt f&uuml;r die Entkalkungsfahrt hier individuell anpassen.",
    "TEMPERATURE_OFFSET" : "Da die Temperatur am Heizk&ouml;rper gemessen wird, kann es an einer anderen Stelle im Raum k&auml;lter oder w&auml;rmer sein. Um dies anzugleichen, kann ein Temperatur-Offset von &plusmn;3.5&#176;C eingestellt werden.<br/><br/>Werden z.B. 18&#176;C anstatt eingestellter 20&#176;C gemessen, ist ein Offset von -2.0&#176;C einzustellen. Werksseitig ist eine Offset-Temperatur von 0.0&#176;C eingestellt.<br/><br/>Sie k&ouml;nnen die Offset-Temperatur hier individuell anpassen.",
    "BOOST_TIME_PERIOD" : "Mit der Boost-Funktion k&ouml;nnen k&uuml;hle R&auml;ume per Knopfdruck und innerhalb k&uuml;rzester Zeit aufgeheizt werden. Beim Ausl&ouml;sen der Boost-Funktion wird das Heizungsventil sofort f&uuml;r 5 Minuten auf 80% ge&ouml;ffnet (Werkseinstellung).<br/><br/>Sie k&ouml;nnen die Boost-Dauer hier individuell anpassen.",
    "BOOST_POSITION" : "Mit der Boost-Funktion k&ouml;nnen k&uuml;hle R&auml;ume per Knopfdruck und innerhalb k&uuml;rzester Zeit aufgeheizt werden. Beim Ausl&ouml;sen der Boost-Funktion wird das Heizungsventil sofort f&uuml;r 5 Minuten auf 80% ge&ouml;ffnet (Werkseinstellung).<br/><br/>Sie k&ouml;nnen den Ventil&ouml;ffnungsgrad w&auml;hrend der Boost-Dauer hier individuell anpassen.",
    "BOOST_AFTER_WINDOW_OPEN" : "Sie k&ouml;nnen diese Funktion aktivieren, wenn die Boostfunktion automatisch ausgel&ouml;st werden soll, nachdem ein offenes Fenster erkannt und das Fenster wieder geschlossen wurde.",
    "VALVE_OFFSET" : "Werden in einem Raum mehrere Heizk&ouml;rper mit einem HomeMatic Heizk&ouml;rperthermostat betrieben, kann es dazu kommen, dass einige Heizk&ouml;rper mehr heizen als andere oder im Extremfall ein Heizk&ouml;rper hei&szlig; ist und andere kalt.<br/><br/>Um dies zu kompensieren, kann ein Ventil-Offset bei dem Heizk&ouml;rperthermostaten eingestellt werden, bei dem der Heizk&ouml;rper kalt bleibt. Werksseitig ist ein Ventil-Offset von 0% eingestellt.<br/><br/>Der Wert kann hier individuell angepasst werden (0 bis 100 %). Unabh&auml;ngig vom eingestellten Offset ist das Ventil bei 0 % aber weiterhin geschlossen. ",
    "VALVE_ERROR_RUN_POSITION" : "Sollte eine leere Batterie nicht bemerkt werden, f&auml;hrt der Heizk&ouml;rperthermostat in eine \"Ventilst&ouml;rungsposition\" um zu verhindern, dass der Raum komplett ausk&uuml;hlt. Werksseitig ist eine Ventilst&ouml;rungsposition von 15 % eingestellt.<br/><br/>Der Wert kann hier individuell angepasst werden (0 bis 100 %).",
    "VALVE_MAXIMUM_POSITION" : "Werksseitig ist eine maximale Ventil&ouml;ffnung von 100 % eingestellt.<br/><br/>Zur Begrenzung der Ventil&ouml;ffnungsposition kann hier eine maximale Position individuell angepasst werden (0-100 %).",
    "MANU_MODE_PRIORITIZATION" : "Hier k&ouml;nnen Sie die Priorisierung f&uuml;r die Funktionalit&auml;t im Manu-Modus festlegen:<br/><br/><ul><li><b>Solltemp.-&Auml;nderungen durch HZ, WT, FK</b>:<ul><li>Solltemp.-&Auml;nderungen k&ouml;nnen nur durch Heizk&ouml;rperthermostat, Wandthermostat, Fensterkontakt sowie direkt am Ger&auml;t durchgef&uuml;hrt werden. (Standard)</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch alle VP</b>:<ul><li>Jeder bekannte Verkn&uuml;pfungspartner kann die Solltemperatur &uuml;berschreiben. Dabei hat die jeweils letzte Solltemperatur&auml;nderung Priorit&auml;t. Eine direkte Bedienung am Ger&auml;t ist weiterhin m&ouml;glich.</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch Ger&auml;t</b>:<ul><li>Solltemperatur&auml;nderungen k&ouml;nnen nur direkt am Ger&auml;t durchgef&uuml;hrt werden.</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch CCU</b>:<ul><li>Solltemperatur&auml;nderungen k&ouml;nnen nur durch die CCU durchgef&uuml;hrt werden.</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch HZ, WT, CCU</b>:<ul><li>Solltemperatur&auml;nderungen k&ouml;nnen nur durch die Verkn&uuml;pfungspartner Heizk&ouml;rperthermostat, Wandthermostat und CCU sowie direkt am  Ger&auml;t durchgef&uuml;hrt werden.</li></ul></li></ul>",
    "PARTY_MODE_PRIORITIZATION" : "Hier k&ouml;nnen Sie die Priorisierung f&uuml;r die Funktionalit&auml;t im Party-Modus festlegen:<br/><ul><li><b>Solltemp.-&Auml;nderungen durch HZ, WT, FK</b>:<ul><li>Solltemp.-&Auml;nderungen k&ouml;nnen nur durch Heizk&ouml;rperthermostat, Wandthermostat, Fensterkontakt sowie direkt am Ger&auml;t durchgef&uuml;hrt werden. (Standard)</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch alle VP</b>:<ul><li>Jeder bekannte Verkn&uuml;pfungspartner kann die Solltemperatur &uuml;berschreiben. Dabei hat die jeweils letzte Solltemperatur&auml;nderung Priorit&auml;t. Eine direkte Bedienung am Ger&auml;t ist weiterhin m&ouml;glich.</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch Ger&auml;t</b>:<ul><li>Solltemperatur&auml;nderungen k&ouml;nnen nur direkt am Ger&auml;t durchgef&uuml;hrt werden.</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch CCU</b>:<ul><li>Solltemperatur&auml;nderungen k&ouml;nnen nur durch die CCU durchgef&uuml;hrt werden.</li></ul></li><li><b>Solltemp.-&Auml;nderungen durch HZ, WT, CCU</b>:<ul><li>Solltemperatur&auml;nderungen k&ouml;nnen nur durch die Verkn&uuml;pfungspartner Heizk&ouml;rperthermostat, Wandthermostat und CCU sowie direkt am  Ger&auml;t durchgef&uuml;hrt werden.</li></ul></li></ul>",

    "WEEK_PROGRAM_POINTER" : "Hier k&ouml;nnen Sie das zu editierende Wochenprogramm w&auml;hlen.",
    "WEEK_PROGRAM_POINTER_group" : "Hier k&ouml;nnen Sie das zu editierende Wochenprogramm w&auml;hlen.<br/><br/>Bitte beachten Sie, dass die Wochenprofile 4 - 6 nicht allen Ger%E4ten zur Ver%FCgung stehen.",
    "TWO_POINT_HYSTERESIS" : "Der Wandthermostat kann in Verbindung mit einem Schaltaktor als Zweipunktregler genutzt werden.<br/><br/>Die Regelung erfolgt in Abh&auml;ngigkeit der Soll- und Ist-Temperatur sowie der hier festgelegten Hysterese.",
    "HEATING_COOLING" : "Wenn der Wandthermostat als Zweipunktregler genutzt wird, ist hier festgelegt, ob die Regelung 'Heizen' oder 'K&uuml;hlen' soll.<br/><br/>Im Heiz-Betrieb wird der Schaltaktor bei Unterschreiten der Soll-Temperatur eingeschaltet, im K&uuml;hl-Betrieb wird er bei &Uuml;berschreiten eingeschaltet.",

    "HUMIDITY_LIMIT_DISABLE" : "Mit diesem Parameter kann gew&auml;hlt werden, ob die K&uuml;hlung w&auml;hrend des K&uuml;hlbetriebes bei &Uuml;berschreitung der Luftfeuchtigkeitsschwelle unterbrochen wird. Dadurch kann verhindert werden, dass die Luftfeuchtigkeit weiter ansteigt.",

    "DURATION_5MIN" : "Befindet sich der Thermostat im Auto-Modus, so wird die Temperatur mit jedem Schaltzeitpunkt auf den programmierten Wert ge&auml;ndert. Dieser Parameter dient dazu, diesen Automatismus f&uuml;r eine gewisse Zeit ausser Kraft zu setzen. Nach Ablauf der Zeit, geht der Thermostat wieder in den Auto-Modus &uuml;ber.<br><br/>" +
      "Die Zeit wird in 5-Minuten-Schritten eingegeben. Der h&ouml;chst zul&auml;ssige Wert betr&auml;gt 720 Minuten, was 12 Stunden entspricht.",

    "ACOUSTIC_ALARM_SIGNAL" : "Mit diesem Parameter k%F6nnen Sie festlegen, ob eine fehlgeschlagene Adaptionsfahrt akustisch signalisiert werden soll.",
    "CHANNEL_OPERATION_MODE" :
      "Durch den Fl%FCsterbetrieb fahren die Heizk%F6rperthermostate langsamer und damit leiser.<br/><br/>" +
      "Diese Funktion bewirkt einen 15-20 Prozent h%F6heren Stromverbrauch des jeweiligen Ger%E4ts.",

    "CLIMATE_FUNCTION" : "Dieser Parameter bestimmt, ob das Ger%E4t als Thermostat-Schalter oder als Hygrostat-Schalter eingesetzt werden soll.",

    "TWO_POINT_HYSTERESIS_A" :
      "Im Heizmodus schaltet der Aktor bei Unterschreiten der Soll-Temperatur ein. Im K%FChlmodus wird er beim %DCberschreiten der Soll-Temperatur eingeschaltet.<br/><br/>" +
      "Mit der Hysterese kann gesteuert werden, um wie viel K die Solltemperatur %FCber- bzw. unterschritten werden muss, damit der Aktor wieder ausschaltet.<br/><br/>" +
      "Dieser Parameter dient zur Festlegung der Hysterese im Bereich von 0,2 K bis 2,0 K.",

    "TWO_POINT_HYSTERESIS_HUMIDITY" :
      "Im Modus 'Befeuchten' schaltet der Aktor bei Unterschreiten der eingestellten Luftfeuchtigkeitssschwelle ein. Im Modus 'Trocknen' wird er entsprechend beim %DCberschreiten der eingestellten Luftfeuchtigkeitsschwelle eingeschaltet.<br/><br/>" +
      "Mit der Hysterese kann gesteuert werden, um wie viel % rF die Soll-Temperatur %FCber- bzw. unterschritten werden muss, damit der Aktor wieder ausschaltet.<br/><br/>" +
      "Dieser Parameter dient zur Festlegung der Hysterese im Bereich von 1 % bis 10 %.",

    "HEATING_COOLING_A" :
      "Ist der Wandthermostat als Thermostat-Schalter konfiguriert, kann das Ger%E4t in Verbindung mit einem Schaltaktor als Zweipunktregler f%FCr eine Temperaturregelung eingesetzt werden. " +
      "Mit diesem Parameter wird festgelegt, ob das Ger%E4t im Heiz-Modus oder im K%FChl-Modus betrieben werden soll. " +
      "Im Modus 'Heizen' wird der Schaltaktor bei Unterschreiten der Soll-Temperatur eingeschaltet. Im Modus 'K%FChlen' wird er bei %FCberschreiten der Soll-Temperatur eingeschaltet. " +
      "Ist 'Heizen' und 'K%FChlen' ausgew%E4hlt, kann der Modus %FCber ein Zentralen-Programm gesteuert und ge%E4ndert werden.<br/><br/>" +
      "Ist der Wandthermostat als Hygrostat-Schalter konfiguriert, kann das Ger%E4t in Verbindung mit einem Schaltaktor als Zweipunktregler f%DCr eine Luftfeuchtigkeitsregelung genutzt werden. Mit diesem Parameter wird festgelegt, ob das Ger%E4t im Trocknen-Modus oder im Befeuchten-Modus betrieben werden soll. " +
      "Im Modes 'Trocknen' wird der Schaltaktor bei %DCberschreiten der eingestellten Luftfeuchtigkeitsschwelle eingeschaltet. Im Modus 'Befeuchten' wird er bei Unterschreiten der Luftfeuchtigkeitsschwelle eingeschaltet. " +
      "Ist 'Trocknen' und 'Befeuchten' ausgew%E4hlt, kann der Modus %DCber ein Zentralen-Programm gesteuert und ge%E4ndert werden.",

    "HUMIDITY_LIMIT_VALUE" :
      "Wird das Ger%E4t als Hygrostat-Schalter verwendet, kann mit diesem Parameter die Luftfeuchtigkeitsschwelle eingestellt werden.<br/><br/>" +
      "Beachten Sie hierzu auch den Parameter zur Hysterese.",

    "CLIMATE_CONTROL_TYPE" :
      "Mit diesem Parameter legen Sie die Art der Fu%DFboden-Temperaturregelung fest.<br/><br/>" +
      "Zur Auswahl stehen die klassische Zweipunktregelung und die PWM-Regelung." ,

    "noMore" : ""

  },

  "en" : {
    "HelpTitle" : "Help",
    "BURST_RX" : "BURST_RX<br/><br/>Help text",
    "BUTTON_LOCK" : "Operation of the device can be locked to avoid unintended changes, e.g. through involuntary touch. The local operating lock will lock the operation on the device.<br/><br/>It can be deactivated via the device itself.",
    "GLOBAL_BUTTON_LOCK" : "Operation of the device can be locked to avoid unintended changes, e.g. through involuntary touch.<br/><br/>The global operating lock will lock the operation on the device and can only be deactivated via the WebUI (not via the device itself).",
    "MODUS_BUTTON_LOCK" : "If the mode operating lock is activated the device can be operated only in the mode that is currently set. The operating mode (auto, manu, holiday or boost) can not be changed and can only be deactivated via the WebUI (not via the device itself).",
    //TODO activate with homematic version 2.8 (party)
    //"TEMPERATUREFALL_MODUS" : "You can individually adjust the mode settings of the temperature<br/>fall detection here.<br/><br/><ul><li>Inactive: Temperature fall detection inactive</li><li>Auto mode: Temperature fall detection only active in auto mode</li><li>Auto + manu mode: Temperature fall detection only active in auto and manu mode</li><li>Auto + party mode: Temperature fall detection only active in auto and party mode</li><li>Active: Temperature fall detection active in all modes (default)</li></ul>",
    "TEMPERATUREFALL_MODUS" : "You can individually adjust the mode settings of the temperature<br/>fall detection here.<br/><br/><ul><li>Inactive: Temperature fall detection inactive</li><li>Auto mode: Temperature fall detection only active in auto mode</li><li>Auto + manu mode: Temperature fall detection only active in auto and manu mode</li><li>Active: Temperature fall detection active in all modes (default)</li></ul>",
    "TEMPERATUREFALL_WINDOW_OPEN_TIME_PERIOD" : "You can adjust the duration of the temperature fall detection here.<br/><br/>This function is not possible in connection with a HomeMatic Window Contact.",
    "DECALCIFICATION_TIME" : "The radiator thermostat can be protected against valve calcification automatically. Therefore, an automatic routine descaling is performed once a week. The valve completely opens and closes once. This avoids that the valve pin gets stuck due to calcification. During this period, operation is not possible.<br/><br>Routine descaling is factory-set to run once a week on Saturdays at 11:00 h. You can individually adjust the time and date for the routine descaling here.",
    "TEMPERATURE_OFFSET" : "As the temperature is measured on the radiator, the temperature distribution can vary throughout a room. To adjust this, a temperature offset of &plusmn;3.5&#176;C can be set.<br/><br/>If a temperature of e.g.18&#176;C is measured instead of the set 20&#176;C, an offset temperature of -2.0&#176;C can be set. An offset temperature of 0.0&#176;C is set in the factory settings.<br/><br/>You can individually adjust the offset temperature here.",
    "BOOST_TIME_PERIOD" : "With the boost function, cool rooms can be heated within short at the touch of a button. When the function is activated, the heating valve opens immediately for 5 minutes at 80% (factory setting).<br/><br/>You can individually adjust the duration of the boost function here.",
    "BOOST_POSITION" : "With the boost function, cool rooms can be heated within short at the touch of a button. When the function is activated, the heating valve opens immediatelyfor 5 minutes at 80% (factory setting).<br/><br/>You can individually adjust the valve opening during the boost function here.",
    "BOOST_AFTER_WINDOW_OPEN" : "Here, you can activate automatic triggering of the boost function after open windows have been detected and closed again.",
    "VALVE_OFFSET" : "If several radiators in one room are operated with a HomeMatic Radiator Thermostat some radiators may heat more than others. In certain cases, some radiators might be hot while others are still cold.<br/><br/>To compensate this, a valve offset can be set for the radiator thermostat that is mounted on the cold radiator.  A valve offset of 0% is set in the factory settings.<br/><br/>You can individually adjust the value here (0 to 100 %).",
    "VALVE_ERROR_RUN_POSITION" : "If an empty battery has not been recognized, the radiator thermostat moves back into a \"valve error position\". This avoids, that the room temperature will cool down completely. A valve error position of 15 % is set in the factory settings.<br/><br/>You can individually adjust the value here (0 to 100 %).",
    "VALVE_MAXIMUM_POSITION" : "A maximum valve opening of 100% is set in the factory settings.<br/><br/>You can individually adjust the maximum valve opening position<br/>(0-100 %) here.",
    "MANU_MODE_PRIORITIZATION" : "You can adjust the prioritization of the functions in manu mode here:<br/><br/><ul><li><b>Setpoint temp. changes via RT, WT, WC</b>:<ul><li>Setpoint temp. changes can only be performed via the radiator thermostat, wall thermostat, window contact or the device itself (default). </li></ul></li><li><b>Setpoint temp. changes via CP</b>:<ul><li>Setpoint temp. changes can be performed via every known connection partner. However, the last change of the setpoint temperature will have priority. Direct operation on the device itself will remain possible.</li></ul></li><li><b>Setpoint temperature via device</b>:<ul><li>Setpoint temperature changes can only be performed via the device itself.</li></ul></li><li><b>Setpoint temperature changes via CCU</b>:<ul><li>Setpoint temperature changes can only be performed via CCU.</li></ul></li><li><b>Setpoint temperature changes via RT, WT, CCU</b>:<ul><li>Setpoint temperature changes can only be performed via a radiator thermostat, wall thermostat and CCU or via the device itself.</li></ul></li></ul>",
    "PARTY_MODE_PRIORITIZATION" : "You can adjust the prioritization of the functions in party mode here:<br/><br/><ul><li><b>Setpoint temp. changes via RT, WT, WC</b>:<ul><li>Setpoint temp. changes can only be performed via the radiator thermostat, wall thermostat, window contact or the device itself (default). </li></ul></li><li><b>Setpoint temp. changes via CP</b>:<ul><li>Setpoint temp. changes can be performed via every known connection partner. However, the last change of the setpoint temperature will have priority. Direct operation on the device itself will remain possible.</li></ul></li><li><b>Setpoint temperature via device</b>:<ul><li>Setpoint temperature changes can only be performed via the device itself.</li></ul></li><li><b>Setpoint temperature changes via CCU</b>:<ul><li>Setpoint temperature changes can only be performed via CCU.</li></ul></li><li><b>Setpoint temperature changes via RT, WT, CCU</b>:<ul><li>Setpoint temperature changes can only be performed via a radiator thermostat, wall thermostat and CCU or via the device itself.</li></ul></li></ul>",

    "WEEK_PROGRAM_POINTER" : "Please select the weekly program you want to edit here.",
    "WEEK_PROGRAM_POINTER_group" : "Please select the weekly program you want to edit here.<br/><br/>Please note that the week profiles 4 - 6 are not available for all devices.",
    "TWO_POINT_HYSTERESIS" : "In connection with a switch actuator, the room thermostat can be used as on-off control.<br/><br/>The on-off control depends on the setpoint and actual temperature as well as the defined hysteresis.",
    "HEATING_COOLING" : "If the room thermostat is used as on-off control, you can define here whether you want to set the 'heating' or 'cooling' mode.<br/><br/>In heating mode, the switch actuator will be switched on if the setpoint temperature falls below threshold, in cooling mode the actuator will be switched on if the threshold is exceeded.",

    "HUMIDITY_LIMIT_DISABLE" : "With this parameter you can define, if the cooling should be interrupted during cooling mode, as soon as the humidity threshold is exceeded. This stops the humidity value from increasing further.",

    "DURATION_5MIN" : "If the thermostat is in auto mode, temperature will be changed with every switching time to the value defined. This parameter helps you to discontinue the automatism for a certain period of time. After the time has expired, the thermostat returns back to auto mode.<br><br/>" +
      "Time will be displayed in 5-minute steps. The highest value permitted is 720 minutes (12 hours).",

    "ACOUSTIC_ALARM_SIGNAL" : "With this parameter you can determine whether a failed adaptation run is to be signalled acoustically.",
    "CHANNEL_OPERATION_MODE" :
    "The radiator thermostats operate slower and therefore more quietly in whisper mode.<br/><br/>" +
    "This function results in 15–20 percent higher power consumption for the respective device. ",

    "CLIMATE_FUNCTION" : "This parameter determines whether the device is to be used as a thermostat or humidistat switch.",

    "TWO_POINT_HYSTERESIS_A" :
      "In heating mode, the actuator switches on when the temperature falls below the setpoint temperature. In cooling mode, it is switched on when the setpoint temperature is exceeded.<br/><br/>" +
      "The hysteresis can be used to control by how many K a reading must exceed or fall below the setpoint temperature for the actuator to switch off again.<br/><br/>" +
      "This parameter is used to define the hysteresis in the range from 0.2 K to 2.0 K.",

    "TWO_POINT_HYSTERESIS_HUMIDITY" :
      "In 'Humidify' mode, the actuator switches on when the air humidity falls below the set threshold. In 'Dry' mode, it is switched on when the set humidity threshold is exceeded.<br/><br/>" +
      "The hysteresis can be used to control by how much % RH a reading must exceed or fall below the setpoint temperature for the actuator to switch off again.<br/><br/>" +
      "This parameter is used to define the hysteresis in the range from 1 % to 10 %.",

    "HEATING_COOLING_A" :
      "If the wall thermostat is configured as a thermostat switch, the device can be used in conjunction with a switching actuator as a two-point controller for temperature control. This parameter determines whether the device is to be operated in heating or cooling mode. "  +
      "In 'Heat' mode, the switching actuator is switched on when the temperature falls below the setpoint temperature. In 'Cool' mode, it is switched on when the setpoint temperature is exceeded. " +
      "If 'Heat / Cool' is selected, the mode can be controlled and changed via a central program.<br/><br/>" +
      "If the wall thermostat is configured as a humidistat switch, the device can be used in conjunction with a switching actuator as a two-point controller for humidity control. This parameter determines whether the device is to be operated in drying mode or in humidifying mode. " +
      "In 'Dry' mode, the switching actuator is switched on when the set humidity threshold is exceeded. In 'Humidify' mode, it is switched on when the air humidity drops below the threshold.<br/><br/>" +
      "If 'Dry / Humidify' is selected, the mode can be controlled and changed via a central program.",

    "HUMIDITY_LIMIT_VALUE" :
      "If the device is used as a humidistat switch, the humidity threshold can be set with this parameter.<br/><br/>" +
      "Take into account the parameter for hysteresis.",

    "CLIMATE_CONTROL_TYPE" :
      "With this parameter, you define the type of floor temperature control.<br/><br/>" +
      "You can choose between the classic two-point control and PWM control." ,
    "noMore" : ""

  }
});

