#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)   "\${expert}"
set PROFILES_MAP(1)   "\${colorWarmWarmer}"
set PROFILES_MAP(2)   "\${colorCoolCooler}"
set PROFILES_MAP(3)   "\${colorWarmCold_WarmerCooler}"
set PROFILES_MAP(4)   "\${blink}"
set PROFILES_MAP(5)   "\${colorWarm}"
set PROFILES_MAP(6)   "\${colorCold}"
set PROFILES_MAP(7)   "\${colorWarmer}"
set PROFILES_MAP(8)   "\${colorCooler}"
set PROFILES_MAP(9)   "\${not_active}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(LONG_ACTION_TYPE)  4
set PROFILE_1(LONG_COND_VALUE_HI)  100
set PROFILE_1(LONG_COND_VALUE_LO)  50
set PROFILE_1(LONG_CT_OFF) 0
set PROFILE_1(LONG_CT_OFFDELAY)  0
set PROFILE_1(LONG_CT_ON)  0
set PROFILE_1(LONG_CT_ONDELAY) 0
set PROFILE_1(LONG_CT_RAMPOFF) 0
set PROFILE_1(LONG_CT_RAMPON)  0
set PROFILE_1(LONG_DIM_MAX_LEVEL)  1.0
set PROFILE_1(LONG_DIM_MIN_LEVEL)  0.0
set PROFILE_1(LONG_DIM_STEP) 0.05
set PROFILE_1(LONG_JT_OFF) 1
set PROFILE_1(LONG_JT_OFFDELAY)  2
set PROFILE_1(LONG_JT_ON)  2
set PROFILE_1(LONG_JT_ONDELAY) 2
set PROFILE_1(LONG_JT_RAMPOFF) 2
set PROFILE_1(LONG_JT_RAMPON)  3
set PROFILE_1(LONG_MULTIEXECUTE) 1
set PROFILE_1(LONG_OFF_LEVEL)  0.0
set PROFILE_1(LONG_OFF_TIME) 111600.0
set PROFILE_1(LONG_OFF_TIME_MODE)  0
set PROFILE_1(LONG_OFFDELAY_BLINK) 1
set PROFILE_1(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_1(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_1(LONG_OFFDELAY_STEP)  0.05
set PROFILE_1(LONG_OFFDELAY_TIME)  0.0
set PROFILE_1(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_1(LONG_ON_LEVEL_PRIO)  0
set PROFILE_1(LONG_ON_MIN_LEVEL) {0.05 range 0.0 - 1.0}
set PROFILE_1(LONG_ON_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_1(LONG_ON_TIME_MODE) 0
set PROFILE_1(LONG_ONDELAY_MODE) 0
set PROFILE_1(LONG_ONDELAY_TIME) 0.0
set PROFILE_1(LONG_RAMP_START_STEP)  0.05
set PROFILE_1(LONG_RAMPOFF_TIME) 0.5
set PROFILE_1(LONG_RAMPON_TIME)  {0.5 range 0.0 - 108000.0}
set PROFILE_1(SHORT_ACTION_TYPE) 1
set PROFILE_1(SHORT_COND_VALUE_HI) 100
set PROFILE_1(SHORT_COND_VALUE_LO) 50
set PROFILE_1(SHORT_CT_OFF)  0
set PROFILE_1(SHORT_CT_OFFDELAY) 0
set PROFILE_1(SHORT_CT_ON) 0
set PROFILE_1(SHORT_CT_ONDELAY)  0
set PROFILE_1(SHORT_CT_RAMPOFF)  0
set PROFILE_1(SHORT_CT_RAMPON) 0
set PROFILE_1(SHORT_DIM_MAX_LEVEL) 1.0
set PROFILE_1(SHORT_DIM_MIN_LEVEL) 0.0
set PROFILE_1(SHORT_DIM_STEP)  0.05
set PROFILE_1(SHORT_JT_OFF)  1
set PROFILE_1(SHORT_JT_OFFDELAY) 2
set PROFILE_1(SHORT_JT_ON) 2
set PROFILE_1(SHORT_JT_ONDELAY)  2
set PROFILE_1(SHORT_JT_RAMPOFF)  2
set PROFILE_1(SHORT_JT_RAMPON) 3
set PROFILE_1(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_1(SHORT_OFF_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_1(SHORT_OFF_TIME_MODE) 0
set PROFILE_1(SHORT_OFFDELAY_BLINK)  1
set PROFILE_1(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_1(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_1(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_1(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_1(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_1(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_1(SHORT_ON_MIN_LEVEL)  0.1
set PROFILE_1(SHORT_ON_TIME) {111600.0 range 0. - 111600.0}
set PROFILE_1(SHORT_ON_TIME_MODE)  0
set PROFILE_1(SHORT_ONDELAY_MODE)  0
set PROFILE_1(SHORT_ONDELAY_TIME)  0.0
set PROFILE_1(SHORT_RAMP_START_STEP) 0.05
set PROFILE_1(SHORT_RAMPOFF_TIME)  0.5
set PROFILE_1(SHORT_RAMPON_TIME) {0.5 range 0.0 - 108000.0}
set PROFILE_1(UI_DESCRIPTION) ""
set PROFILE_1(UI_TEMPLATE) $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_ACTION_TYPE)  5
set PROFILE_2(LONG_COND_VALUE_HI)  100
set PROFILE_2(LONG_COND_VALUE_LO)  50
set PROFILE_2(LONG_CT_OFF) 0
set PROFILE_2(LONG_CT_OFFDELAY)  0
set PROFILE_2(LONG_CT_ON)  0
set PROFILE_2(LONG_CT_ONDELAY) 0
set PROFILE_2(LONG_CT_RAMPOFF) 0
set PROFILE_2(LONG_CT_RAMPON)  0
set PROFILE_2(LONG_DIM_MAX_LEVEL)  1.0
set PROFILE_2(LONG_DIM_MIN_LEVEL)  0.0
set PROFILE_2(LONG_DIM_STEP) 0.05
set PROFILE_2(LONG_JT_OFF) 4
set PROFILE_2(LONG_JT_OFFDELAY)  5
set PROFILE_2(LONG_JT_ON)  4
set PROFILE_2(LONG_JT_ONDELAY) 4
set PROFILE_2(LONG_JT_RAMPOFF) 6
set PROFILE_2(LONG_JT_RAMPON)  4
set PROFILE_2(LONG_MULTIEXECUTE) 1
set PROFILE_2(LONG_OFF_LEVEL)  {0.0 range 0.0 - 1.005}
set PROFILE_2(LONG_OFF_TIME) 111600.0
set PROFILE_2(LONG_OFF_TIME_MODE)  0
set PROFILE_2(LONG_OFFDELAY_BLINK) 1
set PROFILE_2(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_2(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_2(LONG_OFFDELAY_STEP)  0.05
set PROFILE_2(LONG_OFFDELAY_TIME)  0.0
set PROFILE_2(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_2(LONG_ON_LEVEL_PRIO)  0
set PROFILE_2(LONG_ON_MIN_LEVEL) {0.05 range 0.0 - 1.0}
set PROFILE_2(LONG_ON_TIME)  1.0
set PROFILE_2(LONG_ON_TIME_MODE) 1
set PROFILE_2(LONG_ONDELAY_MODE) 0
set PROFILE_2(LONG_ONDELAY_TIME) 0.0
set PROFILE_2(LONG_RAMP_START_STEP)  0.05
set PROFILE_2(LONG_RAMPOFF_TIME) {0.5 range 0.0 - 111600.0}
set PROFILE_2(LONG_RAMPON_TIME)  0.5
set PROFILE_2(SHORT_ACTION_TYPE) 1
set PROFILE_2(SHORT_COND_VALUE_HI) 100
set PROFILE_2(SHORT_COND_VALUE_LO) 50
set PROFILE_2(SHORT_CT_OFF)  0
set PROFILE_2(SHORT_CT_OFFDELAY) 0
set PROFILE_2(SHORT_CT_ON) 0
set PROFILE_2(SHORT_CT_ONDELAY)  0
set PROFILE_2(SHORT_CT_RAMPOFF)  0
set PROFILE_2(SHORT_CT_RAMPON) 0
set PROFILE_2(SHORT_DIM_MAX_LEVEL) 1.0
set PROFILE_2(SHORT_DIM_MIN_LEVEL) 0.0
set PROFILE_2(SHORT_DIM_STEP)  0.05
set PROFILE_2(SHORT_JT_OFF)  4
set PROFILE_2(SHORT_JT_OFFDELAY) 5
set PROFILE_2(SHORT_JT_ON) 4
set PROFILE_2(SHORT_JT_ONDELAY)  4
set PROFILE_2(SHORT_JT_RAMPOFF)  6
set PROFILE_2(SHORT_JT_RAMPON) 4
set PROFILE_2(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_2(SHORT_OFF_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_2(SHORT_OFF_TIME_MODE) 0
set PROFILE_2(SHORT_OFFDELAY_BLINK)  1
set PROFILE_2(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_2(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_2(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_2(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_2(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_2(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_2(SHORT_ON_MIN_LEVEL)  0.1
set PROFILE_2(SHORT_ON_TIME) 111600.0
set PROFILE_2(SHORT_ON_TIME_MODE)  0
set PROFILE_2(SHORT_ONDELAY_MODE)  0
set PROFILE_2(SHORT_ONDELAY_TIME)  0.0
set PROFILE_2(SHORT_RAMP_START_STEP) 0.05
set PROFILE_2(SHORT_RAMPOFF_TIME)  {0.5 range 0.0 - 108000.0}
set PROFILE_2(SHORT_RAMPON_TIME) 0.5
set PROFILE_2(UI_DESCRIPTION) ""
set PROFILE_2(UI_TEMPLATE) $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(LONG_ACTION_TYPE)  6
set PROFILE_3(LONG_COND_VALUE_HI)  100
set PROFILE_3(LONG_COND_VALUE_LO)  50
set PROFILE_3(LONG_CT_OFF) 0
set PROFILE_3(LONG_CT_OFFDELAY)  0
set PROFILE_3(LONG_CT_ON)  0
set PROFILE_3(LONG_CT_ONDELAY) 0
set PROFILE_3(LONG_CT_RAMPOFF) 0
set PROFILE_3(LONG_CT_RAMPON)  0
set PROFILE_3(LONG_DIM_MAX_LEVEL)  1.0
set PROFILE_3(LONG_DIM_MIN_LEVEL)  0.0
set PROFILE_3(LONG_DIM_STEP) 0.05
set PROFILE_3(LONG_JT_OFF) 1
set PROFILE_3(LONG_JT_OFFDELAY)  5
set PROFILE_3(LONG_JT_ON)  4
set PROFILE_3(LONG_JT_ONDELAY) 2
set PROFILE_3(LONG_JT_RAMPOFF) 6
set PROFILE_3(LONG_JT_RAMPON)  3
set PROFILE_3(LONG_MULTIEXECUTE) 1
set PROFILE_3(LONG_OFF_LEVEL)  {0.0 range 0.0 - 1.005}
set PROFILE_3(LONG_OFF_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_3(LONG_OFF_TIME_MODE)  0
set PROFILE_3(LONG_OFFDELAY_BLINK) 0
set PROFILE_3(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_3(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_3(LONG_OFFDELAY_STEP)  0.05
set PROFILE_3(LONG_OFFDELAY_TIME)  0.0
set PROFILE_3(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_3(LONG_ON_LEVEL_PRIO)  0
set PROFILE_3(LONG_ON_MIN_LEVEL) 0.0
set PROFILE_3(LONG_ON_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_3(LONG_ON_TIME_MODE) 0
set PROFILE_3(LONG_ONDELAY_MODE) 0
set PROFILE_3(LONG_ONDELAY_TIME) 0.0
set PROFILE_3(LONG_RAMP_START_STEP)  0.05
set PROFILE_3(LONG_RAMPOFF_TIME) {0.5 range 0.0 - 108000.0}
set PROFILE_3(LONG_RAMPON_TIME)  {0.5 range 0.0 - 108000.0}
set PROFILE_3(SHORT_ACTION_TYPE) 1
set PROFILE_3(SHORT_COND_VALUE_HI) 100
set PROFILE_3(SHORT_COND_VALUE_LO) 50
set PROFILE_3(SHORT_CT_OFF)  0
set PROFILE_3(SHORT_CT_OFFDELAY) 0
set PROFILE_3(SHORT_CT_ON) 0
set PROFILE_3(SHORT_CT_ONDELAY)  0
set PROFILE_3(SHORT_CT_RAMPOFF)  0
set PROFILE_3(SHORT_CT_RAMPON) 0
set PROFILE_3(SHORT_DIM_MAX_LEVEL) 1.0
set PROFILE_3(SHORT_DIM_MIN_LEVEL) 0.0
set PROFILE_3(SHORT_DIM_STEP)  0.05
set PROFILE_3(SHORT_JT_OFF)  1
set PROFILE_3(SHORT_JT_OFFDELAY) 5
set PROFILE_3(SHORT_JT_ON) 4
set PROFILE_3(SHORT_JT_ONDELAY)  2
set PROFILE_3(SHORT_JT_RAMPOFF)  6
set PROFILE_3(SHORT_JT_RAMPON) 3
set PROFILE_3(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_3(SHORT_OFF_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_3(SHORT_OFF_TIME_MODE) 0
set PROFILE_3(SHORT_OFFDELAY_BLINK)  0
set PROFILE_3(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_3(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_3(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_3(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_3(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_3(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_3(SHORT_ON_MIN_LEVEL)  0.0
set PROFILE_3(SHORT_ON_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_3(SHORT_ON_TIME_MODE)  0
set PROFILE_3(SHORT_ONDELAY_MODE)  0
set PROFILE_3(SHORT_ONDELAY_TIME)  0.0
set PROFILE_3(SHORT_RAMP_START_STEP) 0.05
set PROFILE_3(SHORT_RAMPOFF_TIME)  {0.5 range 0.0 - 108000.0}
set PROFILE_3(SHORT_RAMPON_TIME) {0.5 range 0.0 - 108000.0}
set PROFILE_3(UI_DESCRIPTION) ""
set PROFILE_3(UI_TEMPLATE) $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(LONG_ACTION_TYPE)  1
set PROFILE_4(LONG_COND_VALUE_HI)  100
set PROFILE_4(LONG_COND_VALUE_LO)  50
set PROFILE_4(LONG_CT_OFF) 0
set PROFILE_4(LONG_CT_OFFDELAY)  0
set PROFILE_4(LONG_CT_ON)  0
set PROFILE_4(LONG_CT_ONDELAY) 0
set PROFILE_4(LONG_CT_RAMPOFF) 0
set PROFILE_4(LONG_CT_RAMPON)  0
set PROFILE_4(LONG_DIM_MAX_LEVEL)  1.0
set PROFILE_4(LONG_DIM_MIN_LEVEL)  0.0
set PROFILE_4(LONG_DIM_STEP) 0.05
set PROFILE_4(LONG_JT_OFF) 1
set PROFILE_4(LONG_JT_OFFDELAY)  1
set PROFILE_4(LONG_JT_ON)  4
set PROFILE_4(LONG_JT_ONDELAY) 4
set PROFILE_4(LONG_JT_RAMPOFF) 1
set PROFILE_4(LONG_JT_RAMPON)  4
set PROFILE_4(LONG_MULTIEXECUTE) 0
set PROFILE_4(LONG_OFF_LEVEL)  {0.0 range 0.0 - 1.005}
set PROFILE_4(LONG_OFF_TIME) {1.0 range 0.0 - 111600.0}
set PROFILE_4(LONG_OFF_TIME_MODE)  0
set PROFILE_4(LONG_OFFDELAY_BLINK) 0
set PROFILE_4(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_4(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_4(LONG_OFFDELAY_STEP)  0.05
set PROFILE_4(LONG_OFFDELAY_TIME)  0.0
set PROFILE_4(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_4(LONG_ON_LEVEL_PRIO)  0
set PROFILE_4(LONG_ON_MIN_LEVEL) 0.05
set PROFILE_4(LONG_ON_TIME)  {1.0 range 0.0 - 111600.0}
set PROFILE_4(LONG_ON_TIME_MODE) 0
set PROFILE_4(LONG_ONDELAY_MODE) 0
set PROFILE_4(LONG_ONDELAY_TIME) 0.0
set PROFILE_4(LONG_RAMP_START_STEP)  0.05
set PROFILE_4(LONG_RAMPOFF_TIME) 0.0
set PROFILE_4(LONG_RAMPON_TIME)  0.0
set PROFILE_4(SHORT_ACTION_TYPE) 1
set PROFILE_4(SHORT_COND_VALUE_HI) 100
set PROFILE_4(SHORT_COND_VALUE_LO) 50
set PROFILE_4(SHORT_CT_OFF)  0
set PROFILE_4(SHORT_CT_OFFDELAY) 0
set PROFILE_4(SHORT_CT_ON) 0
set PROFILE_4(SHORT_CT_ONDELAY)  0
set PROFILE_4(SHORT_CT_RAMPOFF)  0
set PROFILE_4(SHORT_CT_RAMPON) 0
set PROFILE_4(SHORT_DIM_MAX_LEVEL) 1.0
set PROFILE_4(SHORT_DIM_MIN_LEVEL) 0.0
set PROFILE_4(SHORT_DIM_STEP)  0.05
set PROFILE_4(SHORT_JT_OFF)  1
set PROFILE_4(SHORT_JT_OFFDELAY) 1
set PROFILE_4(SHORT_JT_ON) 4
set PROFILE_4(SHORT_JT_ONDELAY)  4
set PROFILE_4(SHORT_JT_RAMPOFF)  1
set PROFILE_4(SHORT_JT_RAMPON) 4
set PROFILE_4(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_4(SHORT_OFF_TIME)  {1.0 range 0.0 - 111600.0}
set PROFILE_4(SHORT_OFF_TIME_MODE) 0
set PROFILE_4(SHORT_OFFDELAY_BLINK)  0
set PROFILE_4(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_4(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_4(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_4(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_4(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_4(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_4(SHORT_ON_MIN_LEVEL)  0.1
set PROFILE_4(SHORT_ON_TIME) {1.0 range 0.0 - 111600.0}
set PROFILE_4(SHORT_ON_TIME_MODE)  0
set PROFILE_4(SHORT_ONDELAY_MODE)  0
set PROFILE_4(SHORT_ONDELAY_TIME)  0.0
set PROFILE_4(SHORT_RAMP_START_STEP) 0.0
set PROFILE_4(SHORT_RAMPOFF_TIME)  0.0
set PROFILE_4(SHORT_RAMPON_TIME) 0.0
set PROFILE_4(UI_DESCRIPTION) ""
set PROFILE_4(UI_TEMPLATE) $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

set PROFILE_5(LONG_ACTION_TYPE)  1
set PROFILE_5(LONG_COND_VALUE_HI)  100
set PROFILE_5(LONG_COND_VALUE_LO)  50
set PROFILE_5(LONG_CT_OFF) 0
set PROFILE_5(LONG_CT_OFFDELAY)  0
set PROFILE_5(LONG_CT_ON)  0
set PROFILE_5(LONG_CT_ONDELAY) 0
set PROFILE_5(LONG_CT_RAMPOFF) 0
set PROFILE_5(LONG_CT_RAMPON)  0
set PROFILE_5(LONG_DIM_MAX_LEVEL)  1.0
set PROFILE_5(LONG_DIM_MIN_LEVEL)  0.0
set PROFILE_5(LONG_DIM_STEP) 0.05
set PROFILE_5(LONG_JT_OFF) 1
set PROFILE_5(LONG_JT_OFFDELAY)  2
set PROFILE_5(LONG_JT_ON)  2
set PROFILE_5(LONG_JT_ONDELAY) 2
set PROFILE_5(LONG_JT_RAMPOFF) 2
set PROFILE_5(LONG_JT_RAMPON)  3
set PROFILE_5(LONG_MULTIEXECUTE) 0
set PROFILE_5(LONG_OFF_LEVEL)  0.0
set PROFILE_5(LONG_OFF_TIME) 111600.0
set PROFILE_5(LONG_OFF_TIME_MODE)  0
set PROFILE_5(LONG_OFFDELAY_BLINK) 0
set PROFILE_5(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_5(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_5(LONG_OFFDELAY_STEP)  0.05
set PROFILE_5(LONG_OFFDELAY_TIME)  0.0
set PROFILE_5(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_5(LONG_ON_LEVEL_PRIO)  0
set PROFILE_5(LONG_ON_MIN_LEVEL) 0.05
set PROFILE_5(LONG_ON_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_5(LONG_ON_TIME_MODE) 0
set PROFILE_5(LONG_ONDELAY_MODE) 0
set PROFILE_5(LONG_ONDELAY_TIME) 0.0
set PROFILE_5(LONG_RAMP_START_STEP)  0.05
set PROFILE_5(LONG_RAMPOFF_TIME) 0.5
set PROFILE_5(LONG_RAMPON_TIME)  {0.5 range 0.0 - 108000.0}
set PROFILE_5(SHORT_ACTION_TYPE) 1
set PROFILE_5(SHORT_COND_VALUE_HI) 100
set PROFILE_5(SHORT_COND_VALUE_LO) 50
set PROFILE_5(SHORT_CT_OFF)  0
set PROFILE_5(SHORT_CT_OFFDELAY) 0
set PROFILE_5(SHORT_CT_ON) 0
set PROFILE_5(SHORT_CT_ONDELAY)  0
set PROFILE_5(SHORT_CT_RAMPOFF)  0
set PROFILE_5(SHORT_CT_RAMPON) 0
set PROFILE_5(SHORT_DIM_MAX_LEVEL) 1.0
set PROFILE_5(SHORT_DIM_MIN_LEVEL) 0.0
set PROFILE_5(SHORT_DIM_STEP)  0.05
set PROFILE_5(SHORT_JT_OFF)  1
set PROFILE_5(SHORT_JT_OFFDELAY) 2
set PROFILE_5(SHORT_JT_ON) 2
set PROFILE_5(SHORT_JT_ONDELAY)  2
set PROFILE_5(SHORT_JT_RAMPOFF)  2
set PROFILE_5(SHORT_JT_RAMPON) 3
set PROFILE_5(SHORT_OFF_LEVEL) 0.0
set PROFILE_5(SHORT_OFF_TIME)  111600.0
set PROFILE_5(SHORT_OFF_TIME_MODE) 0
set PROFILE_5(SHORT_OFFDELAY_BLINK)  0
set PROFILE_5(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_5(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_5(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_5(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_5(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_5(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_5(SHORT_ON_MIN_LEVEL)  0.1
set PROFILE_5(SHORT_ON_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_5(SHORT_ON_TIME_MODE)  0
set PROFILE_5(SHORT_ONDELAY_MODE)  0
set PROFILE_5(SHORT_ONDELAY_TIME)  0.0
set PROFILE_5(SHORT_RAMP_START_STEP) 0.05
set PROFILE_5(SHORT_RAMPOFF_TIME)  0.5
set PROFILE_5(SHORT_RAMPON_TIME) {0.5 range 0.0 - 108000.0}
set PROFILE_5(UI_DESCRIPTION) ""
set PROFILE_5(UI_TEMPLATE) $PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT) 5

set PROFILE_6(LONG_ACTION_TYPE)  1
set PROFILE_6(LONG_COND_VALUE_HI)  100
set PROFILE_6(LONG_COND_VALUE_LO)  50
set PROFILE_6(LONG_CT_OFF) 0
set PROFILE_6(LONG_CT_OFFDELAY)  0
set PROFILE_6(LONG_CT_ON)  0
set PROFILE_6(LONG_CT_ONDELAY) 0
set PROFILE_6(LONG_CT_RAMPOFF) 0
set PROFILE_6(LONG_CT_RAMPON)  0
set PROFILE_6(LONG_DIM_MAX_LEVEL)  1.0
set PROFILE_6(LONG_DIM_MIN_LEVEL)  0.0
set PROFILE_6(LONG_DIM_STEP) 0.05
set PROFILE_6(LONG_JT_OFF) 4
set PROFILE_6(LONG_JT_OFFDELAY)  5
set PROFILE_6(LONG_JT_ON)  4
set PROFILE_6(LONG_JT_ONDELAY) 4
set PROFILE_6(LONG_JT_RAMPOFF) 6
set PROFILE_6(LONG_JT_RAMPON)  4
set PROFILE_6(LONG_MULTIEXECUTE) 0
set PROFILE_6(LONG_OFF_LEVEL)  {0.0 range 0.0 - 1.005}
set PROFILE_6(LONG_OFF_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_6(LONG_OFF_TIME_MODE)  0
set PROFILE_6(LONG_OFFDELAY_BLINK) 0
set PROFILE_6(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_6(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_6(LONG_OFFDELAY_STEP)  0.05
set PROFILE_6(LONG_OFFDELAY_TIME)  0.0
set PROFILE_6(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_6(LONG_ON_LEVEL_PRIO)  0
set PROFILE_6(LONG_ON_MIN_LEVEL) 0.05
set PROFILE_6(LONG_ON_TIME)  111600.0
set PROFILE_6(LONG_ON_TIME_MODE) 0
set PROFILE_6(LONG_ONDELAY_MODE) 0
set PROFILE_6(LONG_ONDELAY_TIME) 0.0
set PROFILE_6(LONG_RAMP_START_STEP)  0.05
set PROFILE_6(LONG_RAMPOFF_TIME) {0.5 range 0.0 - 108000.0}
set PROFILE_6(LONG_RAMPON_TIME)  0.5
set PROFILE_6(SHORT_ACTION_TYPE) 1
set PROFILE_6(SHORT_COND_VALUE_HI) 100
set PROFILE_6(SHORT_COND_VALUE_LO) 50
set PROFILE_6(SHORT_CT_OFF)  0
set PROFILE_6(SHORT_CT_OFFDELAY) 0
set PROFILE_6(SHORT_CT_ON) 0
set PROFILE_6(SHORT_CT_ONDELAY)  0
set PROFILE_6(SHORT_CT_RAMPOFF)  0
set PROFILE_6(SHORT_CT_RAMPON) 0
set PROFILE_6(SHORT_DIM_MAX_LEVEL) 1.0
set PROFILE_6(SHORT_DIM_MIN_LEVEL) 0.0
set PROFILE_6(SHORT_DIM_STEP)  0.05
set PROFILE_6(SHORT_JT_OFF)  4
set PROFILE_6(SHORT_JT_OFFDELAY) 5
set PROFILE_6(SHORT_JT_ON) 4
set PROFILE_6(SHORT_JT_ONDELAY)  4
set PROFILE_6(SHORT_JT_RAMPOFF)  6
set PROFILE_6(SHORT_JT_RAMPON) 4
set PROFILE_6(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_6(SHORT_OFF_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_6(SHORT_OFF_TIME_MODE) 0
set PROFILE_6(SHORT_OFFDELAY_BLINK)  0
set PROFILE_6(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_6(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_6(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_6(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_6(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_6(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_6(SHORT_ON_MIN_LEVEL)  0.1
set PROFILE_6(SHORT_ON_TIME) 111600.0
set PROFILE_6(SHORT_ON_TIME_MODE)  0
set PROFILE_6(SHORT_ONDELAY_MODE)  0
set PROFILE_6(SHORT_ONDELAY_TIME)  0.0
set PROFILE_6(SHORT_RAMP_START_STEP) 0.05
set PROFILE_6(SHORT_RAMPOFF_TIME)  {0.5 range 0.0 - 108000.0}
set PROFILE_6(SHORT_RAMPON_TIME) 0.5
set PROFILE_6(UI_DESCRIPTION) ""
set PROFILE_6(UI_TEMPLATE) $PROFILE_6(UI_DESCRIPTION)
set PROFILE_6(UI_HINT) 6

set PROFILE_7(LONG_ACTION_TYPE)  4
set PROFILE_7(LONG_COND_VALUE_HI)  100
set PROFILE_7(LONG_COND_VALUE_LO)  50
set PROFILE_7(LONG_CT_OFF) 0
set PROFILE_7(LONG_CT_OFFDELAY)  0
set PROFILE_7(LONG_CT_ON)  0
set PROFILE_7(LONG_CT_ONDELAY) 0
set PROFILE_7(LONG_CT_RAMPOFF) 0
set PROFILE_7(LONG_CT_RAMPON)  0
set PROFILE_7(LONG_DIM_MAX_LEVEL)  {1.0 range 0.0 - 1.0}
set PROFILE_7(LONG_DIM_MIN_LEVEL)  0.0
set PROFILE_7(LONG_DIM_STEP) 0.05
set PROFILE_7(LONG_JT_OFF) 1
set PROFILE_7(LONG_JT_OFFDELAY)  2
set PROFILE_7(LONG_JT_ON)  2
set PROFILE_7(LONG_JT_ONDELAY) 2
set PROFILE_7(LONG_JT_RAMPOFF) 2
set PROFILE_7(LONG_JT_RAMPON)  3
set PROFILE_7(LONG_MULTIEXECUTE) 1
set PROFILE_7(LONG_OFF_LEVEL)  {0.0 range 0.0 - 1.005}
set PROFILE_7(LONG_OFF_TIME) 111600.0
set PROFILE_7(LONG_OFF_TIME_MODE)  0
set PROFILE_7(LONG_OFFDELAY_BLINK) 0
set PROFILE_7(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_7(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_7(LONG_OFFDELAY_STEP)  0.05
set PROFILE_7(LONG_OFFDELAY_TIME)  0.0
set PROFILE_7(LONG_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_7(LONG_ON_LEVEL_PRIO)  0
set PROFILE_7(LONG_ON_MIN_LEVEL) 0.05
set PROFILE_7(LONG_ON_TIME)  111600.0
set PROFILE_7(LONG_ON_TIME_MODE) 0
set PROFILE_7(LONG_ONDELAY_MODE) 0
set PROFILE_7(LONG_ONDELAY_TIME) 0.0
set PROFILE_7(LONG_RAMP_START_STEP)  0.05
set PROFILE_7(LONG_RAMPOFF_TIME) 0.5
set PROFILE_7(LONG_RAMPON_TIME)  0.5
set PROFILE_7(SHORT_ACTION_TYPE) 4
set PROFILE_7(SHORT_COND_VALUE_HI) 100
set PROFILE_7(SHORT_COND_VALUE_LO) 50
set PROFILE_7(SHORT_CT_OFF)  0
set PROFILE_7(SHORT_CT_OFFDELAY) 0
set PROFILE_7(SHORT_CT_ON) 0
set PROFILE_7(SHORT_CT_ONDELAY)  0
set PROFILE_7(SHORT_CT_RAMPOFF)  0
set PROFILE_7(SHORT_CT_RAMPON) 0
set PROFILE_7(SHORT_DIM_MAX_LEVEL) {1.0 range 0.0 - 1.0}
set PROFILE_7(SHORT_DIM_MIN_LEVEL) 0.0
set PROFILE_7(SHORT_DIM_STEP)  0.05
set PROFILE_7(SHORT_JT_OFF)  1
set PROFILE_7(SHORT_JT_OFFDELAY) 2
set PROFILE_7(SHORT_JT_ON) 2
set PROFILE_7(SHORT_JT_ONDELAY)  2
set PROFILE_7(SHORT_JT_RAMPOFF)  2
set PROFILE_7(SHORT_JT_RAMPON) 3
set PROFILE_7(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_7(SHORT_OFF_TIME)  111600.0
set PROFILE_7(SHORT_OFF_TIME_MODE) 0
set PROFILE_7(SHORT_OFFDELAY_BLINK)  0
set PROFILE_7(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_7(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_7(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_7(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_7(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_7(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_7(SHORT_ON_MIN_LEVEL)  0.1
set PROFILE_7(SHORT_ON_TIME) 111600.0
set PROFILE_7(SHORT_ON_TIME_MODE)  0
set PROFILE_7(SHORT_ONDELAY_MODE)  0
set PROFILE_7(SHORT_ONDELAY_TIME)  0.0
set PROFILE_7(SHORT_RAMP_START_STEP) 0.05
set PROFILE_7(SHORT_RAMPOFF_TIME)  0.5
set PROFILE_7(SHORT_RAMPON_TIME) 0.5
set PROFILE_7(UI_DESCRIPTION) ""
set PROFILE_7(UI_TEMPLATE) $PROFILE_7(UI_DESCRIPTION)
set PROFILE_7(UI_HINT) 7

set PROFILE_8(LONG_ACTION_TYPE)  5
set PROFILE_8(LONG_COND_VALUE_HI)  100
set PROFILE_8(LONG_COND_VALUE_LO)  50
set PROFILE_8(LONG_CT_OFF) 0
set PROFILE_8(LONG_CT_OFFDELAY)  0
set PROFILE_8(LONG_CT_ON)  0
set PROFILE_8(LONG_CT_ONDELAY) 0
set PROFILE_8(LONG_CT_RAMPOFF) 0
set PROFILE_8(LONG_CT_RAMPON)  0
set PROFILE_8(LONG_DIM_MAX_LEVEL)  1.0
set PROFILE_8(LONG_DIM_MIN_LEVEL)  {0.0  range 0.0 - 1.0}
set PROFILE_8(LONG_DIM_STEP) 0.05
set PROFILE_8(LONG_JT_OFF) 4
set PROFILE_8(LONG_JT_OFFDELAY)  5
set PROFILE_8(LONG_JT_ON)  4
set PROFILE_8(LONG_JT_ONDELAY) 4
set PROFILE_8(LONG_JT_RAMPOFF) 6
set PROFILE_8(LONG_JT_RAMPON)  4
set PROFILE_8(LONG_MULTIEXECUTE) 1
set PROFILE_8(LONG_OFF_LEVEL)  0.0
set PROFILE_8(LONG_OFF_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_8(LONG_OFF_TIME_MODE)  0
set PROFILE_8(LONG_OFFDELAY_BLINK) 0
set PROFILE_8(LONG_OFFDELAY_NEWTIME) 0.5
set PROFILE_8(LONG_OFFDELAY_OLDTIME) 0.5
set PROFILE_8(LONG_OFFDELAY_STEP)  0.05
set PROFILE_8(LONG_OFFDELAY_TIME)  0.0
set PROFILE_8(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_8(LONG_ON_LEVEL_PRIO)  0
set PROFILE_8(LONG_ON_MIN_LEVEL) 0.05
set PROFILE_8(LONG_ON_TIME)  111600.0
set PROFILE_8(LONG_ON_TIME_MODE) 1
set PROFILE_8(LONG_ONDELAY_MODE) 0
set PROFILE_8(LONG_ONDELAY_TIME) 0.0
set PROFILE_8(LONG_RAMP_START_STEP)  0.05
set PROFILE_8(LONG_RAMPOFF_TIME) 0.5
set PROFILE_8(LONG_RAMPON_TIME)  0.5
set PROFILE_8(SHORT_ACTION_TYPE) 5
set PROFILE_8(SHORT_COND_VALUE_HI) 100
set PROFILE_8(SHORT_COND_VALUE_LO) 50
set PROFILE_8(SHORT_CT_OFF)  0
set PROFILE_8(SHORT_CT_OFFDELAY) 0
set PROFILE_8(SHORT_CT_ON) 0
set PROFILE_8(SHORT_CT_ONDELAY)  0
set PROFILE_8(SHORT_CT_RAMPOFF)  0
set PROFILE_8(SHORT_CT_RAMPON) 0
set PROFILE_8(SHORT_DIM_MAX_LEVEL) 1.0
set PROFILE_8(SHORT_DIM_MIN_LEVEL) {0.0 range 0.0 - 1.0}
set PROFILE_8(SHORT_DIM_STEP)  0.05
set PROFILE_8(SHORT_JT_OFF)  4
set PROFILE_8(SHORT_JT_OFFDELAY) 5
set PROFILE_8(SHORT_JT_ON) 4
set PROFILE_8(SHORT_JT_ONDELAY)  4
set PROFILE_8(SHORT_JT_RAMPOFF)  6
set PROFILE_8(SHORT_JT_RAMPON) 4
set PROFILE_8(SHORT_OFF_LEVEL) 0.0
set PROFILE_8(SHORT_OFF_TIME)  {111600.0 range 0.0 - 111600.0}
set PROFILE_8(SHORT_OFF_TIME_MODE) 0
set PROFILE_8(SHORT_OFFDELAY_BLINK)  0
set PROFILE_8(SHORT_OFFDELAY_NEWTIME)  0.5
set PROFILE_8(SHORT_OFFDELAY_OLDTIME)  0.5
set PROFILE_8(SHORT_OFFDELAY_STEP) 0.05
set PROFILE_8(SHORT_OFFDELAY_TIME) 0.0
set PROFILE_8(SHORT_ON_LEVEL)  {1.0 range 0.0 - 1.005}
set PROFILE_8(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_8(SHORT_ON_MIN_LEVEL)  0.1
set PROFILE_8(SHORT_ON_TIME) 111600.0
set PROFILE_8(SHORT_ON_TIME_MODE)  1
set PROFILE_8(SHORT_ONDELAY_MODE)  0
set PROFILE_8(SHORT_ONDELAY_TIME)  0.0
set PROFILE_8(SHORT_RAMP_START_STEP) 0.05
set PROFILE_8(SHORT_RAMPOFF_TIME)  0.5
set PROFILE_8(SHORT_RAMPON_TIME) 0.5
set PROFILE_8(UI_DESCRIPTION) ""
set PROFILE_8(UI_TEMPLATE) $PROFILE_8(UI_DESCRIPTION)
set PROFILE_8(UI_HINT) 8

set comment {
set PROFILE_9(LONG_ACTION_TYPE) 0
set PROFILE_9(LONG_COND_VALUE_HI) 100
set PROFILE_9(LONG_COND_VALUE_LO) 50
set PROFILE_9(LONG_CT_OFF) 0
set PROFILE_9(LONG_CT_OFFDELAY) 0
set PROFILE_9(LONG_CT_ON) 0
set PROFILE_9(LONG_CT_ONDELAY) 0
set PROFILE_9(LONG_CT_RAMPOFF) 0
set PROFILE_9(LONG_CT_RAMPON) 0
set PROFILE_9(LONG_DIM_MAX_LEVEL) 1.000000
set PROFILE_9(LONG_DIM_MIN_LEVEL) 0.000000
set PROFILE_9(LONG_DIM_STEP) 0.050000
set PROFILE_9(LONG_ELSE_ACTION_TYPE) 0
set PROFILE_9(LONG_ELSE_JT_OFF) 1
set PROFILE_9(LONG_ELSE_JT_OFFDELAY) 5
set PROFILE_9(LONG_ELSE_JT_ON) 4
set PROFILE_9(LONG_ELSE_JT_ONDELAY) 2
set PROFILE_9(LONG_ELSE_JT_RAMPOFF) 6
set PROFILE_9(LONG_ELSE_JT_RAMPON) 3
set PROFILE_9(LONG_ELSE_MULTIEXECUTE) 1
set PROFILE_9(LONG_ELSE_OFF_TIME_MODE) 0
set PROFILE_9(LONG_ELSE_ON_TIME_MODE) 0
set PROFILE_9(LONG_JT_OFF) 1
set PROFILE_9(LONG_JT_OFFDELAY) 5
set PROFILE_9(LONG_JT_ON) 4
set PROFILE_9(LONG_JT_ONDELAY) 2
set PROFILE_9(LONG_JT_RAMPOFF) 6
set PROFILE_9(LONG_JT_RAMPON) 3
set PROFILE_9(LONG_MULTIEXECUTE) 1
set PROFILE_9(LONG_OFFDELAY_BLINK) 0
set PROFILE_9(LONG_OFFDELAY_NEWTIME) 0.500000
set PROFILE_9(LONG_OFFDELAY_OLDTIME) 0.500000
set PROFILE_9(LONG_OFFDELAY_STEP) 0.050000
set PROFILE_9(LONG_OFFDELAY_TIME) 0.000000
set PROFILE_9(LONG_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_9(LONG_OFF_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_9(LONG_OFF_TIME_MODE) 0
set PROFILE_9(LONG_ONDELAY_MODE) 0
set PROFILE_9(LONG_ONDELAY_TIME) 0.000000
set PROFILE_9(LONG_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_9(LONG_ON_LEVEL_PRIO) 0
set PROFILE_9(LONG_ON_MIN_LEVEL) 0.000000
set PROFILE_9(LONG_ON_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_9(LONG_ON_TIME_MODE) 0
set PROFILE_9(LONG_RAMPOFF_TIME) 0.500000
set PROFILE_9(LONG_RAMPON_TIME) 0.500000
set PROFILE_9(LONG_RAMP_START_STEP) 0.050000
set PROFILE_9(SHORT_ACTION_TYPE) 1
set PROFILE_9(SHORT_COND_VALUE_HI) 100
set PROFILE_9(SHORT_COND_VALUE_LO) 50
set PROFILE_9(SHORT_CT_OFF) 0
set PROFILE_9(SHORT_CT_OFFDELAY) 0
set PROFILE_9(SHORT_CT_ON) 0
set PROFILE_9(SHORT_CT_ONDELAY) 0
set PROFILE_9(SHORT_CT_RAMPOFF) 0
set PROFILE_9(SHORT_CT_RAMPON) 0
set PROFILE_9(SHORT_DIM_MAX_LEVEL) 1.000000
set PROFILE_9(SHORT_DIM_MIN_LEVEL) 0.000000
set PROFILE_9(SHORT_DIM_STEP) 0.050000
set PROFILE_9(SHORT_ELSE_ACTION_TYPE) 0
set PROFILE_9(SHORT_ELSE_JT_OFF) 1
set PROFILE_9(SHORT_ELSE_JT_OFFDELAY) 5
set PROFILE_9(SHORT_ELSE_JT_ON) 4
set PROFILE_9(SHORT_ELSE_JT_ONDELAY) 2
set PROFILE_9(SHORT_ELSE_JT_RAMPOFF) 6
set PROFILE_9(SHORT_ELSE_JT_RAMPON) 3
set PROFILE_9(SHORT_ELSE_OFF_TIME_MODE) 0
set PROFILE_9(SHORT_ELSE_ON_TIME_MODE) 0
set PROFILE_9(SHORT_JT_OFF) 1
set PROFILE_9(SHORT_JT_OFFDELAY) 5
set PROFILE_9(SHORT_JT_ON) 4
set PROFILE_9(SHORT_JT_ONDELAY) 2
set PROFILE_9(SHORT_JT_RAMPOFF) 6
set PROFILE_9(SHORT_JT_RAMPON) 3
set PROFILE_9(SHORT_OFFDELAY_BLINK) 0
set PROFILE_9(SHORT_OFFDELAY_NEWTIME) 0.500000
set PROFILE_9(SHORT_OFFDELAY_OLDTIME) 0.500000
set PROFILE_9(SHORT_OFFDELAY_STEP) 0.050000
set PROFILE_9(SHORT_OFFDELAY_TIME) 0.000000
set PROFILE_9(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_9(SHORT_OFF_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_9(SHORT_OFF_TIME_MODE) 0
set PROFILE_9(SHORT_ONDELAY_MODE) 0
set PROFILE_9(SHORT_ONDELAY_TIME) 0.000000
set PROFILE_9(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_9(SHORT_ON_LEVEL_PRIO) 0
set PROFILE_9(SHORT_ON_MIN_LEVEL) 0.000000
set PROFILE_9(SHORT_ON_TIME) {111600.0 range 0.0 - 111600.0}
set PROFILE_9(SHORT_ON_TIME_MODE) 0
set PROFILE_9(SHORT_RAMPOFF_TIME) 0.500000
set PROFILE_9(SHORT_RAMPON_TIME) 0.500000
set PROFILE_9(SHORT_RAMP_START_STEP) 0.050000
set PROFILE_9(UI_DESCRIPTION) ""
set PROFILE_9(UI_TEMPLATE) $PROFILE_9(UI_DESCRIPTION)
set PROFILE_9(UI_HINT) 9
}

set PROFILE_9(LONG_ACTION_TYPE) 0
set PROFILE_9(SHORT_ACTION_TYPE) 0
set PROFILE_9(UI_DESCRIPTION)    "Der Kanal ist nicht akriv!"
set PROFILE_9(UI_TEMPLATE)    $PROFILE_9(UI_DESCRIPTION)
set PROFILE_9(UI_HINT) 9

# hier folgen die eventuellen Subsets

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url dev_descr dev_descr_sender dev_descr_receiver

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr

  set device $dev_descr_sender(TYPE)
  set ch $dev_descr_sender(INDEX)

  set devType $dev_descr(TYPE)

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
    # set PROFILES_MAP($pro) "\${profile_$pro}"
  }

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP "KEY"]

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$device', '$device');</script>"
  
  set prn 0 
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set param SHORT_RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr $param
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  set param SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr $param
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  set param SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr $param
  append HTML_PARAMS(separate_$prn) "</td></tr>"

set comment {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    incr pref ;# 4
    set param LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_ONLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn  $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr $param
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref ;# 5
    set param LONG_ON_TIME
    append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
    option LENGTH_OF_STAY
    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr $param
    append HTML_PARAMS(separate_$prn) "</td></tr>"
}
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2  
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
    append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
    append HTML_PARAMS(separate_$prn) "\${description_$prn}"
    append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"


    set param SHORT_RAMPOFF_TIME
    append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
    option RAMPTIME
    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr $param
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref ;# 2
    set param SHORT_OFF_LEVEL
    append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr $param
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref ;# 3
    set param SHORT_OFF_TIME
    append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
    option LENGTH_OF_STAY
    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr $param
    append HTML_PARAMS(separate_$prn) "</td></tr>"

set comment {
      append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

      incr pref ;# 4
      set param LONG_DIM_MIN_LEVEL
      append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MIN_LEVEL}</td><td>"
      option DIM_ONLEVEL
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn  $param "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterPercent $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"

      incr pref ;# 5
      set param LONG_OFF_TIME
      append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
      option LENGTH_OF_STAY
      append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
      EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr $param
      append HTML_PARAMS(separate_$prn) "</td></tr>"
}
    append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_TIME|LONG_RAMPOFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 5
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 6
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

set comment {
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

    incr pref ;# 7
    append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MAX_LEVEL}</td><td>"
    option DIM_ONLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref ;# 8
    append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MIN_LEVEL}</td><td>"
    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"
}
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option BLINK
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
  option BLINK
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_OFF_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
  option DIM_OFFLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_RAMPON_TIME|SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#6
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_RAMPOFF_TIME|SHORT_RAMPOFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
  option DIM_OFFLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#7
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MAX_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_DIM_MAX_LEVEL|LONG_DIM_MAX_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MAX_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MAX_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#8
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DIM_MIN_LEVEL}</td><td>"
  option DIM_OFFLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_DIM_MIN_LEVEL|LONG_DIM_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_DIM_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr LONG_DIM_MIN_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

set comment {
  #9
    incr prn
    set pref 1
    if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
    append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
    append HTML_PARAMS(separate_$prn) "\${description_$prn}"
    append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

    append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
    option LENGTH_OF_STAY
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref ;# 2
    append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
    option DIM_ONLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref ;# 3
    append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
    option LENGTH_OF_STAY
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_OFF_TIME "onchange=\"ActivateFreeTime4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref ;# 4
    append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}
  #9
    incr prn
    set pref 1
    if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
    append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
    append HTML_PARAMS(separate_$prn) "\${description_$prn}"
    append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

    append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
