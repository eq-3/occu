#!/bin/tclsh

##
# style.cgi
# Benutzerdefinierte Farbgebung
##

##
# Template für CSS_Stile.
# Anstatt direkter Farbwerte enthält das Template Platzhalter nach folgendem
# Schema:
# .cssClass {
#   color: $_(black);
# }
# Die Platzhalter werden durch beim Aufruf ersetzt.
##
##set CSS_FILE   {/www/webui/style.css}

### Pfad durch env-Variable ersetzen
set CSS_FILE [file join $env(DOCUMENT_ROOT) webui/style.css]
##
# Farbtabellen.
# Je eine Datei nach folgendem Muster:
#   black  #000000
#   white  #ffffff
#   red    #ff0000
# Die optionale Farbtabelle (USER_COLOR_FILE) überschreibt die als Standard 
# (SYSTEM_COLOR_FILE) definierten Farben.
##

set SYSTEM_COLOR_FILE [file join $env(DOCUMENT_ROOT) webui/color.map]

## wird beim Konfigtool nicht verwendet
set USER_COLOR_FILE {/etc/config/color.map}

##
# Gibt den Inhalt einer Datei zurück.
##
proc loadFromFile { filename } {

  set content {}
  catch {
    set fd [open $filename r]
    set content [read $fd]
    close $fd
  }
  return $content
}

##
# Einsprungpunkt
##

  

array set _ [loadFromFile $SYSTEM_COLOR_FILE]
catch {array set _ [loadFromFile $USER_COLOR_FILE]}
set content [loadFromFile $CSS_FILE]

puts {Content-Type: text/css; charset="iso-8859-1"}
puts {}
puts [subst -nobackslashes -nocommands $content]
