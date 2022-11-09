#!/bin/tclsh

# This file isn't in use anymore an can be removed.

proc _option {type} {

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
        set options(0)    "100ms"
        set options(1)    "$s"
        set options(2)    "$m"
        set options(3)    "$h"

    }

    "TIMEBASE_LONG" {
      set options(0) "100ms"
      set options(1) "1$s"
      set options(2) "5$s"
      set options(3) "10$s"
      set options(4) "1$m"
      set options(5) "5$m"
      set options(6) "10$m"
      set options(7) "1$h"
     }

    "LOGIC_COMBINATION" {
      set options(0) "\${stringTableLogicInactive}"
      set options(1) "\${stringTableLogicOR}"
      set options(2) "\${stringTableLogicAND}"
      set options(3) "\${stringTableLogicXOR}"
      set options(4) "\${stringTableLogicNOR}"
      set options(5) "\${stringTableLogicNAND}"
      set options(6) "\${stringTableLogicORINVERS}"
      set options(7) "\${stringTableLogicANDINVERS}"
      set options(8) "\${stringTableLogicPLUS}"
      set options(9) "\${stringTableLogicMINUS}"
      set options(10) "\${stringTableLogicMUL}"
      set options(11) "\${stringTableLogicPLUSINVERS}"
      set options(12) "\${stringTableLogicMINUSINVERS}"
      set options(13) "\${stringTableLogicMULINVERS}"
      set options(14) "\${stringTableLogicINVERSPLUS}"
      set options(15) "\${stringTableLogicINVERSMINUS}"
      set options(16) "\${stringTableLogicINVERSMUL}"
    }

    "POWERUP_JUMPTARGET" {
      set options(0) "\${stringTableStateFalse}"
      set options(1) "\${stringTableOnDelay}"
      set options(2) "\${stringTableStateTrue}"
      #set options(3) "\${stringTableOffDelay}"
    }

    "CURRENTDETECTION_BEHAVIOR" {
      set options(0) "\${currentDetectionActive}"; # because not in use not yet translated
      set options(1) "\${currentDetectionInactiveValueOutput1}"; #because not in use not yet translated
      set options(2) "\${currentDetectionInactiveValueOutput1}"; #because not in use not yet translated
    }

  }

}




