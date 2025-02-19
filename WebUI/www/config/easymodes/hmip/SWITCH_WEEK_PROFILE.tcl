#!/bin/tclsh


sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipWeeklyProgramDevice.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set devType $dev_descr(TYPE)

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1

    if {([string first HmIP-DLD $devType] == -1) && ([string first HmIP-WGT $devType] == -1)} {
      append HTML_PARAMS(separate_1) "[getHmIPWeeklyProgram $address $chn ps psDescr 'switch']"
    } elseif {[string first HmIP-WGT $devType] != -1} {
      # What mode has the 1st virtual channel (switch or bwth)?
      # When bwth then show no weekly program (no parameters) available. Otherwise show the weekly program.

      # Get the mode of the 1st virtual channel
      set chnAddress [lindex [split $address :] 0]
      set chnFirstVirt "$chnAddress:5"
      set wgtChnMode "--"

      catch {
        set isecmd "object chn = dom.GetObject('$devType $chnFirstVirt');Write(chn.MetaData('channelMode'));"
        array set chnData [rega_script $isecmd]
        if {$chnData(STDOUT) != "null"} {
          set wgtChnMode $chnData(STDOUT)
        }
      }

      if {$wgtChnMode == "modeBWTH"} {
        append HTML_PARAMS(separate_1) "[getHmIPWeeklyProgram $address $chn ps psDescr 'switch' 'showOnlyBackLightingReceiver']"
      } else {
        append HTML_PARAMS(separate_1) "[getHmIPWeeklyProgram $address $chn ps psDescr 'switch']"
      }

    } else {
      append HTML_PARAMS(separate_1) "[getHmIPWeeklyProgram $address $chn ps psDescr 'switch' 'hideAstroOffset']"
    }

  append HTML_PARAMS(separate_1) "</table>"
}

constructor