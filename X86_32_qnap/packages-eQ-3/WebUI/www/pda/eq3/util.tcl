##
# util.tcl
# Allgemeine Hilfsmethoden
#
# (c) 2009
# eQ-3 Entwicklung GmbH
# Falk Werner
##

##
# array_clear
# Löscht alle Elemente in einem Array
##
proc array_clear {name} {
  upvar $name arr

  foreach key [array names arr] {
    unset arr($key)
  }
}
