#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set NOP 0
set ON_DELAY 1
set RAMP_ON 2
set ON 3
set OFF_DELAY 4
set RAMP_OFF 5
set OFF 6
set REFON 7
set REFOFF 8

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${OpenUp}"
set PROFILES_MAP(2)  "\${CloseDown}"
set PROFILES_MAP(3)  "\${OpenClose_UpDown}"
set PROFILES_MAP(4)  "\${TargetPosition}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

set PROFILE_1(LONG_COND_VALUE_LO) 50
set PROFILE_1(LONG_CT_OFF) 0
set PROFILE_1(LONG_CT_OFFDELAY) 0
set PROFILE_1(LONG_CT_ON) 0
set PROFILE_1(LONG_CT_ONDELAY) 0
set PROFILE_1(LONG_CT_RAMPOFF) 0
set PROFILE_1(LONG_CT_RAMPON) 0
set PROFILE_1(LONG_CT_REFOFF) 0
set PROFILE_1(LONG_CT_REFON) 0
set PROFILE_1(LONG_DRIVING_MODE) 0
set PROFILE_1(LONG_JT_OFF) 1
set PROFILE_1(LONG_JT_OFFDELAY) 1
set PROFILE_1(LONG_JT_ON) 1
set PROFILE_1(LONG_JT_ONDELAY) 7
set PROFILE_1(LONG_JT_RAMPOFF) 6
set PROFILE_1(LONG_JT_RAMPON) 2
set PROFILE_1(LONG_JT_REFOFF) 6
set PROFILE_1(LONG_JT_REFON) 2
set PROFILE_1(LONG_MAX_TIME_FIRST_DIR) {0.1 range 0.0 - 25.5}
set PROFILE_1(LONG_MULTIEXECUTE) 1
set PROFILE_1(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(LONG_OFF_LEVEL) 0.000000
set PROFILE_1(LONG_OFF_LEVEL_2) 1.010000
set PROFILE_1(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(LONG_OFF_TIME_MODE) 0
set PROFILE_1(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(LONG_ON_LEVEL) 1.000000
set PROFILE_1(LONG_ON_LEVEL_2) 1.010000
set PROFILE_1(LONG_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(LONG_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(LONG_ON_TIME_MODE) 0
set PROFILE_1(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_1(SHORT_COND_VALUE_HI) 100
set PROFILE_1(SHORT_COND_VALUE_LO) 50
set PROFILE_1(SHORT_CT_OFF)       {1 2 5}
set PROFILE_1(SHORT_CT_OFFDELAY)  {1 2 5}
set PROFILE_1(SHORT_CT_ON)        {1 2 5}
set PROFILE_1(SHORT_CT_ONDELAY)   {1 2 5}
set PROFILE_1(SHORT_CT_RAMPOFF)   {1 2 5}
set PROFILE_1(SHORT_CT_RAMPON)    {1 2 5}
set PROFILE_1(SHORT_CT_REFOFF)    0
set PROFILE_1(SHORT_CT_REFON)     0
set PROFILE_1(SHORT_DRIVING_MODE) 0
set PROFILE_1(SHORT_JT_OFF)       $ON_DELAY
set PROFILE_1(SHORT_JT_OFFDELAY)  $ON
set PROFILE_1(SHORT_JT_ON)        $ON_DELAY
set PROFILE_1(SHORT_JT_ONDELAY)   $ON_DELAY
set PROFILE_1(SHORT_JT_RAMPOFF)   $OFF
set PROFILE_1(SHORT_JT_RAMPON)    $ON
set PROFILE_1(SHORT_JT_REFOFF)    $REFOFF
set PROFILE_1(SHORT_JT_REFON)     $REFON
set PROFILE_1(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_1(SHORT_MULTIEXECUTE) 0
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_LEVEL) 0.000000
set PROFILE_1(SHORT_OFF_LEVEL_2) 1.010000
set PROFILE_1(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_MODE) 0
set PROFILE_1(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_ON_LEVEL) 1.000000
set PROFILE_1(SHORT_ON_LEVEL_2) 1.010000
set PROFILE_1(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE) 0
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(UI_DESCRIPTION) ""
set PROFILE_1(UI_TEMPLATE)  $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_COND_VALUE_HI) 100
set PROFILE_2(LONG_COND_VALUE_LO) 50
set PROFILE_2(LONG_CT_OFF) 0
set PROFILE_2(LONG_CT_OFFDELAY) 0
set PROFILE_2(LONG_CT_ON) 0
set PROFILE_2(LONG_CT_ONDELAY) 0
set PROFILE_2(LONG_CT_RAMPOFF) 0
set PROFILE_2(LONG_CT_RAMPON) 0
set PROFILE_2(LONG_CT_REFOFF) 0
set PROFILE_2(LONG_CT_REFON) 0
set PROFILE_2(LONG_DRIVING_MODE) 0
set PROFILE_2(LONG_JT_OFF) 4
set PROFILE_2(LONG_JT_OFFDELAY) 8
set PROFILE_2(LONG_JT_ON) 4
set PROFILE_2(LONG_JT_ONDELAY) 4
set PROFILE_2(LONG_JT_RAMPOFF) 5
set PROFILE_2(LONG_JT_RAMPON) 3
set PROFILE_2(LONG_JT_REFOFF) 5
set PROFILE_2(LONG_JT_REFON) 3
set PROFILE_2(LONG_MAX_TIME_FIRST_DIR) {0.1 range 0.0 - 25.5}
set PROFILE_2(LONG_MULTIEXECUTE) 1
set PROFILE_2(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(LONG_OFF_LEVEL) 0.000000
set PROFILE_2(LONG_OFF_LEVEL_2) 1.010000
set PROFILE_2(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(LONG_OFF_TIME_MODE) 0
set PROFILE_2(LONG_ONDELAY_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(LONG_ON_LEVEL) 1.000000
set PROFILE_2(LONG_ON_LEVEL_2) 1.010000
set PROFILE_2(LONG_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(LONG_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(LONG_ON_TIME_MODE) 0
set PROFILE_2(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_2(SHORT_COND_VALUE_HI) 100
set PROFILE_2(SHORT_COND_VALUE_LO) 50
set PROFILE_2(SHORT_CT_OFF) {1 2 5}
set PROFILE_2(SHORT_CT_OFFDELAY) {1 2 5}
set PROFILE_2(SHORT_CT_ON) {1 2 5}
set PROFILE_2(SHORT_CT_ONDELAY) {1 2 5}
set PROFILE_2(SHORT_CT_RAMPOFF) {1 2 5}
set PROFILE_2(SHORT_CT_RAMPON) {1 2 5}
set PROFILE_2(SHORT_CT_REFOFF) 0
set PROFILE_2(SHORT_CT_REFON) 0
set PROFILE_2(SHORT_DRIVING_MODE) 0
set PROFILE_2(SHORT_JT_OFF)       $OFF_DELAY
set PROFILE_2(SHORT_JT_OFFDELAY)  $OFF_DELAY
set PROFILE_2(SHORT_JT_ON)        [subst {$ON_DELAY $OFF_DELAY}]
set PROFILE_2(SHORT_JT_ONDELAY)   $OFF
set PROFILE_2(SHORT_JT_RAMPOFF)   $OFF
set PROFILE_2(SHORT_JT_RAMPON)    $ON
set PROFILE_2(SHORT_JT_REFOFF)    $REFOFF
set PROFILE_2(SHORT_JT_REFON)     $REFON
set PROFILE_2(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_2(SHORT_MULTIEXECUTE) 0
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_LEVEL) 0.000000
set PROFILE_2(SHORT_OFF_LEVEL_2) 1.010000
set PROFILE_2(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_MODE) 0
set PROFILE_2(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_ON_LEVEL) 1.000000
set PROFILE_2(SHORT_ON_LEVEL_2) 1.010000
set PROFILE_2(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE) 0
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_2(UI_DESCRIPTION) ""
set PROFILE_2(UI_TEMPLATE)  $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(LONG_COND_VALUE_HI) {100 150}
set PROFILE_3(LONG_COND_VALUE_LO) 50
set PROFILE_3(LONG_CT_OFF) 0
set PROFILE_3(LONG_CT_OFFDELAY) 0
set PROFILE_3(LONG_CT_ON) 0
set PROFILE_3(LONG_CT_ONDELAY) 0
set PROFILE_3(LONG_CT_RAMPOFF) 0
set PROFILE_3(LONG_CT_RAMPON) 0
set PROFILE_3(LONG_CT_REFOFF) 0
set PROFILE_3(LONG_CT_REFON) 0
set PROFILE_3(LONG_DRIVING_MODE) {0 1 2 3}
set PROFILE_3(LONG_JT_OFF) 1
set PROFILE_3(LONG_JT_OFFDELAY) 8
set PROFILE_3(LONG_JT_ON) 4
set PROFILE_3(LONG_JT_ONDELAY) 7
set PROFILE_3(LONG_JT_RAMPOFF) 6
set PROFILE_3(LONG_JT_RAMPON) 3
set PROFILE_3(LONG_JT_REFOFF) 6
set PROFILE_3(LONG_JT_REFON) 3
set PROFILE_3(LONG_MAX_TIME_FIRST_DIR) {0.1 range 0.0 - 25.5}
set PROFILE_3(LONG_MULTIEXECUTE) 1
set PROFILE_3(LONG_OFFDELAY_TIME_BASE) 0
set PROFILE_3(LONG_OFFDELAY_TIME_FACTOR) 0
set PROFILE_3(LONG_OFF_LEVEL) 0.000000
set PROFILE_3(LONG_OFF_LEVEL_2) 1.010000
set PROFILE_3(LONG_OFF_TIME_BASE) 7
set PROFILE_3(LONG_OFF_TIME_FACTOR) 31
set PROFILE_3(LONG_OFF_TIME_MODE) 0
set PROFILE_3(LONG_ONDELAY_TIME_BASE) 0
set PROFILE_3(LONG_ONDELAY_TIME_FACTOR) 0
set PROFILE_3(LONG_ON_LEVEL) 1.000000
set PROFILE_3(LONG_ON_LEVEL_2) 1.010000
set PROFILE_3(LONG_ON_TIME_BASE) 7
set PROFILE_3(LONG_ON_TIME_FACTOR) 31
set PROFILE_3(LONG_ON_TIME_MODE) 0
set PROFILE_3(LONG_PROFILE_ACTION_TYPE) {1 5}
set PROFILE_3(SHORT_COND_VALUE_HI) {100 150}
set PROFILE_3(SHORT_COND_VALUE_LO) 50
set PROFILE_3(SHORT_CT_OFF) {0 1 2 5}
set PROFILE_3(SHORT_CT_OFFDELAY) {0 1 2 5}
set PROFILE_3(SHORT_CT_ON) {0 1 2 5}
set PROFILE_3(SHORT_CT_ONDELAY) {0 1 2 5}
set PROFILE_3(SHORT_CT_RAMPOFF) {0 1 2 5}
set PROFILE_3(SHORT_CT_RAMPON) {0 1 2 5}
set PROFILE_3(SHORT_CT_REFOFF) 0
set PROFILE_3(SHORT_CT_REFON) 0
set PROFILE_3(SHORT_DRIVING_MODE) 0
set PROFILE_3(SHORT_JT_OFF)       [subst {$ON_DELAY}]
set PROFILE_3(SHORT_JT_OFFDELAY)  [subst {$OFF_DELAY $REFOFF}]
set PROFILE_3(SHORT_JT_ON)        [subst {$ON_DELAY $OFF_DELAY}]
set PROFILE_3(SHORT_JT_ONDELAY)   [subst {$ON_DELAY $REFON}]
set PROFILE_3(SHORT_JT_RAMPOFF)   $OFF
set PROFILE_3(SHORT_JT_RAMPON)    $ON
set PROFILE_3(SHORT_JT_REFOFF)    [subst {$REFON $OFF}]
set PROFILE_3(SHORT_JT_REFON)     [subst {$REFOFF $ON}]
set PROFILE_3(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_3(SHORT_MULTIEXECUTE) 0
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_OFF_LEVEL) 0.000000
set PROFILE_3(SHORT_OFF_LEVEL_2) 1.010000
set PROFILE_3(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE) 0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_ON_LEVEL) 1.000000
set PROFILE_3(SHORT_ON_LEVEL_2) 1.010000
set PROFILE_3(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE) 0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(UI_DESCRIPTION) ""
set PROFILE_3(UI_TEMPLATE)  $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(LONG_COND_VALUE_HI) 100
set PROFILE_4(LONG_COND_VALUE_LO) 50
set PROFILE_4(LONG_CT_OFF) 0
set PROFILE_4(LONG_CT_OFFDELAY) 0
set PROFILE_4(LONG_CT_ON) 0
set PROFILE_4(LONG_CT_ONDELAY) 0
set PROFILE_4(LONG_CT_RAMPOFF) 0
set PROFILE_4(LONG_CT_RAMPON) 0
set PROFILE_4(LONG_CT_REFOFF) 0
set PROFILE_4(LONG_CT_REFON) 0
set PROFILE_4(LONG_DRIVING_MODE) 0
set PROFILE_4(LONG_JT_OFF)       [subst {$ON_DELAY $OFF_DELAY $RAMP_OFF}]
set PROFILE_4(LONG_JT_OFFDELAY)  [subst {$ON $OFF_DELAY}]
set PROFILE_4(LONG_JT_ON)        [subst {$ON_DELAY $OFF_DELAY $RAMP_ON}]
set PROFILE_4(LONG_JT_ONDELAY)   [subst {$ON_DELAY $OFF}]
set PROFILE_4(LONG_JT_RAMPOFF)   [subst {$ON $RAMP_OFF $RAMP_ON $RAMP_OFF}]
set PROFILE_4(LONG_JT_RAMPON)    [subst {$OFF $RAMP_OFF $RAMP_ON}]
set PROFILE_4(LONG_JT_REFOFF)    $REFOFF
set PROFILE_4(LONG_JT_REFON)     $REFON
set PROFILE_4(LONG_MAX_TIME_FIRST_DIR) {0.1 range 0.0 - 25.5}
set PROFILE_4(LONG_MULTIEXECUTE) 1
set PROFILE_4(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(LONG_OFF_LEVEL) 0.000000
set PROFILE_4(LONG_OFF_LEVEL_2) 1.010000
set PROFILE_4(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(LONG_OFF_TIME_MODE) 0
set PROFILE_4(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(LONG_ON_LEVEL) 1.000000
set PROFILE_4(LONG_ON_LEVEL_2) 1.010000
set PROFILE_4(LONG_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(LONG_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(LONG_ON_TIME_MODE) 0
set PROFILE_4(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_4(SHORT_COND_VALUE_HI) 100
set PROFILE_4(SHORT_COND_VALUE_LO) 50
set PROFILE_4(SHORT_CT_OFF) 0
set PROFILE_4(SHORT_CT_OFFDELAY) 0
set PROFILE_4(SHORT_CT_ON) 0
set PROFILE_4(SHORT_CT_ONDELAY) 0
set PROFILE_4(SHORT_CT_RAMPOFF) 0
set PROFILE_4(SHORT_CT_RAMPON) 0
set PROFILE_4(SHORT_CT_REFOFF) 0
set PROFILE_4(SHORT_CT_REFON) 0
set PROFILE_4(SHORT_DRIVING_MODE) {0 1 2 3}
set PROFILE_4(SHORT_JT_OFF)       [subst {$ON_DELAY $OFF_DELAY}]
set PROFILE_4(SHORT_JT_OFFDELAY)  [subst {$ON $OFF_DELAY}]
set PROFILE_4(SHORT_JT_ON)        [subst {$ON_DELAY $OFF_DELAY}]
set PROFILE_4(SHORT_JT_ONDELAY)   [subst {$ON_DELAY $OFF}]
set PROFILE_4(SHORT_JT_RAMPOFF)   $OFF
set PROFILE_4(SHORT_JT_RAMPON)    $ON
set PROFILE_4(SHORT_JT_REFOFF)    $REFOFF
set PROFILE_4(SHORT_JT_REFON)     $REFON
set PROFILE_4(SHORT_MAX_TIME_FIRST_DIR) 25.500000
set PROFILE_4(SHORT_MULTIEXECUTE) 0
set PROFILE_4(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.01}
set PROFILE_4(SHORT_OFF_LEVEL_2) {1.01 range 0.0 - 1.01}
set PROFILE_4(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(SHORT_OFF_TIME_MODE) 0
set PROFILE_4(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.01}
set PROFILE_4(SHORT_ON_LEVEL_2) {1.01 range 0.0 - 1.01}
set PROFILE_4(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_MODE) 0
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_4(UI_DESCRIPTION) ""
set PROFILE_4(UI_TEMPLATE)  $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4


# hier folgen die eventuellen Subsets
#set SUBSET_1(NAME)          "Hochgefahren"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(LONG_JT_OFF)      $ON_DELAY
set SUBSET_1(LONG_JT_OFFDELAY) $ON
set SUBSET_1(LONG_JT_ON)       $ON_DELAY
set SUBSET_1(LONG_JT_ONDELAY)  $ON_DELAY
set SUBSET_1(LONG_JT_RAMPOFF)  $RAMP_ON
set SUBSET_1(LONG_JT_RAMPON)   $RAMP_ON
set SUBSET_1(LONG_JT_REFOFF)   $REFOFF
set SUBSET_1(LONG_JT_REFON)    $REFON
set SUBSET_1(SHORT_JT_OFF)      $ON_DELAY
set SUBSET_1(SHORT_JT_OFFDELAY) $ON
set SUBSET_1(SHORT_JT_ON)       $ON_DELAY
set SUBSET_1(SHORT_JT_ONDELAY)  $ON_DELAY
set SUBSET_1(SHORT_JT_RAMPOFF)  $OFF
set SUBSET_1(SHORT_JT_RAMPON)   $ON
set SUBSET_1(SHORT_JT_REFOFF)   $REFOFF
set SUBSET_1(SHORT_JT_REFON)    $REFON

#set SUBSET_2(NAME)          "Runtergefahren"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(LONG_JT_OFF)        $OFF_DELAY
set SUBSET_2(LONG_JT_OFFDELAY)   $OFF_DELAY
set SUBSET_2(LONG_JT_ON)         $OFF_DELAY
set SUBSET_2(LONG_JT_ONDELAY)    $OFF
set SUBSET_2(LONG_JT_RAMPOFF)    $RAMP_OFF
set SUBSET_2(LONG_JT_RAMPON)     $RAMP_ON
set SUBSET_2(LONG_JT_REFOFF)     $REFOFF
set SUBSET_2(LONG_JT_REFON)      $REFON
set SUBSET_2(SHORT_JT_OFF)       $OFF_DELAY
set SUBSET_2(SHORT_JT_OFFDELAY)  $OFF_DELAY
set SUBSET_2(SHORT_JT_ON)        $OFF_DELAY
set SUBSET_2(SHORT_JT_ONDELAY)   $OFF
set SUBSET_2(SHORT_JT_RAMPOFF)   $OFF
set SUBSET_2(SHORT_JT_RAMPON)    $ON
set SUBSET_2(SHORT_JT_REFOFF)    $REFOFF
set SUBSET_2(SHORT_JT_REFON)     $REFON

#set SUBSET_3(NAME)          "Hoch-/Runtergefahren im Wechsel"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(LONG_JT_OFF)      $RAMP_OFF
set SUBSET_3(LONG_JT_OFFDELAY) $OFF_DELAY
set SUBSET_3(LONG_JT_ON)       $RAMP_ON
set SUBSET_3(LONG_JT_ONDELAY)  $ON_DELAY
set SUBSET_3(LONG_JT_RAMPOFF)  $RAMP_OFF
set SUBSET_3(LONG_JT_RAMPON)   $RAMP_ON
set SUBSET_3(LONG_JT_REFOFF)   $REFOFF
set SUBSET_3(LONG_JT_REFON)    $REFON
set SUBSET_3(SHORT_JT_OFF)      $ON_DELAY
set SUBSET_3(SHORT_JT_OFFDELAY) $OFF_DELAY
set SUBSET_3(SHORT_JT_ON)       $OFF_DELAY
set SUBSET_3(SHORT_JT_ONDELAY)  $ON_DELAY
set SUBSET_3(SHORT_JT_RAMPOFF)  $OFF
set SUBSET_3(SHORT_JT_RAMPON)   $ON
set SUBSET_3(SHORT_JT_REFOFF)   $REFOFF
set SUBSET_3(SHORT_JT_REFON)    $REFON


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url dev_descr_sender dev_descr_receiver

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set url $iface_url($iface)

  set device $dev_descr_sender(TYPE)
  set ch $dev_descr_sender(INDEX)

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }

  #global SUBSETS
  set name "x"
  set i 1
  while {$name != ""} {
    upvar SUBSET_$i SUBSET_$i
    array set subset [array get SUBSET_$i]
    set name ""
    catch {set name $subset(NAME)}
    array_clear subset
    incr i
  }

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

# die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('MULTI_MODE_INPUT_TRANSMITTER_4', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"



  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  #OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  #ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#3
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  #OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # The value of the parameter SHORT_JT_ON must always be 1 (ON_DELAY)
  if {$ps(SHORT_JT_ON) != 1} {
        # Set SHORT_JT_ON always to 1 = ON_DELAY - requirement of the developer US
        set shortJTON "{SHORT_JT_ON {int 1}}"
        set ps(SHORT_JT_ON) 1
        catch {puts "[xmlrpc $url putParamset [list string $address] [list string $dev_descr_sender(ADDRESS)] [list struct $shortJTON]]"}
        puts "<script type='text/javascript'>"
          puts "window.setTimeout(function() \{"
            puts "var expertJTON = jQuery(\"\[name='SHORT_JT_ON'\]\").first().val(1);"
          puts "\},100);"
        puts "</script>"
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#4 jalousie target position
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # parameter

  append HTML_PARAMS(separate_$prn) "<tr><td>\${JUMPTARGET}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn "onchange=\"BLIND_setPosition('separate_${special_input_id}_$prn\_$pref');jalousieShowSlatInputElem('separate_${special_input_id}_$prn\_$pref', $ch);\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DRIVING_MODE}</td><td>"
  array_clear options
  set options(0) "\${driving_mode_0}"
  set options(1) "\${driving_mode_1}"
  set options(2) "\${driving_mode_2}"
  set options(3) "\${driving_mode_3}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_DRIVING_MODE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_DRIVING_MODE "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"upLevel_${special_input_id}_$prn\_1\"><td>\${UP_LEVEL}</td>"
  append HTML_PARAMS(separate_$prn) "<td>"
  option BLIND_LEVEL
  #set options(1.005) "\${lastValue}"
  #set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_3 PROFILE_$prn SHORT_ON_LEVEL "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"downLevel_${special_input_id}_$prn\_1\"><td>\${DOWN_LEVEL}</td>"
  append HTML_PARAMS(separate_$prn) "<td>"
  option BLIND_LEVEL
  #set options(1.005) "\${lastValue}"
  #set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_4 PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG id=\"upTime_${special_input_id}_$prn\_1\"]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG id=\"downTime_${special_input_id}_$prn\_1\"]"

  # ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector UP_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG id=\"upDelayTime_${special_input_id}_$prn\_1\"]"

  # OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector DOWN_TIME_DELAY_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG id=\"downDelayTime_${special_input_id}_$prn\_1\"]"


  incr pref ;# 9
  append HTML_PARAMS(separate_$prn) "<tr id='jalousieSlatPosOff_$ch' class='hidden'><td>\${JALOUSIE_SLAT_POS_OFF}</td><td>"
  option BLIND_LEVEL
  # set options(1.005) "\${lastValue}"
  # set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL_2 separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL_2 "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 10
  append HTML_PARAMS(separate_$prn) "<tr id='jalousieSlatPosOn_$ch' class='hidden'><td>\${JALOUSIE_SLAT_POS_ON}</td><td>"
  option BLIND_LEVEL
  # set options(1.005) "\${lastValue}"
  # set options(1.010) "\${noModification}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL_2 separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL_2 "onchange=\"Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  append HTML_PARAMS(separate_$prn) "</td></tr>"


  # parameter end

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">window.setTimeout(function() {BLIND_setPosition('separate_${special_input_id}_$prn\_1');jalousieShowSlatInputElem('separate_${special_input_id}_$prn\_1', $ch);},200)</script>"

}

constructor
