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
        set options(99999999)  "\${enterValue}"
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
        set options(1800)  "30$m"
        set options(3600)  "1$h"
        set options(7200)  "2$h"
        set options(10800)  "3$h"
        set options(18000)  "5$h"
        set options(28800)  "8$h"
        set options(43200)  "12$h"
        set options(86400)  "24$h"
        set options(111600)  "\${unlimited}"
        set options(99999999)  "\${enterValue}"
    }
    
    "STAIRCASE"  {
        set options(60)  "1$m"
        set options(120)  "2$m"
        set options(300)  "5$m"
        set options(600)  "10$m"
        set options(1200)  "20$m"
        set options(1800)  "30$m"
        set options(99999999)  "\${enterValue}"
    }

    "BLIND_LEVEL" {
        set options(0.0) "0$p"
        set options(0.1) "10$p"
        set options(0.2) "20$p"
        set options(0.3) "30$p"
        set options(0.4) "40$p"
        set options(0.5) "50$p"
        set options(0.6) "60$p"
        set options(0.7) "70$p"
        set options(0.8) "80$p"
        set options(0.9) "90$p"
        set options(1.0) "100$p"
    }

    "DIM_ONLEVEL" {
        set options(0.1) "10$p"
        set options(0.2) "20$p"
        set options(0.3) "30$p"
        set options(0.4) "40$p"
        set options(0.5) "50$p"
        set options(0.6) "60$p"
        set options(0.7) "70$p"
        set options(0.8) "80$p"
        set options(0.9) "90$p"
        set options(1.0) "100$p"
        set options(1.005) "\${lastValue}"
        set options(99999998)  "\${enterValue}"
    }
    
    "DIM_OFFLEVEL" {
        set options(0.0) "0$p"
        set options(0.1) "10$p"
        set options(0.2) "20$p"
        set options(0.3) "30$p"
        set options(0.4) "40$p"
        set options(0.5) "50$p"
        set options(0.6) "60$p"
        set options(0.7) "70$p"
        set options(0.8) "80$p"
        set options(0.9) "90$p"
        set options(1.005) "\${lastValue}"
        set options(99999998)  "\${enterValue}"
    }
    
    "RAMPTIME" {
        set options(0)    "\${none}"
        set options(0.2)  "0.2$s"
        set options(0.5)  "0.5$s"
        set options(1)    "1$s"
        set options(2)    "2$s"
        set options(5)    "5$s"
        set options(10)    "10$s"
        set options(20)    "20$s"
        set options(30)    "30$s"
        set options(99999999)  "\${enterValue}"
    }
  
    "BLINK" {
        set options(0.1)  "0.1$s"
        set options(0.5)  "0.5$s"
        set options(1)    "1$s"
        set options(2)    "2$s"
        set options(5)    "5$s"
        set options(99999999)  "\${enterValue}"
    }
    
    "WINDOW_OPEN_LEVEL" {
        set options(0.1) "10$p"
        set options(0.2) "20$p"
        set options(0.3) "30$p"
        set options(0.4) "40$p"
        set options(0.5) "50$p"
        set options(0.6) "60$p"
        set options(0.7) "70$p"
        set options(0.8) "80$p"
        set options(0.9) "90$p"
        set options(1.0) "100$p"    
    }

    "WINDOW_OPEN_LEVEL_FREEVAL" {
        set options(99999998)  "\${enterValue}"
    }
    
    "WINDOW_RUNNING_SPEED" {
        set options(0.0) "\${minimal}"
        set options(0.1) "10$p"
        set options(0.2) "20$p"
        set options(0.3) "30$p"
        set options(0.4) "40$p"
        set options(0.5) "50$p"
        set options(0.6) "60$p"
        set options(0.7) "70$p"
        set options(0.8) "80$p"
        set options(0.9) "90$p"
        set options(1.0) "100$p"    
    }
    
    "WINDOW_OPEN_TIME"  {
        set options(600)  "10$m"
        set options(1200)  "20$m"
        set options(1800)  "30$m"
        set options(3600)  "1$h"
        set options(111600)  "\${unlimited}"
        set options(99999999)  "\${enterValue}"
    }
    
    "DOOR_LOCK_TIME" {
        set options(111600)    "\${inactive}"
        set options(60)      "\${after} 1$m"
        set options(180)    "\${after} 3$m"
        set options(300)    "\${after} 5$m"
        set options(600)    "\${after} 10$m"
        set options(900)    "\${after} 15$m"
        set options(3600)    "\${after} 1$h"
        set options(99999999)  "\${enterValue}"
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

    "SHORT_LONG" {
      set options(1) "\${short}"
      set options(2) "\${long}"
    }

    "CURRENTDETECTION_BEHAVIOR" {
      set options(0) "\${currentDetectionActive}"; # because not in use not yet translated
      set options(1) "\${currentDetectionInactiveValueOutput1}"; #because not in use not yet translated
      set options(2) "\${currentDetectionInactiveValueOutput1}"; #because not in use not yet translated
    }

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

proc garageDoorExtension {} {
  upvar options options
  upvar #0 unit_sec s
  set options(0.4) "0.4$s"
}