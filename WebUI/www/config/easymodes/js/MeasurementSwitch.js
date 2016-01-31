measurementSwitch = {


  init: function(channel) {
    this.channel = channel;
    this._setSelectors(this.channel);
    this._bindEvents(this.channel);
  },

  _getActiveProfile: function(ch) {

    if (! this.isDelayValDefault(ch)) {
      return 0; // Expert
    }

    var txCyclicAboveVal = jQuery("#separate_CHANNEL_" + ch + "_3").prop("checked"), // checkbox COND_TX_ABOVE
      txCyclicBelowVal = jQuery("#separate_CHANNEL_" + ch + "_4").prop("checked"), // checkbox COND_TX_Below
      txFallingVal = jQuery("#separate_CHANNEL_" + ch + "_7").prop("checked"), // checkbox COND_TX_FALLING
      txRisingVal = jQuery("#separate_CHANNEL_" + ch + "_8").prop("checked"); // checkbox COND_TX_RISING

    var result = 4;
    var decisionValOk = true;

    if (txCyclicBelowVal || txCyclicAboveVal) result = 0; // Expert
    if (!txCyclicAboveVal && txRisingVal && decisionValOk) result = 1;
    if (!txCyclicBelowVal && txFallingVal && decisionValOk) result = 2;
    if (!txCyclicAboveVal && !txCyclicBelowVal && txRisingVal && txFallingVal && decisionValOk) result = 3;

    return result;
  },

  isDelayValDefault: function(ch) {
    var eventDelayUnit = parseInt(jQuery(".j_powerDelayUnit").first().val()),
    eventDelayVal = parseInt(jQuery(".j_powerDelayVal").first().val());

    if ((eventDelayUnit > 0) || (eventDelayVal > 0)) {
      return false;
    }
    return true;
  },

  _getSelectBox: function() {
    return jQuery("#"+this.channel.toLowerCase()+"SelectId");
  },

  _getProfileDescrSel: function() {
    return jQuery("#profileDescription" +this.channel);
  },

  _setSelectors: function() {
    var chn = this.channel.toLowerCase();
    this.hideAllSel = ".j_"+chn+".j_expert, .j_"+chn+".j_tmp";
    this.showExpertSel = ".j_"+chn+".j_expert";
    this.showUpperValSel = ".j_"+chn+".j_upperVal, .j_"+chn+".j_upperTmpVal0";
    this.showLowerValSel = ".j_"+chn+".j_lowerVal, .j_"+chn+".j_lowerTmpVal1";
    this.showLowerTmpValSel = ".j_"+chn+".j_tmp";
    this.showUpperTmpValSel = ".j_"+chn+".j_tmp";
  },

  _bindEvents: function() {
    var self = this,
      selectBox = this._getSelectBox();

    selectBox.on("change",function() {
      var selectedElm = jQuery("#"+jQuery(this).attr('id')+" :selected").val();
      switch (selectedElm) {
        case "0":
          self.showExpert();
          break;
        case "1":
          // High
          self.showUpperVal(self.ch);
          break;
        case "2":
          // Low
          self.showLowerVal(self.ch);
          break;
        case "3":
          // Master Slave
          self.showMasterSlave(self.ch);
          break;
        case "4":
          // Not Used
          self.showNotUsed();
      }
    });
  },

  _hideAllParams : function() {
    jQuery(this.hideAllSel).addClass("hidden");
  },
  _hideTmpValues: function() {
    jQuery(this.showLowerTmpValSel+", "+this.showUpperTmpValSel).addClass("hidden");
  },

  _setSelectBox: function (val) {
    var selectBox = this._getSelectBox();
    selectBox.val(val);
  },

  showExpert : function() {
    this._hideAllParams();
    this._getProfileDescrSel().html("");
    jQuery(this.showExpertSel).removeClass("hidden");
  },

  showUpperVal : function(ch) {
    this._hideAllParams();
    var decisionVal = jQuery("#separate_CHANNEL_" + ch + "_5").val();
    this._getProfileDescrSel().html(translateKey("stringTableCondTxRisingA") + decisionVal + translateKey("stringTableCondTxRisingB"));
    jQuery(this.showUpperValSel).removeClass("hidden");
  },

  showLowerVal : function(ch) {
    this._hideAllParams();
    var decisionVal = jQuery("#separate_CHANNEL_" + ch + "_6").val();
    this._getProfileDescrSel().html(translateKey("stringTableCondTxFallingA")+ decisionVal + translateKey("stringTableCondTxFallingB"));
    jQuery(this.showLowerValSel).removeClass("hidden");
  },

  showMasterSlave: function(ch) {
    this._hideAllParams();
    var decisionValHigh = jQuery("#separate_CHANNEL_" + ch + "_5").val(),
    decisionValLow = jQuery("#separate_CHANNEL_" + ch + "_6").val();

    this._getProfileDescrSel().html(translateKey("stringTableCondTxFallingRisingA") + decisionValHigh + translateKey("stringTableCondTxFallingRisingB") + decisionValLow + translateKey("stringTableCondTxFallingRisingC"));
    jQuery(this.showUpperValSel+", "+this.showLowerValSel).removeClass("hidden");
    this._hideTmpValues();
  },

  showNotUsed: function() {
    this._hideAllParams();
    this._getProfileDescrSel().html(translateKey("stringTableCondTxNotActive"));
  },

  showActiveProfile: function(ch) {
    this.ch = ch;
    var activeProfile = this._getActiveProfile(ch).toString();
    switch (activeProfile) {
      case "0":
        this._setSelectBox(0);
        this.showExpert();
        break;
      case "1":
        this._setSelectBox(1);
        this.showUpperVal(ch);
        break;
      case "2":
        this._setSelectBox(2);
        this.showLowerVal(ch);
        break;
      case "3":
        this._setSelectBox(3);
        this.showMasterSlave(ch);
        break;
      case "4":
        this._setSelectBox(4);
        this.showNotUsed();
        break;
      default:
        this._setSelectBox(0);
        this.showExpert();
        break;
    }
  }
};

getChannel = function(elem) {
  return elem.id.split("_")[2];
};

getSelectElem = function(channel) {
  var chn = channel.toLowerCase();
  return jQuery("#" + chn + "SelectId");
};

getSelectedValue = function(channel) {
  var selElem = getSelectElem(channel);
  return jQuery( "#"+jQuery(selElem).attr('id')+" :selected" ).val();
};

setExtraParamter = function(ch, mode) {
  var txCyclicAboveElem = jQuery("#separate_CHANNEL_" + ch + "_3"), // checkbox COND_TX_ABOVE
    txCyclicBelowElem = jQuery("#separate_CHANNEL_" + ch + "_4"), // checkbox COND_TX_Below
    txFallingElem = jQuery("#separate_CHANNEL_" + ch + "_7"), // checkbox COND_TX_FALLING
    txRisingElem = jQuery("#separate_CHANNEL_" + ch + "_8"), // checkbox COND_TX_RISING
    txDecisionAboveElem = jQuery("#separate_CHANNEL_" + ch + "_5"),// checkbox COND_TX_DECISION_ABOVE
    txDecisionBelowElem = jQuery("#separate_CHANNEL_" + ch + "_6"), // checkbox COND_TX_DECISION_BELOW
    unitEventDelay = jQuery("#separate_CHANNEL_" + ch + "_9.j_powerDelayUnit"),
    valEventDelay = jQuery("#separate_CHANNEL_" + ch + "_10.j_powerDelayVal");

  switch (mode) {
    case "lowerVal":
      txCyclicAboveElem.attr("checked",false);
      txCyclicBelowElem.attr("checked",false);
      txFallingElem.attr("checked", false);
      txRisingElem.attr("checked", true);
      txDecisionAboveElem.val("200");
      txDecisionBelowElem.val("0");
      unitEventDelay.val("0");
      valEventDelay.val("0");
      break;
    case "upperVal":
      txCyclicAboveElem.attr("checked",false);
      txCyclicBelowElem.attr("checked",false);
      txFallingElem.attr("checked", true);
      txRisingElem.attr("checked", false);
      txDecisionAboveElem.val("200");
      txDecisionBelowElem.val("0");
      unitEventDelay.val("0");
      valEventDelay.val("0");
      break;
    case "masterSlave":
      txCyclicAboveElem.attr("checked",false);
      txCyclicBelowElem.attr("checked",false);
      txFallingElem.attr("checked", true);
      txRisingElem.attr("checked", true);
      txDecisionAboveElem.val("200");
      txDecisionBelowElem.val("0");
      unitEventDelay.val("0");
      valEventDelay.val("0");
      break;
    case "notUsed":
      txCyclicAboveElem.attr("checked",false);
      txCyclicBelowElem.attr("checked",false);
      txFallingElem.attr("checked", false);
      txRisingElem.attr("checked", false);
      unitEventDelay.val("0");
      valEventDelay.val("0");
      break;
  }
};


setModeParameters = function(channelType, mode, elem) {
  var thresElemLoId = "COND_TX_THRESHOLD_LO_" + channelType,
    thresElemHiId = "COND_TX_THRESHOLD_HI_" + channelType,
    thresElemLo = jQuery("[name='"+thresElemLoId+"']").first(), // LO value elem
    thresElemHi = jQuery("[name='"+thresElemHiId+"']").first(), // HI value elem
    ch = getChannel(elem);

  if (mode == "lowerVal") {
    // Switch when value > maxVal
    thresElemLo.val(parseFloat(elem.value));
    setExtraParamter(ch, mode);
  } else if (mode == "upperVal") {
    // Switch when value < maxVal
    thresElemHi.val(parseFloat(elem.value));
    setExtraParamter(ch, mode);
  }
};

isValValid = function (elem, chType, hmip) {
  var valLO=0, valHI= 0,
    nameCondTxThresholdHi = (!hmip) ? "COND_TX_THRESHOLD_HI_" + chType : "COND_TX_THRESHOLD_HI",
    nameCondTxThresholdLo = (!hmip) ? "COND_TX_THRESHOLD_LO_" + chType : "COND_TX_THRESHOLD_LO";

  if (0 != getSelectedValue(chType)) {
    if ((elem.name.indexOf("THRESHOLD_HI") != -1) || ((elem.name.indexOf("lowerVal") != -1)))  {
      valHI = parseFloat(jQuery("[name='"+nameCondTxThresholdHi+"']").first().val());
      valLO = parseFloat(jQuery("[name='lowerVal_"+chType+"']").first().val());
    } else if ((elem.name.indexOf("THRESHOLD_LO") != -1) || ((elem.name.indexOf("upperVal") != -1))) {
      valLO = parseFloat(jQuery("[name='"+nameCondTxThresholdLo+"']").first().val());
      valHI = parseFloat(jQuery("[name='upperVal_"+chType+"']").first().val());
    }
  } else {
    // Expert mode
    valLO = parseFloat(jQuery("[name='"+nameCondTxThresholdLo+"']").first().val());
    valHI = parseFloat(jQuery("[name='"+nameCondTxThresholdHi+"']").first().val());
  }
  return (valHI > valLO) ? true : false;

};

correctValues = function(chType, hmip) {
  // chType = POWER, CURRENT, VOLTAGE or FREQUENCY

  var nameCondTxThresholdHi = (!hmip) ? "COND_TX_THRESHOLD_HI_" + chType : "COND_TX_THRESHOLD_HI",
  nameCondTxThresholdLo = (!hmip) ? "COND_TX_THRESHOLD_LO_" + chType : "COND_TX_THRESHOLD_LO";

  var loElem = jQuery("[name='"+nameCondTxThresholdLo+"']").first(),
    hiElem = jQuery("[name='"+nameCondTxThresholdHi+"']").first(),
    lowerValPower = jQuery("[name='lowerVal_"+chType+"']").first(),
    upperValPower = jQuery("[name='upperVal_"+chType+"']").first();

  switch (chType) {
    case "POWER" :
        if (parseFloat(hiElem.val()) > 10) {
          loElem.val(parseFloat(hiElem.val()) - 10);
        } else {
          hiElem.val(parseFloat(loElem.val()) + 10);
        }
      break;
    case "CURRENT" :
      if (parseFloat(hiElem.val()) > 100) {
        loElem.val(parseFloat(hiElem.val()) - 100);
      } else {
        hiElem.val(parseFloat(loElem.val()) + 100);
      }
      break;
    case "VOLTAGE" :
      if (parseFloat(hiElem.val()) > 135) {
        loElem.val(parseFloat(hiElem.val()) - 20);
      } else {
        hiElem.val(parseFloat(loElem.val()) + 20);
      }
      break;
    case "FREQUENCY" :
      if (parseFloat(hiElem.val()) > 50) {
        loElem.val(parseFloat(hiElem.val()) - 0.2);
      } else {
        hiElem.val(parseFloat(loElem.val()) + 0.2);
      }
      break;
  }
  lowerValPower.val(parseFloat(loElem.val()));
  upperValPower.val(parseFloat(hiElem.val()));
};

setVal = function(elem, chType) {
  var channelType = (elem.name.split("_")[4]) ? elem.name.split("_")[4] : elem.name.split("_")[1], // E. g. POWER, CURRENT, ...
  ch = getChannel(elem),
  hmip = false;

  if (chType != undefined) {
    channelType = chType;
    hmip = true;
  }
  if (channelType) {
    var selMode = getSelectedValue(channelType);
    if(!isValValid(elem, channelType, hmip )) {
      //alert(selMode + ": Die HI-Schwelle muss gr&ouml;sser als die LO-Schwelle sein");
      alert(translateKey("PMSwMeasurementHiLoAlert_"+selMode));
      correctValues(channelType, hmip);
      return;
    }
  }
  // Only if no expert and if no master slave
  if (selMode == 1 || selMode == 2) {
    // Main value changed
    if (elem.name.indexOf("THRESHOLD_HI") != -1) {
      var thresElemId = elem.name.replace(/HI/, "LO"),
        thresElem = jQuery("[name='"+thresElemId+"']"), // LO value elem
        thresVal = parseFloat(jQuery("[name='lowerVal_"+channelType+"']").first().val());
      //thresElem.val(parseFloat(elem.value) - thresVal);
      thresElem.val(thresVal);
      setExtraParamter(ch, "lowerVal");
    } else if (elem.name.indexOf("THRESHOLD_LO") != -1) {
      // LO Wert
      var thresElemId = elem.name.replace(/LO/, "HI"),
        thresElem = jQuery("[name='"+thresElemId+"']"), // HI value elem
        thresVal = parseFloat(jQuery("[name='upperVal_"+channelType+"']").first().val());
      //thresElem.val(parseFloat(elem.value) + thresVal);
      thresElem.val(thresVal);
      setExtraParamter(ch, "upperVal");
    }
    // Threshold changed
    var valElem = elem.name.split("_")[0];
    if (valElem == "lowerVal" || valElem == "upperVal") {
      setModeParameters(channelType, valElem, elem);
    }
  } else if(selMode == 3) {
    setExtraParamter(ch, "masterSlave");
  }
};

triggerBlur = function(ch) {
  // This is necessary to simulate a change of the value - otherwise nothing will be transmitted.
  var HiElm = jQuery("#separate_CHANNEL_" + ch + "_" + 1),
    LoElm = jQuery("#separate_CHANNEL_" + ch + "_" + 2),
    origHi = HiElm.val(),
    origLo = LoElm.val();
  if (HiElm) {HiElm.val(origHi+ " ");}
  if (LoElm) {LoElm.val(origLo+ " ");}
};

setMode = function(elem, ch) {
  var selMode = jQuery("#"+elem.id+ " :selected").val();
  switch (selMode) {
    case "1":
      setExtraParamter(ch, "lowerVal");
      triggerBlur(ch);
      break;
    case "2":
      setExtraParamter(ch, "upperVal");
      triggerBlur(ch);
      break;
    case "3":
      setExtraParamter(ch, "masterSlave");
      triggerBlur(ch);
      break;
    case "4":
      setExtraParamter(ch, "notUsed");
      triggerBlur(ch);
      break;
  }

  translatePage("id_channel_parameters_table");

};