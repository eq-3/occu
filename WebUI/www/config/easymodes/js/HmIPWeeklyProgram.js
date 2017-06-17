checkWPFixedTime = function(thisElm, chn, prn) {
  var sTime = thisElm.value,
    arTime = sTime.split(":"),
    hr = parseInt(arTime[0]),
    min = parseInt(arTime[1]),
    elmHr = jQuery("#separate_CHANNEL_" + chn + "_" + prn),
    elmMin = jQuery("#separate_CHANNEL_" + chn + "_" + (parseInt(prn) + 1));

  hr = ((hr >= 0) && (hr <= 23)) ? hr : 0;
  min = ((min >= 0) && (min <= 59)) ? min : 0;

  elmHr.val(hr);
  elmMin.val(min);

  hr = (hr < 10) ? "0"+hr : hr.toString();
  min = (min < 10) ? "0"+min : min.toString();
  thisElm.value = hr + ":" + min;
};

checkWPMinMaxValue = function(thisElm, min, max) {
  var value = parseInt(thisElm.value);

  if (isNaN(value)) {thisElm.value = 0;} else {thisElm.value = value;}
  if (value < parseInt(min)) thisElm.value = min;
  if (value > parseInt(max)) thisElm.value = max;
};

setWPWeekday = function(thisElm, chn, prn) {
  var targetElm = jQuery("#separate_CHANNEL_"+chn+"_"+prn),
  iActiveWeekdays = parseInt(targetElm.val()),
  selectedVal = parseInt(thisElm.value);

  if (thisElm.checked) {
    iActiveWeekdays += selectedVal;
  } else {
    iActiveWeekdays -= selectedVal;
  }

  this.curWeekdays = iActiveWeekdays;

  targetElm.val(iActiveWeekdays);

};

reverseString = function (str) {
    return str.split("").reverse().join("");
};

setWPTargetChannels = function(thisElm, chn, prn) {
  var targetElm = jQuery("#separate_CHANNEL_"+chn+"_"+prn),
   iActiveChannels = parseInt(targetElm.val()),
   selectedVal = parseInt(thisElm.value);

  if (thisElm.checked) {
    iActiveChannels += selectedVal;
  } else {
    iActiveChannels -= selectedVal;
  }

  this.curTargetChannels = iActiveChannels;

  targetElm.val(iActiveChannels);

};

getOnlyNonExpertChannels = function(devId, chn) {
  var result = null;
  chn = parseInt(chn);

  switch (devId.toUpperCase()) {
    case "HMIP-FDT" :
    case "HMIP-FSM" :
    case "HMIP-FSM16" :
      if (chn == 2) {result =  chn;}
      break;

    case "HMIP-PCBS-BAT" :
    case "HMIP-PDT" :
    case "HMIP-PDT-UK" :
    case "HMIP-PS" :
    case "HMIP-PCBS" :
    case "HMIP-PSM" :
    case "HMIP-PSM-PE" :
    case "HMIP-PSM-UK" :
    case "HMIP-PSM-IT" :
    case "HMIP-PSM-CH" :
      if (chn == 3) {result =  chn;}
      break;

    case "HMIP-BBL" :
    case "HMIP-BDT" :
    case "HMIP-BROLL" :
    case "HMIP-BSM" :
    case "HMIP-FBL" :
    case "HMIP-FROLL" :
      if (chn == 4) {result =  chn;}
      break;

    case "HMIP-MOD-OC8" :
      var arEasyChannels = [10,14,18,22,26,30,34,38];
      jQuery.each(arEasyChannels,function(index,val) {
        if (val == chn){
          result = chn;
          return false; // leave the each loop
        }
      });
      break;

    default: result = chn;
  }

  return result;
};

getWPVirtualChannels = function(devId, channels, expert) {
  var result = [];

  jQuery.each(channels, function(index, chn) {
    var virtualChID = "_VIRTUAL_RECEIVER",
      noExpertChn;
    if (chn.channelType.indexOf(virtualChID) !== -1) {
      if (expert == 1) {
        result.push(index);
      } else {
       noExpertChn = getOnlyNonExpertChannels(devId, index);
        if (noExpertChn) {
          result.push(noExpertChn);
        }
      }
    }
  });
  return result;
};

HmIPWeeklyProgram = Class.create();

HmIPWeeklyProgram.prototype = {
  initialize: function (address, ps, psDescr, sessionIsExpert) {
    self = this;

    this.DIMMER = "DIMMER_WEEK_PROFILE";
    this.SWITCH = "SWITCH_WEEK_PROFILE";
    this.BLIND = "BLIND_WEEK_PROFILE";

    this.address = address;
    this.arAddress = this.address.split(":");
    this.devAddress = this.arAddress[0];
    this.chn = this.arAddress[1];

    this.device = DeviceList.getDeviceByAddress(this.devAddress);
    this.chnType = this.device.channels[this.chn].channelType;

    this.ps = ps;
    this.psDescr = psDescr;
    this.sessionIsExpert = sessionIsExpert;
    this.prn = 0;
    this.weekDayID = [];
    this.condition = []; // selected value of the parameter WP_CONDITION (_getConditionElm)
    this.activeEntries = [];
    this.numberOfActiveEntries = 0;
    this.curWeekdays = 0;
    this.curTargetChannels = 0;

    this.anchor = jQuery("#weeklyProgram_" + this.chn);
    this.maxEntries = this._getMaxEntries();

    this.virtualChannels = getWPVirtualChannels(this.device.deviceType.id, this.device.channels, this.sessionIsExpert);

    var table = "";
    table += "<table class='ProfileTbl'><tbody>";

    table += "<tr id='weeklyProgramNotActive'><td>"+translateKey('lblWeeklyProgramNotActive')+"</td></tr>";

    table += this._getDelAddElm("ADD_FIRST_ELEM", 0);

    for (var i = 1; i <= this.maxEntries; i++) {
      table += this._getEntry((i < 10) ? "0" + i : i.toString());
    }
    table += "</tbody></table>";

    this.anchor.html(table);

    if ((this.numberOfActiveEntries > 0) && (this.activeEntries["01"] == true)) {
      window.setTimeout(function() {
        jQuery("#weeklyProgramNotActive").hide();
        jQuery("#btnAddNewEntry0").hide();
      }, 250);
    } else if ((this.numberOfActiveEntries > 0) && (this.activeEntries["01"] == false)) {
      window.setTimeout(function() {
        jQuery("#weeklyProgramNotActive").hide();
      }, 250);
    }
  },

  _getEntry: function(number) {
    var programEntry = "";
    var extraClass = "hidden";
    var entryVisibilityCSS = "hidden";

    this._setEntryVisibility(number);

    if (this.activeEntries[number] == true) {
      entryVisibilityCSS = "";
      this.numberOfActiveEntries++;
    }

    programEntry += "<tr id='entry"+number+"' class="+entryVisibilityCSS+"><td><table>";
      programEntry += "<tbody>";
      programEntry += "<tr><td colspan='6'><hr class='CLASS10400'></td></tr>";
      programEntry += "<tr><td>"+translateKey('lblWeeklyProgramSwitchpoint')+ number +"</td></tr>";
        programEntry += "<tr>";
          programEntry += "<td>";

            // CONDITION
            programEntry += "<tr>";
              programEntry += "<td>"+translateKey('lblWPCondition')+"</td>";
              programEntry += "<td colspan='3'>" + this._getConditionElm(number) + "</td>";
            programEntry += "</tr>";

            if (this.condition[number] != 0) {extraClass = "";} else {extraClass="hidden";}

            // ASTRO / FIXED TIME
            programEntry += "<tr id='astroTypeOffset_"+number+"' class="+extraClass+">";
              programEntry += "<td>"+translateKey('lblWPAstroType')+"</td><td>" + this._getAstroType(number) + "</td>";
              programEntry += "<td>"+translateKey('lblWPAstroOffset')+"</td><td>" + this._getAstroOffset(number) + "</td>";
            programEntry += "</tr>";

            if (this.condition[number] == 0 || this.condition[number] > 1) {extraClass="";} else {extraClass="hidden";}

            // FIXED TIME
            programEntry += "<tr id='fixedTime_"+number+"' class="+extraClass+">";
              programEntry += "<td>"+translateKey('lblWPFixedTime')+"</td>";
              programEntry +=" <td>" + this._getFixedTime(number) + "</td>";
            programEntry += "</tr>";

            programEntry += this._getHR();

            // RAMPTIME / LEVEL
            programEntry += "<tr>";
              if (this.chnType == this.DIMMER) {
                // RAMPTIME
                programEntry += "<td>" + translateKey('lblWPRamptime') + "</td>";
                programEntry += "<td>" + this._getRampTime(number) + "</td>";
              }

              // LEVEL
              if ((this.chnType == this.DIMMER)) {
                programEntry += "<td>" + translateKey('lblWPBrightness') + "</td>";
              } else if (this.chnType == this.SWITCH) {
                programEntry += "<td>" + translateKey('lblWPState') + "</td>"; // Is Level, but we call it here state because it's only on/off
              } else if (this.chnType == this.BLIND) {
                programEntry += "<td>" + translateKey('lblWPBlindLevel') + "</td>";
              }
              programEntry += "<td>" + this._getLevel(number) + "</td>";

              // SLAT LEVEL for Blinds
              if (this.chnType == this.BLIND) {
                programEntry += "<td>" + translateKey('lblWPSlatLevel') + "</td>";
                programEntry += "<td>" + this._getSlatLevel(number) + "</td>";
              }

            programEntry += "</tr>";

                // DURATION
            if ((this.chnType == this.DIMMER) || (this.chnType == this.SWITCH)) {
              programEntry += "<tr id='trDurationMode"+number+"'>";
              programEntry += "<td>" + translateKey('lblWPDuration') + "</td>";
              programEntry += "<td>" + this._getDurationMode(number) + "</td>";
              programEntry += "</tr>";

              programEntry += "<tr id='trDurationValue" + number + "'>";
              programEntry += "<td></td>";
              programEntry += "<td>" + this._getDuration(number) + "</td>";
              programEntry += "</tr>";
            }

            programEntry += this._getHR();

            // WEEKDAY
            programEntry += "<tr>";
              programEntry += "<td>"+ translateKey('lblWPWeekday') +"</td>";
              programEntry += "<td colspan='3'>"+ this._getWeekDay(number) +"</td>";
            programEntry += "</tr>";

            // TARGET CHANNELS
            programEntry += "<tr>";
              programEntry += "<td>"+ translateKey('lblWPTargetChannels') +"</td>";
              programEntry += "<td colspan='3'>"+ this._getTargetChannels(number) +"</td>";
            programEntry += "</tr>";
          programEntry += "</td>";
        programEntry += "</tr>";

        // Is the next entry not active AND it's not the last one? If so, then allow to add a new one.
        if ((this.ps[(this._addLeadingZero(parseInt(number) + 1)) + "_WP_WEEKDAY"] == "0") && (parseInt(number) < this.maxEntries)) {
          programEntry += this._getDelAddElm("DEL ADD", number);
        } else {
          programEntry += this._getDelAddElm("DEL", number);
        }

      programEntry += "</tbody>";
    programEntry += "</table></td></tr>";

    return programEntry;
  },

  _isNextEntryInUse: function(number) {
    var nextEntry = parseInt(number) + 1;
    nextEntry = (nextEntry < 10) ? "0" + nextEntry : nextEntry.toString();
    var val = parseInt(jQuery("#separate_CHANNEL_" + this.weekDayID[nextEntry]).val());
    return ( (isNaN(val)) || (val == undefined) || (val == 0)) ? false : true ;
  },


  _getConditionElm: function(number) {
    var self = this,
    result = "",
    selected = "",
    arOptions = [
      translateKey("optionWeekPrgFixed"),
      translateKey("optionWeekPrgAstro"),
      translateKey("optionWeekPrgFixedIfBeforeAstro"),
      translateKey("optionWeekPrgAstroIfBeforeFixed"),
      translateKey("optionWeekPrgFixedIfAfterAstro"),
      translateKey("optionWeekPrgAstroIfAfterFixed"),
      translateKey("optionWeekPrgEarliestOfFixedAndAstro"),
      translateKey("optionWeekPrgLatestOfFixedAndAstro")
    ],

    // If the entry is not active the selected value should be 0
    sel = (this.activeEntries[number] == true ) ? parseInt(this.ps[number +"_WP_CONDITION"]) : 0;

    this.prn++;
    this.condition[number] = parseInt(sel);

    showAstroFixedInputElm = function(elmID, condition) {
      elmID = self._addLeadingZero(elmID);
      self.condition[elmID] = condition;
      var fixedTimeElm = jQuery("#fixedTime_" + elmID),
        astroTypeAndOffset = jQuery("#astroTypeOffset_" + elmID);

      if (condition == 0) {fixedTimeElm.show();astroTypeAndOffset.hide();}
       else if (condition == 1) {fixedTimeElm.hide();astroTypeAndOffset.show();}
       else if (condition > 1)  {fixedTimeElm.show();astroTypeAndOffset.show();}
    };

    showConditionHelp = function() {
      var width = 600,
      height = 450;
      MessageBox.show(translateKey("HmIPWPHelpTitle"), translateKey("HmIPWPConditionHelp"), "", width, height);
    };

    result += "<select id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+number+"_WP_CONDITION' onchange='showAstroFixedInputElm("+number+",parseInt(this.value));'>";
      for (var loop = 0; loop < arOptions.length; loop++) {
        selected = (sel == loop) ? "selected='selected'" : "";
        result += "<option value='"+loop+"' "+selected+">"+arOptions[loop]+"</option>";
      }
    result += "</select>";
    result += "<img src='/ise/img/help.png' style='cursor: pointer; width:18px; height:18px; position:relative; top:2px' onclick='showConditionHelp();'>";

    return result;
  },

  _getFixedTime: function(number) {
    var result = "",
    valHr = (this.activeEntries[number] == true ) ?  parseInt(this.ps[number +"_WP_FIXED_HOUR"]): 0,
    valMin = (this.activeEntries[number] == true ) ? parseInt(this.ps[number +"_WP_FIXED_MINUTE"]) : 0,
    curTime = this._addLeadingZero(valHr) + ":" + this._addLeadingZero(valMin);

    result += "<input type='text' id='fixedTime"+number+"' style='text-align:center' maxlength='5' size='7' value='"+curTime+"'  onblur='checkWPFixedTime(this, "+this.chn+","+(parseInt(this.prn)+1)+")'>";

    result += "<script type='text/javascript'>";
    result += "jQuery( '#fixedTime"+number+"').on( 'keydown', function(event) {";
    result += "    if(event.which == 13)";
    result += "      checkWPFixedTime(this, "+this.chn+","+(parseInt(this.prn)+1)+")";
    result += "  });";
    result += "</script>";

    this.prn++;
    result += "<input type='text' class='hidden' id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+number+"_WP_FIXED_HOUR' value='"+valHr+"' size='2'>";
    this.prn++;
    result += "<input type='text' class='hidden' id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+number+"_WP_FIXED_MINUTE' value='"+valMin+"' size='2'>";
    return result;
  },

  _getAstroType: function(number) {
    var result = "";
    var selected = "";
    var arOptions = [
      translateKey("optionSunrise"),
      translateKey("optionSunset")
    ];

    var sel = (this.activeEntries[number] == true ) ? parseInt(this.ps[number +"_WP_ASTRO_TYPE"]) : 0;
    this.prn++;

    result += "<select id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+number+"_WP_ASTRO_TYPE' >";

    for (var loop = 0; loop < arOptions.length; loop++) {
      selected = (sel == loop) ? "selected='selected'" : "";
      result += "<option value='"+loop+"' "+selected+">"+arOptions[loop]+"</option>";
    }
    result += "</select";

    return result;
  },

  _getAstroOffset: function(number) {
    var result = "",
    astroMin = this.psDescr.ASTRO_OFFSET_MIN,
    astroMax = this.psDescr.ASTRO_OFFSET_MAX,
    astroUnit = this.psDescr.ASTRO_OFFSET_UNIT,
    val = (this.activeEntries[number] == true ) ? parseInt(this.ps[number +"_WP_ASTRO_OFFSET"]) : 0;

    this.prn++;
    result += "<input type='text' id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+number+"_WP_ASTRO_OFFSET' value='"+val+"' size='2' onblur='checkWPMinMaxValue(this,"+astroMin+","+astroMax+")'> "+astroUnit+" ("+astroMin+" - "+astroMax+")";

    result += "<script type='text/javascript'>";
    result += "jQuery( '#separate_CHANNEL_"+this.chn+"_"+this.prn+"').on( 'keydown', function(event) {";
    result += "    if(event.which == 13)";
    result += "      checkWPMinMaxValue(this,"+astroMin+","+astroMax+")";
    result += "  });";
    result += "</script>";
    return result;
  },

  _getDurationMode: function(number) {
    var self = this;

    initDurationMode = function(nr) {
      var number = self._addLeadingZero(nr);
      var valBaseID = number +"_WP_DURATION_BASE",
      valFactorID = number +"_WP_DURATION_FACTOR";

      var valBase = (self.activeEntries[number] == true ) ? parseInt(self.ps[valBaseID]) : 0;
      var valFactor = (self.activeEntries[number] == true ) ? parseInt(self.ps[valFactorID]) : 0;

      var setDurationValueElm = jQuery('#trDurationValue'+number);
      var setDurationModeElm = jQuery('#durationMode'+number);

      if((valBase == 7) && (valFactor == 31)) {
        setDurationValueElm.hide();
        setDurationModeElm.val('0');
        } else {
        setDurationValueElm.show();
        setDurationModeElm.val('1');
      }
    };

    showHideUserValue = function(value, number, prn) {
      var setDurationModeElm = jQuery('#trDurationValue'+self._addLeadingZero(number));
      var factorElm = jQuery("#separate_CHANNEL_"+ self.chn + "_" + (parseInt(prn) + 1));
      var baseElm = jQuery("#separate_CHANNEL_"+ self.chn + "_" + (parseInt(prn) + 2));

      if (parseInt(value) == 0) {
        setDurationModeElm.hide();
        factorElm.val(31);
        baseElm.val(7);
      } else {
        setDurationModeElm.show();
      }
    };

    var result = "";

    result += "<select id='durationMode"+number+"' onchange='showHideUserValue(this.value,"+number+","+this.prn+")'>";
      result += "<option value='0'>"+translateKey('optionPermanent')+"</option>";
      result += "<option value='1'>"+translateKey('optionEnterValue')+"</option>";
    result += "</select>";

    result += "<script type='text/javascript'>";
      result += "window.setTimeout(function(){";
        result += "initDurationMode("+number+");";
      result += "},50)";

    result += "</script>";

    return result;
  },

  _getDuration: function(number) {
    var result = "",
    factorMin = this.psDescr.DURATION_FACTOR_MIN,
    factorMax = this.psDescr.DURATION_FACTOR_MAX,
    valBaseID = number +"_WP_DURATION_BASE",
    valFactorID = number +"_WP_DURATION_FACTOR";

    var valBase = (this.activeEntries[number] == true ) ? parseInt(this.ps[valBaseID]) : 0;
    var valFactor = (this.activeEntries[number] == true ) ? parseInt(this.ps[valFactorID]) : 0;

    var arOptions = ["BASE_100_MS","BASE_1_S","BASE_5_S","BASE_10_S","BASE_1_M","BASE_5_M","BASE_10_M","BASE_1_H"];

    this.prn++;
    result += "<input type='text' id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+valFactorID+"' value='"+valFactor+"' size='2' class='alignCenter' onblur='checkWPMinMaxValue(this,"+factorMin+","+factorMax+")'>";
    result += " x ";

    result += "<script type='text/javascript'>";
    result += "jQuery( '#separate_CHANNEL_"+this.chn+"_"+this.prn+"').on( 'keydown', function(event) {";
    result += "    if(event.which == 13)";
    result += "      checkWPMinMaxValue(this,"+factorMin+","+factorMax+")";
    result += "  });";
    result += "</script>";

    this.prn++;
    result += "<select id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+valBaseID+"'>";
      jQuery.each(arOptions, function(index, value) {
        if (index != valBase) {
          result += "<option value='" + index + "'>" + translateKey(value) + "</options>";
        } else {
          result += "<option selected='selected' value='" + index + "'>" + translateKey(value) + "</options>";
        }
      });
    result += "</select>";

    return result;
  },

  _getRampTime: function(number) {
    var result = "",
    factorMin = this.psDescr.RAMP_TIME_FACTOR_MIN,
    factorMax = this.psDescr.RAMP_TIME_FACTOR_MAX,
    valBaseID = number +"_WP_RAMP_TIME_BASE",
    valFactorID = number +"_WP_RAMP_TIME_FACTOR";

    var valBase = (this.activeEntries[number] == true ) ? parseInt(this.ps[valBaseID]) : 0;
    var valFactor = (this.activeEntries[number] == true ) ? parseInt(this.ps[valFactorID]) : 0;

    var arOptions = ["BASE_100_MS","BASE_1_S","BASE_5_S","BASE_10_S","BASE_1_M","BASE_5_M","BASE_10_M","BASE_1_H"];

    this.prn++;
    result += "<input type='text' id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+valFactorID+"' value='"+valFactor+"' size='2' class='alignCenter' onblur='checkWPMinMaxValue(this,"+factorMin+","+factorMax+")'>";
    result += " x ";

    result += "<script type='text/javascript'>";
    result += "jQuery( '#separate_CHANNEL_"+this.chn+"_"+this.prn+"').on( 'keydown', function(event) {";
    result += "    if(event.which == 13)";
    result += "      checkWPMinMaxValue(this,"+factorMin+","+factorMax+")";
    result += "  });";
    result += "</script>";

    this.prn++;
    result += "<select id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+valBaseID+"'>";
      jQuery.each(arOptions, function(index, value) {
        if (index != valBase) {
          result += "<option value='" + index + "'>" + translateKey(value) + "</options>";
        } else {
          result += "<option selected='selected' value='" + index + "'>" + translateKey(value) + "</options>";
        }
      });
    result += "</select>";

    return result;
  },

  _getLevel: function(number) {
    var result = "",
    paramID = number +"_WP_LEVEL",
    val = (this.activeEntries[number] == true ) ? (1 * this.ps[paramID]).toFixed(3) : "0.000";

    // For blinds this has no effect because there is no duration
    showHideDuration = function(val, elmNr) {
      elmNr = self._addLeadingZero(elmNr);
      var durationModeElm = jQuery('#durationMode'+elmNr),
      trDurationModeElm = jQuery('#trDurationMode'+elmNr),
      trDurationValueElm = jQuery('#trDurationValue'+elmNr);

      if ((val == "0") || (val == "0.000")) {
        trDurationModeElm.hide();
        trDurationValueElm.hide();
      } else {
        trDurationModeElm.show();
        if (durationModeElm.val() != "0") {
          trDurationValueElm.show();
        }
      }
    };

    this.prn++;
     result += "<select id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+paramID+"' onchange='showHideDuration(this.value, "+number+");'>";
      if ((this.chnType == this.DIMMER) || (this.chnType == this.BLIND)) {

        if (this.chnType == this.DIMMER) {
          result += "<option value='0'>" + translateKey('optionOFF') + "</option>";
          for (var loop = 5; loop <= 100; loop += 5) {
            result += "<option value='" + (loop / 100).toFixed(3) + "'>" + loop + " %</options>";
          }
        } else {
          for (var loop = 0; loop <= 100; loop += 5) {
            result += "<option value='" + (loop / 100).toFixed(3) + "'>" + loop + " %</options>";
          }
        }

        result += "<option value='1.005'>"+translateKey('optionOldLevel')+"</option>";
        result += "<option value='1.010'>"+translateKey('optionNoChange')+"</option>";
      } else if (this.chnType == this.SWITCH) {
        result += "<option value='0.000'>" + translateKey('optionStateOFF') + "</option>";
        result += "<option value='1.000'>" + translateKey('optionStateON') + "</option>";
      }

    result += "</select>";

    result += "<script type='text/javascript'>";
      result += "window.setTimeout(function(){";
        result += "jQuery('#separate_CHANNEL_"+this.chn+"_"+this.prn+"').val('"+val+"');";
        result += "showHideDuration("+val+","+number+")";
      result += "},100);";
    result += "</script>";
    return result;

  },

  _getSlatLevel: function(number) {
    var result = "",
    paramID = number +"_WP_LEVEL_2",
    val = (this.activeEntries[number] == true ) ? (1 * this.ps[paramID]).toFixed(3) : "0.000";

    this.prn++;
    result += "<select id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+paramID+"'>";

      //result += "<option value='0'>"+translateKey('optionOFF')+"</option>";
      for (var loop = 0; loop <= 100; loop += 5) {
        result += "<option value='" + (loop / 100).toFixed(3) + "'>" + loop + " %</options>";
      }
      result += "<option value='1.005'>"+translateKey('optionOldLevel')+"</option>";
      result += "<option value='1.010'>"+translateKey('optionNoChange')+"</option>";

    result += "</select>";

    result += "<script type='text/javascript'>";
      result += "window.setTimeout(function(){";
        result += "jQuery('#separate_CHANNEL_"+this.chn+"_"+this.prn+"').val('"+val+"');";
      result += "},100);";
    result += "</script>";

    return result;
  },

  _getWeekDay: function(number) {
    var result = "";
    var paramID = number +"_WP_WEEKDAY";
    var val = parseInt(this.ps[paramID]);
    this.curWeekdays = val;
    this.prn++;
    this.weekDayID[number] = this.chn+"_"+this.prn;

    result += "<table><tbody><tr>";
      result += "<td>";
        result += "<label for='weekDayMO"+number+"'>"+translateKey('Mon')+"</label>";
        result += "<input id='weekDayMO"+number+"' type='checkbox' value='2' name='weekDay"+this.chn+"_"+number+"' onchange='setWPWeekday(this,"+this.chn+","+this.prn+")'>";
      result += "</td>";
      result += "<td>";
        result += "<label for='weekDayTU"+number+"'>"+translateKey('Tue')+"</label>";
        result += "<input id='weekDayTU"+number+"' type='checkbox' value='4' name='weekDay"+this.chn+"_"+number+"' onchange='setWPWeekday(this,"+this.chn+","+this.prn+")'>";
      result += "</td>";
      result += "<td>";
        result += "<label for='weekDayWED"+number+"'>"+translateKey('Wed')+"</label>";
        result += "<input id='weekDayWED"+number+"' type='checkbox' value='8' name='weekDay"+this.chn+"_"+number+"' onchange='setWPWeekday(this,"+this.chn+","+this.prn+")'>";
      result += "</td>";
      result += "<td>";
        result += "<label for='weekDayTHU"+number+"'>"+translateKey('Thu')+"</label>";
        result += "<input id='weekDayTHU"+number+"' type='checkbox' value='16' name='weekDay"+this.chn+"_"+number+"' onchange='setWPWeekday(this,"+this.chn+","+this.prn+")'>";
      result += "</td>";
      result += "<td>";
        result += "<label for='weekDayFR"+number+"'>"+translateKey('Fri')+"</label>";
        result += "<input id='weekDayFR"+number+"' type='checkbox' value='32' name='weekDay"+this.chn+"_"+number+"' onchange='setWPWeekday(this,"+this.chn+","+this.prn+")'>";
      result += "</td>";
      result += "<td>";
        result += "<label for='weekDaySAT"+number+"'>"+translateKey('Sat')+"</label>";
        result += "<input id='weekDaySAT"+number+"' type='checkbox' value='64' name='weekDay"+this.chn+"_"+number+"' onchange='setWPWeekday(this,"+this.chn+","+this.prn+")'>";
      result += "</td>";
      result += "<td>";
        result += "<label for='weekDaySUN"+number+"'>"+translateKey('Sun')+"</label>";
        result += "<input id='weekDaySUN"+number+"' type='checkbox' value='1' name='weekDay"+this.chn+"_"+number+"'  onchange='setWPWeekday(this,"+this.chn+","+this.prn+")'>";
      result += "</td>";
      result += "<td>";
        result += "<input type='text' id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+paramID+"' value='"+val+"' size='3' class='hidden'>";
      result += "</td>";
    result += "</tr></tbody></table>";

    // Init checkboxes
    result += "<script type='text/javascript'>";
      result += "window.setTimeout(function(){";
        result += "var iSelectedDays = " +parseInt(this.curWeekdays) + ";";
        result += "var bSelectedDays = iSelectedDays.toString(2);";
        result += "var tmp = '';";


        result += "for (var loop = 0; loop <= (6 - bSelectedDays.length); loop++) {";
          result += "tmp += '0';";
        result += "}";

        result += "bSelectedDays = tmp + bSelectedDays;";

        result += "jQuery('#weekDayMO"+number+"').attr('checked', (bSelectedDays[5] == '1') ? true : false );";
        result += "jQuery('#weekDayTU"+number+"').attr('checked', (bSelectedDays[4] == '1') ? true : false );";
        result += "jQuery('#weekDayWED"+number+"').attr('checked', (bSelectedDays[3] == '1') ? true : false );";
        result += "jQuery('#weekDayTHU"+number+"').attr('checked', (bSelectedDays[2] == '1') ? true : false );";
        result += "jQuery('#weekDayFR"+number+"').attr('checked', (bSelectedDays[1] == '1') ? true : false );";
        result += "jQuery('#weekDaySAT"+number+"').attr('checked', (bSelectedDays[0] == '1') ? true : false );";
        result += "jQuery('#weekDaySUN"+number+"').attr('checked', (bSelectedDays[6] == '1') ? true : false );";
      result += "},50);";
    result += "</script>";

    return result;
  },

  _getTargetChannels: function(number) {
    var self = this;
    var result = "";
    var paramID = number +"_WP_TARGET_CHANNELS";
    var val = (this.activeEntries[number] == true ) ? parseInt(this.ps[paramID]) : 0;
    this.curTargetChannels = val;
    this.prn++;

    result += "<table><tbody><tr>";

      jQuery.each(this.virtualChannels,function(index,value){
        result += "<td>";
          result += "<label for='targetChannel"+number+"_"+index+"'>"+self.virtualChannels[index]+"</label>";
          result += "<input id='targetChannel"+number+"_"+index+"' type='checkbox' value='"+Math.pow(2,index)+"' onchange='setWPTargetChannels(this,"+self.chn+","+self.prn+")'>";
        result += "</td>";
      });

      result += "<td>";
        result += "<input type='text' id='separate_CHANNEL_"+this.chn+"_"+this.prn+"' name='"+paramID+"' value='"+val+"' size='3' class='hidden'>";
      result += "</td>";
    result += "</tr></tbody></table>";

    // Init checkboxes
    result += "<script type='text/javascript'>";
      result += "window.setTimeout(function(){";
        result += "var iSelectedChn = " +parseInt(this.curTargetChannels) + ";";
        result += "var bSelectedChn = iSelectedChn.toString(2);";
        result += "var reversedBinary = reverseString(bSelectedChn);";

        result += "for (var loop = 0; loop < reversedBinary.length; loop++) {";
          result += "jQuery('#targetChannel"+number+"_'+loop).attr('checked', (reversedBinary[loop] == '1') ? true : false );";
        result += "}";

      result += "},50);";
    result += "</script>";

    return result;
  },

  _getHR: function() {
    return "<tr><td colspan='6'><hr></td></tr>";
  },

  _getDelAddElm: function(mode, number) {
    var self = this,
    classAddElm = "",
    classDelElm = "";

    deleteEntry = function(number) {
      self.numberOfActiveEntries--;
      if (parseInt(number) == 1) {
        jQuery("#btnDelEntry0").hide();
        jQuery("#btnAddNewEntry0").show();
      }

      if (self.numberOfActiveEntries >= 1) {
          number = self._addLeadingZero(number);
          jQuery("#weeklyProgramNotActive").hide();
          //jQuery("#entry" + number).hide();
          jQuery("#entry" + number).fadeOut();
          self.activeEntries[number] = false;
          jQuery("#separate_CHANNEL_" + self.weekDayID[number]).val(0);
          jQuery("#btnAddNewEntry" + (self._addLeadingZero(parseInt(number) - 1))).show();
      } else {
        self.numberOfActiveEntries = 0;
        number = self._addLeadingZero(number);
        //jQuery("#entry" + number).hide();
        jQuery("#entry" + number).fadeOut();
        jQuery("#separate_CHANNEL_" + self.weekDayID[number]).val(0);
        self.activeEntries[number] = false;
        jQuery("#weeklyProgramNotActive").show();
        jQuery("#btnAddNewEntry0").show();
      }
    };

    addEntry = function(elm, number) {
      self.numberOfActiveEntries++;
      var nextNumber = parseInt(number) + 1;
      jQuery("#weeklyProgramNotActive").hide();

      self.activeEntries[self._addLeadingZero(nextNumber)] = true;
      if(self.activeEntries["01"] == true) {
        jQuery("#btnAddNewEntry0").hide();
      }

      jQuery("#btnAddNewEntry" + (self._addLeadingZero(parseInt(number)))).hide();
      jQuery("#entry"+self._addLeadingZero(nextNumber)).show();

      jQuery("#separate_CHANNEL_" + self.weekDayID[self._addLeadingZero(nextNumber)]).val(127);
      jQuery("[name='weekDay"+self.chn+"_"+self._addLeadingZero(nextNumber)+"']").attr("checked", true);

      if ( (! self._isNextEntryInUse(nextNumber)) && (parseInt(nextNumber) < self.maxEntries)) {
        jQuery("#btnAddNewEntry" + (self._addLeadingZero(parseInt(nextNumber)))).show();
      } else {
        jQuery("#btnAddNewEntry" + (self._addLeadingZero(parseInt(nextNumber)))).hide();
      }
      jQuery("#btnDelEntry"+self._addLeadingZero(nextNumber)).get(0).scrollIntoView({behavior:'smooth', block:'end'});
      //jQuery("#btnDelEntry"+self._addLeadingZero(nextNumber)).get(0).scrollIntoView(false);
    };




    if (mode == "DEL") {
      classAddElm = "hidden";
    } else if (mode == "ADD_FIRST_ELEM") {
      classDelElm = "hidden";
    }

    var panel = "",
      delElm = "<td id='btnDelEntry"+number+"' class='"+classDelElm+"'><img src='/ise/img/cc_delete.png'  title='"+translateKey('lblDelSwitchPoint')+"' alt='Remove entry' style='width: 24px; height: 24px; cursor: pointer;' onclick='deleteEntry("+number+");'></td>",
      addElm = "<td id='btnAddNewEntry"+number+"' class='"+classAddElm+"'><img src='/ise/img/add.png' title='"+translateKey('lblAddSwitchPoint')+"' alt='Add entry' style='width: 24px; height: 24px; cursor: pointer;' onclick='addEntry(this,"+number+");'></td>";

    panel += "<tr>";
      panel += delElm;
      panel += addElm;
    panel += "</tr>";
    return panel;
  },

  _getMaxEntries: function() {
    // return 5; // Set the value for testing reasons to a low level - remove this after testing

    return 75;

    /*
    switch (this.chnType) {
      case "DIMMER_WEEK_PROFILE":
        return 75;
      case "SWITCH_WEEK_PROFILE":
      case "BLIND_WEEK_PROFILE":
        return 85;
      default: return -1;
    }
    */
  },



  // Check if the parameter weekday is in use.
  // If this is not the case the entry shouldn`t be visible and all values of the entry are 0
  _setEntryVisibility: function(number) {
    var val = parseInt(this.ps[number +"_WP_WEEKDAY"]);
    this.activeEntries[number] = (val == 0) ? false : true ;
   },

  _addLeadingZero: function(val) {
    return (parseInt(val) < 10) ? "0"+val : val;
  }
};
