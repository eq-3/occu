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

    "DELAY" {
        set options(0)    "\${none}"
        set options(5)    "5$s"
        set options(10)    "10$s"
        set options(30)    "30$s"
        set options(60)    "1$m"
        set options(120)  "2$m"
        set options(300)  "5$m"
        set options(600)  "10$m"
        set options(1800)  "30$m"
        set options(3600)  "1$h"
    }
 
    "LENGTH_OF_STAY" {
        set options(1)    "1$s"
        set options(2)    "2$s"
        set options(5)    "5$s"
        set options(10)    "10$s"
        set options(30)    "30$s"
        set options(60)    "1$m"
        set options(120)  "2$m"
        set options(300)  "5$m"
        set options(600)  "10$m"
        set options(900)  "15$m"
    }

    "LENGTH_OF_OFF" {
        set options(1)    "1$s"
        set options(2)    "2$s"
        set options(5)    "5$s"
        set options(10)    "10$s"
        set options(30)    "30$s"
        set options(60)    "1$m"
        set options(120)  "2$m"
        set options(300)  "5$m"
        set options(600)  "10$m"
        set options(900)  "15$m"
        set options(111600)	"\${unlimited}"
    }

  }
}
