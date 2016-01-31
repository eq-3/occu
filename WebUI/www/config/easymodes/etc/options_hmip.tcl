#!/bin/tclsh
proc option {type} {

# die Einheiten werden in der Datei easymodes/EnterFreeValue gesetzt

  upvar #0 unit_hour h
  upvar #0 unit_min m
  upvar #0 unit_sec s
  upvar #0 unit_perc p
  upvar #0 free_value Wert
  upvar options options
  array_clear options
  
  
  switch $type {

    "TIMEBASE_SHORT" {
        set options(0)    "100mS"
        set options(1)    "$s"
        set options(2)    "$m"
        set options(3)    "$h"

    }

      "TIMEBASE_LONG" {
        set options(0) "100mS"
        set options(1) "1$s"
        set options(2) "5$s"
        set options(3) "10$s"
        set options(4) "1$m"
        set options(5) "5$m"
        set options(6) "10$m"
        set options(7) "1$h"
       }

  }
}
