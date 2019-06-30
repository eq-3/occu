jQuery.extend(true,langJSON, {

  "de" : {
    "HelpTitle" : "Hilfe",
    "SERIAL_FORMAT" :
      "Standardeinstellung nach Norm:<br /> "+
      "1 Startbit, 7 Datenbits, 1 Parit&auml;tsbit (gerade Parit&auml;t), 1 Stoppbit<br /><br />"+

      "Weitere Einstellungsm&ouml;glichkeiten:<br />"+
      "1 Startbit, 7 Datenbits, 1 Parit&auml;tsbit (gerade Parit&auml;t), 2 Stoppbits<br />"+
      "1 Startbit, 8 Datenbits, 0 Parit&auml;tsbit (keine Parit&auml;t), 1 Stoppbit<br />"+
      "1 Startbit, 8 Datenbits, 1 Parit&auml;tsbit (gerade Parit&auml;t), 1 Stoppbit<br />",

    "SERIAL_FORMAT_V2" :
      "Standardeinstellung nach Norm f&uuml;r D0:<br /> "+
      "1 Startbit, 7 Datenbits, 1 Parit&auml;tsbit (gerade Parit&auml;t), 1 Stoppbit<br /><br />"+

      "F&uuml;r SML:<br />" +
      "1 Startbit, 8 Datenbits, 0 Parit&auml;tsbits (keine Parit&auml;t), 1 Stoppbit<br /><br />"+

      "Weitere Einstellungsm&ouml;glichkeiten:<br />"+
      "1 Startbit, 7 Datenbits, 1 Parit&auml;tsbit (gerade Parit&auml;t), 2 Stoppbits<br />"+
      "1 Startbit, 8 Datenbits, 1 Parit&auml;tsbit (gerade Parit&auml;t), 1 Stoppbit<br />",

    "SAMPLES_PER_CYCLE":
      "Das Ger&auml;t sendet die Daten zyklisch alle 2-3 Minuten. Falls das Senderaster zu langsam ist, weil z. B. ein Zentralenprogramm schneller reagieren soll, " +
      "k&ouml;nnen zus&auml;tzliche Datenabfragen pro Senderaster in Zusammenhang mit Schwellwerte f&uuml;r die Abweichung der Leistung beider Kan&auml;le " +
      "konfiguriert werden, die zus&auml;tzliche Sendungen ausl&ouml;sen.",

    "POWER_STRING_CH1" :
      "Standardeinstellung: 1-0:1.7<br />"+
      "1 --> Summe Wirkleistung +<br />"+
      "7 --> Momentanwert<br /><br />"+

      "Hinweis: Wenn von dem Z&auml;hler die Wirkleistungen der einzelnen Phasen nicht zusammen in einer Kennzahl &uuml;bertragen werden, k&ouml;nnen hier die Messgr&ouml;&szlig;en von mehreren Phasen zusammengefasst werden.<br /><br />"+

      "Beispieleinstellung: 1-0:21|41|61.7<br />"+
      "21 --> L1 Wirkleistung +<br />"+
      "41 --> L2 Wirkleistung +<br />"+
      "61 --> L3 Wirkleistung +<br />"+
      "7 --> Momentanwert",

    "POWER_STRING_CH1_V2" :
      "Standardeinstellung: 1.7.0<br />"+
      "1 --> Wirkleistung alle Phasen + (Bezug)<br />"+
      "7 --> Momentanwert<br /><br />"+

      "Hinweis: Wenn von dem Z&auml;hler die Wirkleistungen der einzelnen Phasen nicht zusammen in einer Kennzahl &uuml;bertragen werden, k&ouml;nnen hier die Messgr&ouml;&szlig;en von mehreren Phasen zusammengefasst werden.<br /><br />"+

      "Beispieleinstellung: 21|41|61.7.0<br />"+
      "21 --> L1 Wirkleistung +<br />"+
      "41 --> L2 Wirkleistung +<br />"+
      "61 --> L3 Wirkleistung +<br />"+
      "7 --> Momentanwert",

    "ENERGY_COUNTER_STRING_CH1" :
      "Standardeinstellung: 1-0:1.8<br />"+
      "1 --> Summe Wirkleistung +<br />"+
      "8 --> Z&auml;hlerstand",

    "ENERGY_COUNTER_STRING_CH1_V2" :
      "Standardeinstellung: 1.8.0<br />"+
      "1 --> Wirkleistung alle Phasen + (Bezug) <br />"+
      "8 --> Integral &uuml;ber die Zeit = Z&auml;hlerstand",

    "POWER_STRING_CH2" :
      "Standardeinstellung: 1-0:2.7<br />"+
      "2 --> Summe Wirkleistung -<br />"+
      "7 --> Momentanwert<br /><br />"+

      "Hinweis: Wenn von dem Z&auml;hler die Wirkleistungen der einzelnen Phasen nicht zusammen in einer Kennzahl &uuml;bertragen werden, "+
      "k&ouml;nnen hier die Messgr&ouml;&szlig;en von mehreren Phasen zusammengefasst werden.<br /><br />"+

      "Beispieleinstellung: 1-0:22|42|62.7<br />"+
      "22 --> L1 Wirkleistung -<br />"+
      "42 --> L2 Wirkleistung -<br />"+
      "62 --> L3 Wirkleistung -<br />"+
      "7 --> Momentanwert",

    "POWER_STRING_CH2_V2" :
      "Standardeinstellung: 2.7.0<br />"+
      "2 --> Wirkleistung alle Phasen - (Geliefert)<br />"+
      "7 --> Momentanwert<br /><br />"+

      "Hinweis: Wenn von dem Z&auml;hler die Wirkleistungen der einzelnen Phasen nicht zusammen in einer Kennzahl &uuml;bertragen werden, k&ouml;nnen hier die Messgr&ouml;&szlig;en von mehreren Phasen zusammengefasst werden.<br /><br />"+

      "Beispieleinstellung: 22|42|62.7.0<br />"+
      "22 --> L1 Wirkleistung +<br />"+
      "42 --> L2 Wirkleistung +<br />"+
      "62 --> L3 Wirkleistung +<br />"+
      "7 --> Momentanwert",

    "ENERGY_COUNTER_STRING_CH2" :
      "Standardeinstellung: 1-0:2.8<br />"+
      "2 --> Summe Wirkleistung -<br />"+
      "8 --> Z&auml;hlerstand",

    "ENERGY_COUNTER_STRING_CH2_V2" :
      "Standardeinstellung: 2.8.0<br />"+
      "2 --> Wirkleistung alle Phasen - (Geliefert)<br />"+
      "8 --> Integral &uuml;ber die Zeit = Z&auml;hlerstand"

  },
  "en" :{
    "HelpTitle" : "Help",

    "SERIAL_FORMAT" :
      "Default setting according to standard:<br / >"+
      "1 start bit, 7 data bits, 1 parity bit (even parity), 1 stop bit<br /><br />"+

      "Further setting options are:<br / >"+
      "1 start bit, 7 data bits, 1 parity bit (even parity), 2 stop bits<br / >"+
      "1 start bit, 8 data bits, 0 parity bit (no parity), 1 stop bit<br / >"+
      "1 start bit, 8 data bits, 1 parity bit (even parity), 1 stop bit",

    "SERIAL_FORMAT_V2" :
      "Default setting for D0 according to standard:<br / >"+
      "1 start bit, 7 data bits, 1 parity bit (even parity), 1 stop bit<br /><br />"+

      "Settings for SML:<br />" +
      "1 start bit, 8 data bits, 0 parity bit (no parity), 1 stop bit<br /><br />"+

      "Further setting options are:<br / >"+
      "1 start bit, 7 data bits, 1 parity bit (even parity), 2 stop bits<br / >"+
      "1 start bit, 8 data bits, 1 parity bit (even parity), 1 stop bit",

    "SAMPLES_PER_CYCLE":
      "The device cyclically transmits the data every 2-3 minutes. If the transmission interval is too slow because e.g. a central control unit program is supposed to "+
      "react faster, you can configure additional data requests per transmission interval relating to threshold values for deviation of power of both channels that "+
      "trigger additional transmissions.",

    "POWER_STRING_CH1" :
      "Default setting: 1-0:1.7<br />" +
      "1 --> sum of effective power +<br />" +
      "7 --> current value<br />" +

      "Please note: If the meter does not transfer the effective power of the single phases in one key figure, "+
      "the measured values of several phases can be summarised here.<br /><br />"+

      "Example setting: 1-0:21|41|61.7<br />"+
      "21 --> L1 effective power +<br />"+
      "41 --> L2 effective power +<br />"+
      "61 --> L3 effective power +<br />"+
      "7 --> current value<br />",

    "POWER_STRING_CH1_V2" :
      "Default setting: 1.7.0<br />"+
      "1 --> effective power all phases + (reference)<br />"+
      "7 --> current value<br /><br />"+

      "Please note: If the meter does not transfer the effective power of the single phases in one key figure, "+
      "the measured values of several phases can be summarised here.<br /><br />"+

      "Example setting: 21|41|61.7.0<br />"+
      "21 --> L1 effective power +<br />"+
      "41 --> L2 effective power +<br />"+
      "61 --> L3 effective power +<br />"+
      "7 --> current value",

    "ENERGY_COUNTER_STRING_CH1" :
      "Default setting: 1-0:1.8<br />"+
      "1 --> sum of effective power +<br />"+
      "8 --> meter reading<br />",

    "ENERGY_COUNTER_STRING_CH1_V2" :
      "Default setting: 1.8.0<br />"+
      "1 --> effective power all phases + (receiving)<br />"+
      "8 --> integral over time = meter reading",

    "POWER_STRING_CH2" :
      "Default setting: 1-0:2.7<br />"+
      "2 --> sum of effective power -<br />"+
      "7 --> current value<br /><br />"+

      "Please note: If the meter does not transfer the effective power of the single phases in one key figure, "+
      "the measured values of several phases can be summarised here."+

      "Example setting: 1-0:22|43|62.7<br />"+
      "22 --> L1 effective power -<br />"+
      "42 --> L2 effective power -<br />"+
      "62 --> L3 effective power -<br />"+
      "7 --> current value<br />",

    "POWER_STRING_CH2_V2" :
      "Default setting: 2.7.0<br />"+
      "2 --> sum of effective power - (supplied)<br />"+
      "7 --> current value<br /><br />"+

      "Please note: If the meter does not transfer the effective power of the single phases in one key figure, "+
      "the measured values of several phases can be summarised here."+

      "Example setting: 22|42|62.7.0<br />"+
      "22 --> L1 effective power -<br />"+
      "42 --> L2 effective power -<br />"+
      "62 --> L3 effective power -<br />"+
      "7 --> current value<br />",

    "ENERGY_COUNTER_STRING_CH2" :
      "Default setting: 1-0:2.8<br />"+
      "2 --> sum of effective power -<br />"+
      "8 --> meter reading<br />",

    "ENERGY_COUNTER_STRING_CH2_V2" :
      "Default setting: 2.8.0<br />"+
      "2 --> sum of effective power - (supplied)<br />"+
      "8 --> integral over time = meter reading<br />"

  }
});