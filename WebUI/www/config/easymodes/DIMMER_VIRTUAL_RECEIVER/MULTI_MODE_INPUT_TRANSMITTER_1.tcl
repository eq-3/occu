#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/DIMMER_VIRTUAL_RECEIVER/getColorElement.tcl]

set PROFILES_MAP(0)   "\${expert}"
set PROFILES_MAP(1)   "\${dimmer_on_brighter}"
set PROFILES_MAP(2)   "\${dimmer_off_darker}"
set PROFILES_MAP(3)   "\${dimmer_on_off_b_d}"
set PROFILES_MAP(4)   "\${light_stairway}"
set PROFILES_MAP(5)  "\${not_active}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(LONG_COND_VALUE_HI) {150 100}
set PROFILE_1(LONG_COND_VALUE_LO) 50
set PROFILE_1(LONG_CT_OFF) 0
set PROFILE_1(LONG_CT_OFFDELAY) 0
set PROFILE_1(LONG_CT_ON) 0
set PROFILE_1(LONG_CT_ONDELAY) 0
set PROFILE_1(LONG_CT_RAMPOFF) 0
set PROFILE_1(LONG_CT_RAMPON) 0
set PROFILE_1(LONG_DIM_MAX_LEVEL) {1.0 range 0.0 - 1.0}
set PROFILE_1(LONG_DIM_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_1(LONG_DIM_STEP) 0.050000
set PROFILE_1(LONG_JT_OFF) 1
set PROFILE_1(LONG_JT_OFFDELAY) 2
set PROFILE_1(LONG_JT_ON) 2
set PROFILE_1(LONG_JT_ONDELAY) 2
set PROFILE_1(LONG_JT_RAMPOFF) 2
set PROFILE_1(LONG_JT_RAMPON) 3
set PROFILE_1(LONG_MULTIEXECUTE) 1
set PROFILE_1(LONG_OFFDELAY_BLINK) 1
set PROFILE_1(LONG_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_1(LONG_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_1(LONG_OFFDELAY_STEP) 0.050000
set PROFILE_1(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(LONG_OFF_LEVEL) 0.000000
set PROFILE_1(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(LONG_OFF_TIME_MODE) 0
set PROFILE_1(LONG_ONDELAY_MODE) 0
set PROFILE_1(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_1(LONG_ON_MIN_LEVEL) {0.1 range 0.0 - 1.0}
set PROFILE_1(LONG_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(LONG_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(LONG_ON_TIME_MODE) 0
set PROFILE_1(LONG_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_1(LONG_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_1(LONG_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_1(LONG_PROFILE_REPETITIONS) {0 range 0 - 255}
set PROFILE_1(LONG_PROFILE_ACTION_TYPE) {3 0}
set PROFILE_1(LONG_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_1(LONG_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_1(LONG_RAMP_START_STEP) 0.050000
set PROFILE_1(SHORT_COND_VALUE_HI) 150
set PROFILE_1(SHORT_COND_VALUE_LO) 50
set PROFILE_1(SHORT_CT_OFF) 0
set PROFILE_1(SHORT_CT_OFFDELAY) 0
set PROFILE_1(SHORT_CT_ON) 0
set PROFILE_1(SHORT_CT_ONDELAY) 0
set PROFILE_1(SHORT_CT_RAMPOFF) 0
set PROFILE_1(SHORT_CT_RAMPON) 0
set PROFILE_1(SHORT_DIM_MAX_LEVEL) {1.0 range 0.0 - 1.0}
set PROFILE_1(SHORT_DIM_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_1(SHORT_DIM_STEP) 0.050000
set PROFILE_1(SHORT_JT_OFF) 1
set PROFILE_1(SHORT_JT_OFFDELAY) 3
set PROFILE_1(SHORT_JT_ON) 3
set PROFILE_1(SHORT_JT_ONDELAY) 1
set PROFILE_1(SHORT_JT_RAMPOFF) 2
set PROFILE_1(SHORT_JT_RAMPON) 2
set PROFILE_1(SHORT_MULTIEXECUTE) 0
set PROFILE_1(SHORT_OFFDELAY_BLINK) {0 1}
set PROFILE_1(SHORT_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_1(SHORT_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_1(SHORT_OFFDELAY_STEP) 0.050000
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_LEVEL) 0.000000
set PROFILE_1(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_MODE) 0
set PROFILE_1(SHORT_ONDELAY_MODE) 0
set PROFILE_1(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_1(SHORT_ON_MIN_LEVEL) {0.1 range 0.0 - 1.0}
set PROFILE_1(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE) 0
set PROFILE_1(SHORT_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_1(SHORT_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_1(SHORT_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_1(SHORT_PROFILE_REPETITIONS) {0 range 0 - 255}
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(SHORT_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_1(SHORT_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_1(SHORT_RAMP_START_STEP) 0.050000
set PROFILE_1(UI_DESCRIPTION) "Mit einem kurzen Tastendruck wird das Licht auf die eingestellte Helligkeit eingeschaltet. Mit einem langen Tastendruck wird das Licht hochgedimmt."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_COND_VALUE_HI) {150 100}
set PROFILE_2(LONG_COND_VALUE_LO) 50
set PROFILE_2(LONG_CT_OFF) 0
set PROFILE_2(LONG_CT_OFFDELAY) 0
set PROFILE_2(LONG_CT_ON) 0
set PROFILE_2(LONG_CT_ONDELAY) 0
set PROFILE_2(LONG_CT_RAMPOFF) 0
set PROFILE_2(LONG_CT_RAMPON) 0
set PROFILE_2(LONG_DIM_MAX_LEVEL) {1.0 range 0.0 - 1.0}
set PROFILE_2(LONG_DIM_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_2(LONG_DIM_STEP) 0.050000
set PROFILE_2(LONG_JT_OFF) 6
set PROFILE_2(LONG_JT_OFFDELAY) 5
set PROFILE_2(LONG_JT_ON) 4
set PROFILE_2(LONG_JT_ONDELAY) 6
set PROFILE_2(LONG_JT_RAMPOFF) 6
set PROFILE_2(LONG_JT_RAMPON) 4
set PROFILE_2(LONG_MULTIEXECUTE) 1
set PROFILE_2(LONG_OFFDELAY_BLINK) {1 0}
set PROFILE_2(LONG_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_2(LONG_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_2(LONG_OFFDELAY_STEP) 0.050000
set PROFILE_2(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(LONG_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_2(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(LONG_OFF_TIME_MODE) 0
set PROFILE_2(LONG_ONDELAY_MODE) 0
set PROFILE_2(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(LONG_ON_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_2(LONG_ON_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_2(LONG_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(LONG_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(LONG_ON_TIME_MODE) 0
set PROFILE_2(LONG_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_2(LONG_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_2(LONG_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_2(LONG_PROFILE_ACTION_TYPE) {4 0}
set PROFILE_2(LONG_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_2(LONG_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_2(LONG_RAMP_START_STEP) 0.050000
set PROFILE_2(SHORT_COND_VALUE_HI) 150
set PROFILE_2(SHORT_COND_VALUE_LO) 50
set PROFILE_2(SHORT_CT_OFF) 0
set PROFILE_2(SHORT_CT_OFFDELAY) 0
set PROFILE_2(SHORT_CT_ON) 0
set PROFILE_2(SHORT_CT_ONDELAY) 0
set PROFILE_2(SHORT_CT_RAMPOFF) 0
set PROFILE_2(SHORT_CT_RAMPON) 0
set PROFILE_2(SHORT_DIM_MAX_LEVEL) {1.0 range 0.0 - 1.0}
set PROFILE_2(SHORT_DIM_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_2(SHORT_DIM_STEP) 0.050000
set PROFILE_2(SHORT_JT_OFF) 6
set PROFILE_2(SHORT_JT_OFFDELAY) 5
set PROFILE_2(SHORT_JT_ON) 4
set PROFILE_2(SHORT_JT_ONDELAY) 6
set PROFILE_2(SHORT_JT_RAMPOFF) 6
set PROFILE_2(SHORT_JT_RAMPON) 4
set PROFILE_2(SHORT_MULTIEXECUTE) 0
set PROFILE_2(SHORT_OFFDELAY_BLINK) {1 0}
set PROFILE_2(SHORT_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_2(SHORT_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_2(SHORT_OFFDELAY_STEP) 0.050000
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_LEVEL) 0.000000
set PROFILE_2(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_MODE) 0
set PROFILE_2(SHORT_ONDELAY_MODE) 0
set PROFILE_2(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_2(SHORT_ON_MIN_LEVEL) {0.1 range 0.0 - 1.0}
set PROFILE_2(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE) 0
set PROFILE_2(SHORT_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_2(SHORT_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_2(SHORT_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_2(SHORT_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_2(SHORT_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_2(SHORT_RAMP_START_STEP) 0.050000
set PROFILE_2(UI_DESCRIPTION) ""
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(LONG_COND_VALUE_HI) 150
set PROFILE_3(LONG_COND_VALUE_LO) 50
set PROFILE_3(LONG_CT_OFF) 0
set PROFILE_3(LONG_CT_OFFDELAY) 0
set PROFILE_3(LONG_CT_ON) 0
set PROFILE_3(LONG_CT_ONDELAY) 0
set PROFILE_3(LONG_CT_RAMPOFF) 0
set PROFILE_3(LONG_CT_RAMPON) 0
set PROFILE_3(LONG_DIM_MAX_LEVEL) {1.0 range 0.0 - 1.0}
set PROFILE_3(LONG_DIM_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_3(LONG_DIM_STEP) 0.050000
set PROFILE_3(LONG_JT_OFF) 1
set PROFILE_3(LONG_JT_OFFDELAY) 5
set PROFILE_3(LONG_JT_ON) 4
set PROFILE_3(LONG_JT_ONDELAY) 2
set PROFILE_3(LONG_JT_RAMPOFF) 6
set PROFILE_3(LONG_JT_RAMPON) 3
set PROFILE_3(LONG_MULTIEXECUTE) 1
set PROFILE_3(LONG_OFFDELAY_BLINK) 1
set PROFILE_3(LONG_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_3(LONG_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_3(LONG_OFFDELAY_STEP) 0.050000
set PROFILE_3(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(LONG_OFF_LEVEL) 0.000000
set PROFILE_3(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(LONG_OFF_TIME_MODE) 0
set PROFILE_3(LONG_ONDELAY_MODE) 0
set PROFILE_3(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_3(LONG_ON_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_3(LONG_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(LONG_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(LONG_ON_TIME_MODE) 0
set PROFILE_3(LONG_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_3(LONG_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_3(LONG_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_3(LONG_PROFILE_REPETITIONS) {0 range 0 - 255}
set PROFILE_3(LONG_PROFILE_ACTION_TYPE) {5 0}
set PROFILE_3(LONG_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(LONG_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_3(LONG_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(LONG_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_3(LONG_RAMP_START_STEP) 0.050000
set PROFILE_3(SHORT_COND_VALUE_HI) 150
set PROFILE_3(SHORT_COND_VALUE_LO) 50
set PROFILE_3(SHORT_CT_OFF) 0
set PROFILE_3(SHORT_CT_OFFDELAY) 0
set PROFILE_3(SHORT_CT_ON) 0
set PROFILE_3(SHORT_CT_ONDELAY) 0
set PROFILE_3(SHORT_CT_RAMPOFF) 0
set PROFILE_3(SHORT_CT_RAMPON) 0
set PROFILE_3(SHORT_DIM_MAX_LEVEL) {1.0 range 0.0 - 1.0}
set PROFILE_3(SHORT_DIM_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_3(SHORT_DIM_STEP) 0.050000
set PROFILE_3(SHORT_JT_OFF) 1
set PROFILE_3(SHORT_JT_OFFDELAY) 5
set PROFILE_3(SHORT_JT_ON) 4
set PROFILE_3(SHORT_JT_ONDELAY) 2
set PROFILE_3(SHORT_JT_RAMPOFF) 6
set PROFILE_3(SHORT_JT_RAMPON) 3
set PROFILE_3(SHORT_MULTIEXECUTE) 0
set PROFILE_3(SHORT_OFFDELAY_BLINK) {1 0}
set PROFILE_3(SHORT_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_3(SHORT_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_3(SHORT_OFFDELAY_STEP) 0.050000
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_OFF_LEVEL) 0.000000
set PROFILE_3(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE) 0
set PROFILE_3(SHORT_ONDELAY_MODE) 0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_3(SHORT_ON_MIN_LEVEL) {0.1 range 0.0 - 1.0}
set PROFILE_3(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE) 0
set PROFILE_3(SHORT_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_3(SHORT_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_3(SHORT_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_3(SHORT_PROFILE_REPETITIONS) {0 range 0 - 255}
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(SHORT_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_3(SHORT_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_3(SHORT_RAMP_START_STEP) 0.050000
set PROFILE_3(UI_DESCRIPTION) ""
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3


###
set PROFILE_4(LONG_COND_VALUE_HI) 100
set PROFILE_4(LONG_COND_VALUE_LO) 50
set PROFILE_4(LONG_CT_OFF) 0
set PROFILE_4(LONG_CT_OFFDELAY) 0
set PROFILE_4(LONG_CT_ON) 0
set PROFILE_4(LONG_CT_ONDELAY) 0
set PROFILE_4(LONG_CT_RAMPOFF) 0
set PROFILE_4(LONG_CT_RAMPON) 0
set PROFILE_4(LONG_DIM_MAX_LEVEL) 1.000000
set PROFILE_4(LONG_DIM_MIN_LEVEL) 0.000000
set PROFILE_4(LONG_DIM_STEP) 0.050000
set PROFILE_4(LONG_JT_OFF) 1
set PROFILE_4(LONG_JT_OFFDELAY) 2
set PROFILE_4(LONG_JT_ON) 2
set PROFILE_4(LONG_JT_ONDELAY) 2
set PROFILE_4(LONG_JT_RAMPOFF) 2
set PROFILE_4(LONG_JT_RAMPON) 2
set PROFILE_4(LONG_MULTIEXECUTE) 1
set PROFILE_4(LONG_OFFDELAY_BLINK) {0 1}
set PROFILE_4(LONG_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_4(LONG_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_4(LONG_OFFDELAY_STEP) 0.050000
set PROFILE_4(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(LONG_OFF_LEVEL) 0.000000
set PROFILE_4(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(LONG_OFF_TIME_MODE) 0
set PROFILE_4(LONG_ONDELAY_MODE) 0
set PROFILE_4(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_4(LONG_ON_MIN_LEVEL) {0.1 range 0.0 - 1.0}
set PROFILE_4(LONG_ON_TIME_BASE) {5 range 0 - 7}
set PROFILE_4(LONG_ON_TIME_FACTOR) {1 range 0 - 31}
set PROFILE_4(LONG_ON_TIME_MODE) 0
set PROFILE_4(LONG_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_4(LONG_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_4(LONG_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_4(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_4(LONG_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(LONG_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_4(LONG_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(LONG_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_4(LONG_RAMP_START_STEP) 0.050000
set PROFILE_4(SHORT_COND_VALUE_HI) 150
set PROFILE_4(SHORT_COND_VALUE_LO) 50
set PROFILE_4(SHORT_CT_OFF) 0
set PROFILE_4(SHORT_CT_OFFDELAY) 0
set PROFILE_4(SHORT_CT_ON) 0
set PROFILE_4(SHORT_CT_ONDELAY) 0
set PROFILE_4(SHORT_CT_RAMPOFF) 0
set PROFILE_4(SHORT_CT_RAMPON) 0
set PROFILE_4(SHORT_DIM_MAX_LEVEL) 1.000000
set PROFILE_4(SHORT_DIM_MIN_LEVEL) 0.000000
set PROFILE_4(SHORT_DIM_STEP) 0.050000
set PROFILE_4(SHORT_JT_OFF) 1
set PROFILE_4(SHORT_JT_OFFDELAY) 2
set PROFILE_4(SHORT_JT_ON) 2
set PROFILE_4(SHORT_JT_ONDELAY) 2
set PROFILE_4(SHORT_JT_RAMPOFF) 2
set PROFILE_4(SHORT_JT_RAMPON) 2
set PROFILE_4(SHORT_MULTIEXECUTE) 0
set PROFILE_4(SHORT_OFFDELAY_BLINK) {0 1}
set PROFILE_4(SHORT_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_4(SHORT_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_4(SHORT_OFFDELAY_STEP) 0.050000
set PROFILE_4(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(SHORT_OFF_LEVEL) 0.000000
set PROFILE_4(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_4(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_4(SHORT_OFF_TIME_MODE) 0
set PROFILE_4(SHORT_ONDELAY_MODE) 0
set PROFILE_4(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_4(SHORT_ON_MIN_LEVEL) {0.1 range 0.0 - 1.0}
set PROFILE_4(SHORT_ON_TIME_BASE) {5 range 0 - 7}
set PROFILE_4(SHORT_ON_TIME_FACTOR) {1 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_MODE) 0
set PROFILE_4(SHORT_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_4(SHORT_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_4(SHORT_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_4(SHORT_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_4(SHORT_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_4(SHORT_RAMP_START_STEP) 0.050000
set PROFILE_4(UI_DESCRIPTION) ""
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

set PROFILE_5(SHORT_PROFILE_ACTION_TYPE) 0
set PROFILE_5(LONG_PROFILE_ACTION_TYPE)  0
set PROFILE_5(UI_DESCRIPTION)  "Die Taste ist nicht aktiv."
set PROFILE_5(UI_TEMPLATE)   $PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT) 5

proc getDescription {longAvailable prn} {
  if {$longAvailable} {
    return "\${description_$prn}"
  } else {
    return "\${description_noLong_$prn}"
  }
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url sender_address dev_descr_sender dev_descr_receiver

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

  set longKeypressAvailable [isLongKeypressAvailable $dev_descr_sender(PARENT_TYPE) $sender_address $url]

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

# die Texte der Platzhalter einlesen
  # puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo('MULTI_MODE_INPUT_TRANSMITTER_1', '$dev_descr_receiver(TYPE)');</script>"
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
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"


  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_PROFILE_REPETITIONS
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getRepetitionSelector PROFILE_$prn ${special_input_id} $param]

    # OFF_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn blink0 $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"
  }

  set param SHORT_OPTICAL_SIGNAL_COLOR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$longKeypressAvailable} {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 3]

    # ON_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_ONLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_OUTPUT_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param LONG_PROFILE_REPETITIONS
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getRepetitionSelector PROFILE_$prn ${special_input_id} $param]

      # OFF_TIME
      append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn blink0 $prn $special_input_id LONG_OFF_TIME TIMEBASE_LONG]"
    }

    set param LONG_OPTICAL_SIGNAL_COLOR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param LONG_OPTICAL_SIGNAL_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#2
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK|LONG_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  if {$longKeypressAvailable} {

    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 4]

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MIN_LEVEL}</td><td>"

    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_OUTPUT_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param LONG_OPTICAL_SIGNAL_COLOR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param LONG_OPTICAL_SIGNAL_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0
  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_PROFILE_REPETITIONS
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getRepetitionSelector PROFILE_$prn ${special_input_id} $param]

    # OFF_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn blink0 $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"
  }

  set param SHORT_OPTICAL_SIGNAL_COLOR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
  }

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  if {$longKeypressAvailable} {
    ## LONG KEYPRESS
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    # Long key press activ/inactive
    append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn 0 5]

    # ON_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_ONLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MIN_LEVEL}</td><td>"
    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param LONG_OUTPUT_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param LONG_PROFILE_REPETITIONS
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getRepetitionSelector PROFILE_$prn ${special_input_id} $param]

      # OFF_TIME
      append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn blink0 $prn $special_input_id LONG_OFF_TIME TIMEBASE_LONG]"
    }

    set param LONG_OPTICAL_SIGNAL_COLOR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param LONG_OPTICAL_SIGNAL_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  # append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  set pref 0
  # RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPON_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPON_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);Disable_SimKey($ch, $prn, '${special_input_id}');\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_COLOR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
  }

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK|LONG_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector RAMPOFF_TIME_FACTOR_DESCR ps PROFILE_$prn rampOnOff $prn $special_input_id SHORT_RAMPOFF_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
