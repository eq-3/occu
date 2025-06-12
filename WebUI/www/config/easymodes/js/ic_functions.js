/**
 * ic_functions.js
 **/

prefix = [];
switch_dir = 1;
switch_on_off = false;
free_time = 0;
free_perc = 0;
free_temp = 0;
exists_timearr = "";
exists_percarr = "";
exists_temparr = "";
time_textcolor = 0;
perc_textcolor = 0;
temp_textcolor = 0;
_textcolor = 0;
time_tmp = "";
perc_tmp = "";
temp_tmp = "";
exists_bib = [] ;
arChnHasLinks = [];
wgtHasLinksOrPrograms = false;

getInternalKeySpecialInputId = function(arrId) 
{
  var id = "";
  var arrIdLength = arrId.length - 1;

  for (var loop = 0; loop < arrIdLength; loop++) {
    id += arrId[loop];
    
    if ((loop + 1) < arrIdLength) {
     id += "_";       
    }           
  }
  return id;    
};

ActivateFreeTime4InternalKey = function(selectelem, pref)
{
  ActivateFreeTime(selectelem, pref, true);   
};

ActivateFreeTime = function(selectelem, pref, internalKey)
{
  //alert($('selectelem').id + " pref= " + pref);  
  var pnr = selectelem.options[selectelem.selectedIndex].value;  
  var upnr = pnr.split(".")[1];
  var intkey = selectelem.id.split("_")[0].slice(8);

  if (isNaN(upnr) == true) {
    var arrSpecialInputId = selectelem.id.split("_");
     var special_input_id = arrSpecialInputId[0]; 
  
    if (internalKey) {
      special_input_id = getInternalKeySpecialInputId(arrSpecialInputId);
    }

     var selectedvalue = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).value; //4  
    var parameter = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).name; //5   
    var sec = document.getElementById("vis_sec_" + pnr + "_" + pref + "_" + special_input_id);
    var min = document.getElementById("vis_min_" + pnr + "_" + pref + "_" + special_input_id);
    var hour = document.getElementById("vis_hour_" + pnr + "_" + pref + "_" + special_input_id);
    var x_max = selectelem.length + 1;
    //6  
    if (pnr > x_max) {x_max = parseInt(pnr) + 1;}
    var y_max = 15;

    //7 
    if (exists_timearr != "ok" || time_tmp != x_max) 
    {
      //8
      time2d = [];
      for (var i = 0; i < x_max; ++i) 
      time2d[i] = [];
      exists_timearr = "ok"; 
      time_tmp = x_max;     //9
    }

    time2d[pnr][pref] = 0;
    prefix[parameter + special_input_id] = pnr + "_" + pref + "_" + special_input_id; 

    if (selectedvalue == "99999999")
    {
      if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "hidden";
        document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = "gray";
        if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "hidden";
      }
    time2d[pnr][pref] = 1; //10 
      hour.style.display = "inline";
      min.style.display = "inline";
      sec.style.display = "inline";
    }
    else 
    { 
      if (free_time != 1 && free_perc != 1 && free_temp != 1) {
      if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
          if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
        }
    } else  document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);

      time2d[pnr][pref] = 0; //11 

      hour.style.display = "none";
      min.style.display = "none";
      sec.style.display = "none";
    }
    free_time = 0; //12
    for (var loopx = 0; loopx < x_max; loopx++){
      for (var loopy = 0; loopy < y_max; loopy++){
          if (time2d[loopx][loopy] == 1) {free_time = 1; break;}
      }
    }

    for (loopy = 0; loopy <= y_max; loopy++) {
      if (time2d[pnr][loopy] == 1)   {time_textcolor = 1; break;}
      else time_textcolor = 0;
    }

      if (time_textcolor == 0 && perc_textcolor == 0 && temp_textcolor == 0) _textcolor = 0;
      else _textcolor = 1;
      document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);

      if (free_time == 0 && free_perc == 0 && free_temp == 0) {
        if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
          if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
        }
    }
  }
};

// Ausgelagert nach www_source/ise/js/function.js
// Kann hier entfernt werden.
_encodeString = function(elem)
{
  //wird nur für die Übersetzung der Parameter des HM-PB-4Dis-WM genutzt, 
  //da dort einige Zeichen an anderer Stelle liegen.

  var inString = $F("_" + elem);
  var outString = inString.replace(/Ä/g, "[");
  outString = outString.replace(/Ö/g, "#");
  outString = outString.replace(/Ü/g, "$");
  outString = outString.replace(/ä/g, "{");  
  outString = outString.replace(/ö/g, "|");  
  outString = outString.replace(/ü/g, "}");  
  outString = outString.replace(/ß/g, "~");  
  outString = outString.replace(/&/g, "]");
  outString = outString.replace(/=/g, "'");

  $(elem).value = outString;
};



ActivateFreeValue = function(selectelem, pref, internalKey)
{
  var pnr = selectelem.options[selectelem.selectedIndex].value; //1
  var upnr = pnr.split(".")[1];
  var intkey = selectelem.id.split("_")[0].slice(8);
  var val2d, val_tmp, exists_valarr, free_val;


  //2
  if (isNaN(upnr) == true) {
    // var special_input_id = selectelem.id.split("_")[0]; //3
    var arrSpecialInputId = selectelem.id.split("_");
    var special_input_id = arrSpecialInputId[0];

    if (internalKey) {
      special_input_id = getInternalKeySpecialInputId(arrSpecialInputId);
    }

    var selectedvalue = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).value; //4
    var parameter = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).name; //5
    var val = document.getElementById("vis_val_" + pnr + "_" + pref + "_" + special_input_id);
    var x_max = selectelem.length + 1;
    //6
    if (pnr > x_max) {x_max = parseInt(pnr) + 1;}
    var y_max = 15;

    //7
    if (exists_valarr != "ok" || val_tmp != x_max)
    {
      //8
      val2d = [];
      for (i = 0; i < x_max; ++i)
        val2d[i] = [];
      exists_valarr = "ok";
      val_tmp = x_max; //9
    }
    val2d[pnr][pref] = 0;

    prefix[parameter + special_input_id] = pnr + "_" + pref + "_" + special_input_id;

    if (selectedvalue == "99999990" )
    {
      if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "hidden";
        document.getElementById(special_input_id +  "_profiles").options[selectelem.selectedIndex].style.color = "gray";
        if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "hidden";
      }
      val2d[pnr][pref] = 1; //10
      val.style.display = "inline";

    } else {
      if (free_time != 1 && free_val != 1 && free_temp != 1) {
        if (intkey == "" && !internalKey) {
          document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
          if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
        }
      } else  document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);

      val2d[pnr][pref] = 0; //11
      val.style.display = "none";
    }

    free_val = 0; //12
    for (var loopx = 0; loopx < x_max; loopx++){
      for (var loopy = 0; loopy < y_max; loopy++){
        if (val2d[loopx][loopy] == 1) {free_val = 1; break;}
      }
    }
    for (loopy = 0; loopy <= y_max; loopy++) {
      if (val2d[pnr][loopy] == 1)   {perc_textcolor = 1; break;}
      else perc_textcolor = 0;
    }

    if (time_textcolor == 0 && perc_textcolor == 0 && temp_textcolor == 0) _textcolor = 0;
    else _textcolor = 1;
    document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);

    if (free_time == 0 && free_val == 0 && free_temp == 0) {
      if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
        if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
      }
    }
  }
};






















ActivateFreePercent4InternalKey = function(selectelem, pref)
{
  ActivateFreePercent(selectelem, pref, true);   
};

ActivateFreePercent = function(selectelem, pref, internalKey)
{
  var pnr = selectelem.options[selectelem.selectedIndex].value; //1
  var upnr = pnr.split(".")[1];
    var intkey = selectelem.id.split("_")[0].slice(8);

  //2
  if (isNaN(upnr) == true) {
    // var special_input_id = selectelem.id.split("_")[0]; //3
    var arrSpecialInputId = selectelem.id.split("_");
    var special_input_id = arrSpecialInputId[0]; 

    if (internalKey) {
      special_input_id = getInternalKeySpecialInputId(arrSpecialInputId);
    } 

    var selectedvalue = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).value; //4 
    var parameter = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).name; //5  
    var percent = document.getElementById("vis_percent_" + pnr + "_" + pref + "_" + special_input_id);
    var x_max = selectelem.length + 1; 
    //6 
    if (pnr > x_max) {x_max = parseInt(pnr) + 1;}
    var y_max = 15;
    
    //7
    if (exists_percarr != "ok" || perc_tmp != x_max) 
    {
      //8
      perc2d = [];
      for (i = 0; i < x_max; ++i) 
      perc2d[i] = [];
      exists_percarr = "ok";
      perc_tmp = x_max; //9
    }
    perc2d[pnr][pref] = 0;
    
    prefix[parameter + special_input_id] = pnr + "_" + pref + "_" + special_input_id; 
    
    if (selectedvalue == "99999998" )
    {   
      if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "hidden";
        document.getElementById(special_input_id +  "_profiles").options[selectelem.selectedIndex].style.color = "gray";
        if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "hidden";
      }
      perc2d[pnr][pref] = 1; //10
      percent.style.display = "inline";
    
    } else { 
      if (free_time != 1 && free_perc != 1 && free_temp != 1) {
      if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
        if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
        }
      } else  document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);
      
      perc2d[pnr][pref] = 0; //11 
      percent.style.display = "none";
    }
    
    free_perc = 0; //12 
    for (var loopx = 0; loopx < x_max; loopx++){
      for (var loopy = 0; loopy < y_max; loopy++){
        if (perc2d[loopx][loopy] == 1) {free_perc = 1; break;}
      }
    }
    for (loopy = 0; loopy <= y_max; loopy++) {
      if (perc2d[pnr][loopy] == 1)   {perc_textcolor = 1; break;}
      else perc_textcolor = 0;
    }
    
    if (time_textcolor == 0 && perc_textcolor == 0 && temp_textcolor == 0) _textcolor = 0;
    else _textcolor = 1;
    document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);

    if (free_time == 0 && free_perc == 0 && free_temp == 0) {
      if (intkey == "" && !internalKey) {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
      if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
      }
    }
  }
};



ActivateFreeTemp = function(selectelem, pref)
{
  var pnr = selectelem.options[selectelem.selectedIndex].value; //1
  var upnr = pnr.split(".")[1];
  var intkey = selectelem.id.split("_")[0].slice(8);

  //2
  if (isNaN(upnr) == true) {
    var special_input_id = selectelem.id.split("_")[0]; //3 
    var selectedvalue = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).value; //4 
    var parameter = document.getElementById("separate_" + special_input_id + "_" + pnr + "_" + pref).name; //5  
    var temperatur = document.getElementById("vis_temp_" + pnr + "_" + pref + "_" + special_input_id);
    var x_max = selectelem.length + 1;
    //6 
    if (pnr > x_max) {x_max = parseInt(pnr) + 1;}
    var y_max = 15;
    //7
    if (exists_temparr != "ok" || temp_tmp != x_max) 
    {
      //8
      temp2d = [];
      for (var i = 0; i < x_max; ++i) 
      temp2d[i] = [];
      exists_temparr = "ok";
      temp_tmp = x_max; //9
    }
    temp2d[pnr][pref] = 0;
    
    prefix[parameter + special_input_id] = pnr + "_" + pref + "_" + special_input_id; 
      
    if (selectedvalue == "99999997" )
    {
    if (intkey == "") {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "hidden";
        document.getElementById(special_input_id +  "_profiles").options[selectelem.selectedIndex].style.color = "gray";
        if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "hidden";
      }
    temp2d[pnr][pref] = 1; //10
      temperatur.style.display = "inline";
    
    } else { 
      if (free_time != 1 && free_perc != 1 && free_temp != 1) {
      if (intkey == "") {
       document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
         if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
        }
    } else  document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);
      
      temp2d[pnr][pref] = 0; //11
      temperatur.style.display = "none";
    }
  
    free_temp = 0; //12 
    for (var loopx = 0; loopx < x_max; loopx++){
      for (var loopy = 0; loopy < y_max; loopy++){
        if (temp2d[loopx][loopy] == 1) {free_temp = 1; break;}
      }
    }
    
    for (loopy = 0; loopy <= y_max; loopy++) {
      if (temp2d[pnr][loopy] == 1)   {temp_textcolor = 1; break;}
      else temp_textcolor = 0;
    }
    
    if ((time_textcolor == 0) && (perc_textcolor == 0) && (temp_textcolor == 0)) { _textcolor = 0; }
    else _textcolor = 1;
    document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);
    
    if ((free_time == 0) && (free_perc == 0) && (free_temp == 0))
    {
    if (intkey == "") {
        document.getElementById("NewProfileTemplate_receiver").style.visibility = "visible";
        if (CheckGroup()) document.getElementById("NewProfileTemplate_receivergroup").style.visibility = "visible";
      }
  }
  }
};

BLIND_fetchType = function(id) {
  var arrID = id.split("_");
  var type = "";

  for (var loop = 1; loop < arrID.length; loop++) {
    type += arrID[loop];
    
    if ((loop + 1) < arrID.length) {
      type += "_";        
    } 
  }
  return type;
};

BLIND_setPosition = function(id)
{
  var type = BLIND_fetchType(id);
  var index = $(id).selectedIndex; 
  var v_up = "visible";
  var v_down = "hidden";
  var d_up = "";
  var d_down = "none";

  if (index == 1) {v_up = "hidden"; v_down = "visible"; d_up = "none"; d_down = "";} 
  else if (index == 2) {v_up = "visible"; v_down = "visible"; d_up = ""; d_down = "";}


  $("upLevel_" + type).style.visibility = v_up;
  $("downLevel_" + type).style.visibility = v_down;
  $("upTime_" + type).style.visibility = v_up;
  $("downTime_" + type).style.visibility = v_down;
  $("upDelayTime_" + type).style.visibility = v_up;
  $("downDelayTime_" + type).style.visibility = v_down;

  $("upLevel_" + type).style.display = d_up;
  $("downLevel_" + type).style.display = d_down;
  $("upTime_" + type).style.display = d_up;
  $("downTime_" + type).style.display = d_down;
  $("upDelayTime_" + type).style.display = d_up;
  $("downDelayTime_" + type).style.display = d_down;

};

jalousieShowSlatInputElem = function(id, chn) {
  var selValue = jQuery("#"+id).val(),
    jalousieSlatPosOffElm = jQuery("#jalousieSlatPosOff_" + chn),
    jalousieSlatPosOnElm = jQuery("#jalousieSlatPosOn_" + chn);

  switch (selValue) {
    case "1":
        jalousieSlatPosOffElm.hide();
        jalousieSlatPosOnElm.show();
      break;
    case "2":
        jalousieSlatPosOnElm.hide();
        jalousieSlatPosOffElm.show();
      break;
    case "3":
        jalousieSlatPosOnElm.show();
        jalousieSlatPosOffElm.show();
      break;
  }
};

Disable_SimKey = function(ch, prn, specialInputId) 
{
  var arrSpecialInputId = specialInputId.split("_"),
  pref_dirty = false,
  i = 1,
  jBtnSim = $("SimKey_" + arrSpecialInputId[1] + "_" +  arrSpecialInputId[2] + "_" + prn),
  jBtnLongSim = $("SimLongKey_" + arrSpecialInputId[1] + "_" +  arrSpecialInputId[2] + "_" + prn),
  jHintSim = $("SimKeyHint_" + arrSpecialInputId[1] + "_" +  arrSpecialInputId[2] + "_" + prn);
  
  if (jBtnSim) {

    while ($('separate_' +  specialInputId + '_' + prn + '_' + i))
    {
      if (IsDirty($('separate_' + specialInputId + '_' + prn + '_' + i))) 
      {
        pref_dirty = true;
      }
      i++;
    }

     if ( (pref_dirty == true ) || ( IsDirty($(specialInputId + '_profiles')) ) ) 
    {
      jBtnSim.disabled = true;
      if (jBtnLongSim) jBtnLongSim.disabled = true;
      //jBtnSim.value = "Simulation nicht möglich!";
      jBtnSim.value = translateKey("simulateKeyPressBtnTxtNotPossible");
      if (jBtnLongSim) jBtnLongSim.value = translateKey("simulateKeyPressBtnTxtNotPossible");
      jHintSim.style.display = "inline";
    } 
    else
    {
      jBtnSim.disabled = false;
      if (jBtnLongSim) jBtnLongSim.disabled = false;
      //jBtnSim.value = "Simuliere Tastendruck";
      jBtnSim.value = translateKey("btnSimKeyPress");
      if (jBtnLongSim) jBtnLongSim.value = translateKey("btnSimLongKeyPress");
      jHintSim.style.display = "none";
    }
  }
};


MD_catchBrightness = function(url, sender_address, receiver_address, brightness, convertValue, paramType, set_value, id, commando, parameter)
{
  // knownBrightness is used to prevent unnecessary calls for the converting of the current brightness while building the page.
  // Each profile of the easymode needs the brightness, so we store the value for 500 ms in the var knownBrightness
  if (typeof knownBrightness == "undefined") {
    var curBrightness = homematic("Interface.getValue", {"interface": "HmIP-RF", "address": sender_address, "valueKey": paramType});
    brightness =  (curBrightness) ? parseFloat(curBrightness).toFixed(2) : parseFloat(brightness).toFixed(2);

    conInfo("sender_address: " + sender_address +" - paramType: " + paramType + " - current brightness via getValue: " + curBrightness + " - calculated brightness: " + brightness);

    arID = id.split("_");
    jQuery("#brightDescr_"+arID[2]).css("display", "inline");
    jQuery("#okButton_"+arID[2]).css("display", "inline");

    if (! commando.includes("help_active_")) {
      //jQuery("#usrDefBrightness_" + arID[2]).val(brightness);
       jQuery("#usrDefBrightness_" + arID[2]+ "_" + arID[3]).val(brightness);
    }

    if (convertValue == 1) {
      var oSender = DeviceList.getDeviceByAddress(sender_address.split(":")[0]),
        devDescr = homematic("Interface.getDeviceDescription", {
          "interface": oSender.interfaceName,
          "address": oSender.address
        });

      if ((oSender.typeName.indexOf("HmIPW-") != -1) || ((oSender.typeName.indexOf("HmIP-") != -1) && (devDescr.firmware.split(".")[0] >= 2))) {
        brightness = MD_convertIlluminationToDecisionValue_V2(brightness);
      } else {
        // Old calculation method
        brightness = MD_convertIlluminationToDecisionValue(brightness, oSender.typeName, devDescr.firmware);
      }
    }
    knownBrightness = brightness;
    window.setTimeout(function() {delete knownBrightness;}, 500);
  } else {
    brightness = knownBrightness;
  }

  if (brightness < 0) {brightness = 0.0;}

  ResetPostString();
  poststr += "&url=" +url;
  poststr += "&sender_address="   +sender_address;
  poststr += "&receiver_address=" +receiver_address;
  poststr += "&set_value=" +set_value;
  poststr += "&id=" +id;
  poststr += "&commando=" +commando;
  poststr += "&parameter=" +parameter;
  poststr += "&active_bright=" + $F(id);
  poststr += "&brightness=" + brightness;
  SendRequest('ic_md.cgi');
};

MD_channel_help = function()
{
  var contentElm = jQuery("#content"),
  helpContentElm = jQuery("#md_ch_help"),
  helpBtnElm =  jQuery("#md_help_button");

  if (helpBtnElm.val() == translateKey("genericBtnTxtHelp"))
  {
    helpContentElm.css("display","inline");
    helpBtnElm.val(translateKey("genericBtnTxtHelpOff"));
    contentElm.animate({scrollTop: contentElm.height()},1000);
  } else {
    contentElm.animate({scrollTop: parseInt(0)},1000, function() {
      helpContentElm.fadeOut(800);
      helpBtnElm.val(translateKey("genericBtnTxtHelp"));
    });

  }
};

MD_checkMaxValue = function(id_on_time, channel, id_on_time_mode)
{
  // mode 0 = absolut, mode 1 = minimal
  var  prn = id_on_time.split("_")[2];
  var  pref = id_on_time.split("_")[3];
  var val = $F(id_on_time);
  
  // mode 0 = absolut, mode 1 = minimal
  var mode = $F(id_on_time_mode);

  if (mode == 0) $('hint_'+ prn + '_' + pref).firstChild.data = " ";


  if ((val > 120 || mode == 1 ) && channel == 1 ) 
  {
    if (val > 120) {
      $(id_on_time).options[$(id_on_time).length -1].style.color = WebUI.getColor('red');
      $(id_on_time).options[$(id_on_time).length -1].style.textDecoration = 'blink';
      $(id_on_time).options[$(id_on_time).length -1].style.fontStyle = 'italic';
    }

    switch (mode) {
      
      case("0"):   $('hint_'+ prn + '_' + pref).style.color = WebUI.getColor('red');
            $('hint_'+ prn + '_' + pref).firstChild.data = unescape(localized[0]['hint_ontime_0']);
            break;

      case("1"):  $('hint_'+ prn + '_' + pref).style.color = WebUI.getColor('red');
            $('hint_'+ prn + '_' + pref).firstChild.data = unescape(localized[0]['hint_ontime_0']);
            $('hint_'+ prn + '_' + pref).firstChild.data += unescape(localized[0]['hint_ontime_1']);
            break;
    }
  }
};



MD_checkPNAME = function(id, param, id_on_time)
{
  if ($(id).selectedIndex == 0) {$(param).firstChild.data = unescape(localized[0]['md_on_time']);}
  else {$(param).firstChild.data = unescape(localized[0]['md_min_on_time']);}

  var prn = id.split("_")[2];
  var pref = id.split("_")[3];
  var md_min_interval = "md_min_interval_" + prn + "_" + pref;

  var min_interval = $F(md_min_interval).split(",")[0]; // enthaelt den Wert des Kanalparameters 'Mindestsendeabstand'. Moegl. Werte 0, 1, 2, 3, 4
  $(md_min_interval).value = min_interval + "," + $(id).selectedIndex;
  
  
  var min_value = [15, 30, 60, 120, 240];
  var h = "hour_" + id_on_time.split("_")[2] + "_" + id_on_time.split("_")[3] + "_" + id_on_time.split("_")[1];
  var m = h.replace('hour_', 'min_');
  var s = h.replace('hour_', 'sec_');

  var t = (parseFloat($F(h)) * 3600) + (parseFloat($F(m)) * 60) + parseFloat($F(s));

  if (t < min_value[min_interval] && $(id).selectedIndex !== 0 ) 
  {
    $(s).value = min_value[min_interval];  
    MD_set_h_m_s(h, m, s);
  }
  
  
  if ($F(id_on_time) < min_value[min_interval] && $(id).selectedIndex == 0)
  {
    jQuery('#'+id_on_time + '_hint0:first-child').html(unescape(localized[0]['hint0a']) +  min_value[min_interval] + unescape(localized[0]['hint0b']));
    jQuery('#'+id_on_time + '_hint1:first-child').html(unescape(localized[0]['hint1a']) +  min_value[min_interval] + unescape(localized[0]['hint1b']));
  } else {
    $(id_on_time + '_hint0').firstChild.data = " "; 
    $(id_on_time + '_hint1').firstChild.data = " "; 
  }
};

MD_init = function(id, min, max)
{
  var input = document.getElementById(id);
  var ausdr_int  = /\d+/;
  if (ausdr_int.test(input.value)) {var wert_int = ausdr_int.exec(input.value); wert_int = wert_int[0];}
  var wert     = min;
  var channel = id.split("_")[2];
  var txtIndex = (parseInt(id.split("_")[3]) + 1);

  if (! wert_int) {wert = min;} //1 
  if (! isNaN(wert_int)) {wert = wert_int;}

  if (wert < min) {wert = min;}
  if (wert > max) {wert = max;}
    
  input.value = wert;

  if (input.name == "EVENT_FILTER_NUMBER")
  {
    var efn = document.getElementsByClassName('event_filter_number_' + channel);
    if (wert == 1) 
    {
      //input.options[0].text = "jedem";
      input.options[0].text = translateKey("motionDetectorEventFilterNumberA");
      //efn[0].firstChild.data = " Sensor-Impuls";
      efn[0].firstChild.data = translateKey("motionDetectorEventFilterNumberB");
      efn[1].firstChild.data = " ";

      $('separate_CHANNEL_' + channel + '_' + txtIndex).style.display = "none";
    } else
    {
      input.options[0].text = "1";
      //efn[0].firstChild.data = " Sensor-Impulsen innerhalb ";
      efn[0].firstChild.data = translateKey("motionDetectorEventFilterNumberC");
      //efn[1].firstChild.data = " Sekunden";
      efn[1].firstChild.data = translateKey("motionDetectorEventFilterNumberD");
      $('separate_CHANNEL_' + channel + '_'+ txtIndex).style.display = "inline";
    }
  }

  if (input.name == "BRIGHTNESS_FILTER")
  {
   // var brightness = document.getElementsByClassName('brightness')[0];
    var brightness = document.getElementsByClassName('brightness_' + channel)[0];
    //if (wert == 0)   brightness.firstChild.data = "der zuletzt ermittelte Wert";
    if (wert == 0)   brightness.firstChild.data = translateKey("motionDetectorMinumumOfLastValuesB0");
    //else brightness.firstChild.data = "das Minimum der letzten " + (parseInt(input.value) + 1) + " Werte";
    else brightness.firstChild.data = translateKey("motionDetectorMinumumOfLastValuesB1") + (parseInt(input.value) + 1) + translateKey("motionDetectorMinumumOfLastValuesC");
  }
};

MD_getHelp = function(min, max, brightness, activeBright, ready, isHmIP)
{
  // liest die Hilfedatei für den MotionSensor ein
//  var language = $F('language') ;
  var language = getLang(),
   font_bold = "\"font-style:normal; font-weight:bold\"",
   font_underline = "\"font-style:normal; text-decoration:underline\"",
   active = localized[0]['active_' + ready],
   fileName0 = (isHmIP) ? 'MOTION_DETECTOR_HMIP_0.txt' : 'MOTION_DETECTOR_0.txt',
   fileName1 = (isHmIP) ? 'MOTION_DETECTOR_HMIP_1.txt' : 'MOTION_DETECTOR_1.txt';

  //Je nachdem, ob die aktuelle Helligkeit zur Verfügung steht, oder nicht, werden verschiedene Hilfstexte generiert.
  if (brightness != -1) {
    var path = '/config/easymodes/etc/localization/' + language + '/' + fileName1;
  } else {
    var path = '/config/easymodes/etc/localization/' + language + '/' + fileName0;
  }
  
  // die entsprechende Uebersetzungstabellen der Easymodes einlesen
  new Ajax.Request(path ,
  {
    method:    'get',
    asynchronous: false,
    onSuccess: function(success) {
      help_txt = eval(success.responseText);
    },

    onFailure: function(failure) {
      Ajax_failure(path, failure.statusText);
    }
  });
  return help_txt;
};

MD_link_help = function()
{
  // Hilfetext für die Art der Verweildauer des Motion-Detectors
  var help_txt = MD_getHelp();
  
  MessageBox.show(help_txt[0]['title_kind_of'], help_txt[0]['help_kind_of'] ,"" ,450 , 260);
};

MD_catchBright_help = function(min, max, brightness, activeBright, ready, condition, sensorAddress) {
  var isHmIP = (sensorAddress.split(":")[0].length > 10) ? true : false;
  //Hilfetext für die Helligkeitsschwelle des Motion-Detectors
  var help_txt = MD_getHelp(min, max, brightness, activeBright, ready, isHmIP);

  if (condition == "LT_LO") {
    MessageBox.show(help_txt[0]['title_brightness'], help_txt[0]['help_brightness_active_LT_LO'], "", 475, (isHmIP) ? 350 : 185);
  } else {
    MessageBox.show(help_txt[0]['title_brightness'], help_txt[0]['help_brightness_active_GE_LO'], "", 475, (isHmIP) ? 350 : 185);
  }
};

MD_minInterval = function(id)
{
  var modus = $(id).selectedIndex; // 0 = klassisch, 1 = dynamisch  
  var min_interval_txt = $('min_interval');

  var arId = id.split("_");
  var min_interval = $(arId[0] + "_" + arId[1] + "_" + arId[2] + "_" + (parseInt(arId[3]) + 1));

  //var txt = "Mindestsendeabstand";
  var txt = translateKey("motionDetectorMinimumOnAirInterval");

  if (modus == 0) 
  {  
    //txt = "Sendeabstand";
    txt = translateKey("motionDetectorOnAirInterval");
    var newEntry = new Option("240s", "4", false, true);
    min_interval.options[min_interval.length] = newEntry ;
    
    min_interval.disabled = true;
  } else
  {
    //txt = "Mindestsendeabstand";
    txt = translateKey("motionDetectorMinimumOnAirInterval");
  //  Mehr als 5 Eintraege vorhanden?
  //  min_interval.options[0].selected = true;
    if (min_interval.length == 6) 
    {
      min_interval.options[min_interval.length -1] = null;
      min_interval.options[min_interval.length -1] = null;
    }
    
    if (min_interval.length == 5) 
    {
      min_interval.options[min_interval.length -1] = null;
    }
    
    min_interval.disabled = false;
  }

  //  folgende Zeile bewirkt einen Wechsel des Textes PROFILE_PNAME(C)
    min_interval_txt.firstChild.data = txt;
};

MD_proofClassic = function(id)
{
  // die hardcodierten id's muessen noch dynamisiert werden
  var arId = id.split("_");

  var min_interval = $(arId[0] + "_" + arId[1] + "_" + arId[2] + "_" + (parseInt(arId[3]) + 1));

  if (min_interval.value == min_interval.length - 1) 
  {
    $(id).options[0].selected = true;

  } else 
  {
    $(id).options[1].selected = true;
  }
  
  MD_minInterval(id);
};

MD_set_h_m_s = function(id_h, id_m, id_s)
{
  var h, m, s;
  switch ($F(id_s)) {

  case "15":
    h = '00'; m = '00'; s = '15';
    break;
  case "30":
    h = '00'; m = '00'; s = '30';
    break;
  case "60":
    h = '00'; m = '01'; s = '00';
    break;
  case "120":
    h = '00'; m = '02'; s = '00';
    break;
  case "240":
    h = '00'; m = '05'; s = '00'; //klassich minimum 5 Minuten (4 Min + Toleranz)
    break;
  }

  $(id_h).value = h; 
  $(id_m).value = m; 
  $(id_s).value = s; 
};

MD_setMode = function(id_on_time_mode, channel, id_on_time)
{
  MD_checkMaxValue(id_on_time, channel, (id_on_time_mode));
};

// Converts the value of the parameter ILLUMINATION of e. g. a HmIP-MotionDetector (very high values possible)
// to a valid decision value (0 - 255) for the use of direct links (CONDITION_LO/HI)
MD_convertIlluminationToDecisionValue = function(value, typeTransmitter, devFwVersion) {
  conInfo("Here we work with the brightness value calculated with the old method");
  var result = 0,
   linearLimit = 80,
   resultDivider = 20,
   msb = "0x80000",
   exp = 19,
   val = parseInt(value);

  var arFw = devFwVersion.split("."),
    fwMajor = parseInt(arFw[0]),
    fwMinor = parseInt(arFw[1]),
    fwPatch = parseInt(arFw[2]);

  var idHmIP = "HmIP-";

  // TWIST-1746
  if (
      typeTransmitter == idHmIP + "SPI"
    || typeTransmitter == idHmIP + "SMI55"
    || ((typeTransmitter == idHmIP + "SMI") && (((fwMajor == 1) && (fwMinor >= 5)) || ((fwMajor == 1) && (fwMinor == 4) && (fwPatch >= 10))))
    || ((typeTransmitter == idHmIP + "SMO") && (((fwMajor == 1) && (fwMinor >= 3)) || ((fwMajor == 1) && (fwMinor == 2) && (fwPatch >= 10))))
    ) {
    linearLimit = 75;
    resultDivider = 21;
    msb = "0x800000";
    exp = 23;
    conInfo("Calculation lux -> condition value for SPI / SMI55 / SMI fw >= 1.4.10 / SMO fw >= 1.2.10");
  } else {
    conInfo("Calculation lux -> condition value for SMI fw < 1.4.10 / SMO fw < 1.2.10");
  }

  val *= 10;

  if (val < linearLimit) {return val;} // Linear-Grenze

  while ((val & msb) == 0) {
   msb >>= 1;
   exp--;
  }

  var result = (((val^msb) << 8) / msb) | (exp << 8);
  result /= resultDivider;

  if (result > 255) {
    result = 255;
  }

  return parseInt(result);
};

// SPHM-301
MD_convertIlluminationToDecisionValue_V2 = function(value) {
  conInfo("Here we work with the brightness value calculated with the new method");
  var brightness = (isNaN(value)) ? 0 :  parseInt(Math.abs(value) * 100),
    convBrightness,
    offset_x,
    value_a0,
    value_a1,
    valueValid = true;

  switch (true) {
    case (brightness <= Math.pow(10,1)):
      offset_x = 0;
      value_a0 = 0;
      value_a1 = 1;
      break;
    case (brightness <= Math.pow(10,2)):
      offset_x = 10;
      value_a0 = 10;
      value_a1 = 0.2;
      break;
    case (brightness <= Math.pow(10,3)):
      offset_x = 100;
      value_a0 = 28;
      value_a1 = 0.05;
      break;
    case (brightness <= Math.pow(10,4)):
      offset_x = 1000;
      value_a0 = 73;
      value_a1 = 0.005;
      break;
    case (brightness <= Math.pow(10,5)):
      offset_x = 10000;
      value_a0 = 118;
      value_a1 = 0.0005;
      break;
    case (brightness <= Math.pow(10,6)):
      offset_x = 100000;
      value_a0 = 163;
      value_a1 = 0.00005;
      break;
    case (brightness <= Math.pow(10,7)):
      offset_x = 1000000;
      value_a0 = 208;
      value_a1 = 0.000005;
      break;
    default: valueValid = false;

  }
  if (valueValid) {
    convBrightness = brightness - offset_x;
    convBrightness = convBrightness * value_a1;
    convBrightness = convBrightness + value_a0;
    convBrightness = convBrightness + 0.5;
    return parseInt(convBrightness);
  }
  return 253;
};

SetSensitivityOfMotionDetection = function(sensElmID) {
  var sensElm = jQuery("#" + sensElmID ),
    sensElmFirstOption = jQuery("#" + sensElmID + " > option:first-child"),
    lblSensorImpulsElm = jQuery("#lblSensorImpuls"),
    extendedOptions = jQuery("#extendedOptions");

  if (parseInt(sensElm.val()) > 1) {
    sensElmFirstOption.text("1");
    lblSensorImpulsElm.text(translateKey("motionDetectorEventFilterNumberC")); // Sensor-Impulsen innerhalb
    extendedOptions.show();
  } else {
    sensElmFirstOption.text("jedem");
    lblSensorImpulsElm.text(translateKey("motionDetectorEventFilterNumberB")); // Sensor-Impuls
    extendedOptions.hide();
  }
};

ProofFreeTime = function(id, min, max)
{
  var input = $(id);
  input.value = input.value.replace(/,/g,".");
  //1 
  var ausdr_float = /\d+.\d+/;
  var ausdr_int  = /\d+/;
  if (ausdr_float.test(input.value)) {var wert_float = ausdr_float.exec(input.value); wert_float = wert_float[0];}
  if (ausdr_int.test(input.value)) {var wert_int = ausdr_int.exec(input.value); wert_int = wert_int[0];}
//  if (min == 0) {min = '00'};
  var wert     = '00';

  if (! wert_int) {wert = '00';} //2
  if (! isNaN(wert_int)) {wert = wert_int;}
  if (! isNaN(wert_float)) {wert = wert_float;}
  
   
  if (id.indexOf('hour_') != -1)
  {

    if (wert < min) {wert = min;}
    if ((wert * 3600) > max) 
    {  
      input.value = (max / 3600);
    
      min_id = id.replace('hour_', 'min_');
      input = $(min_id);
      input.value = '00';

      sec_id = id.replace ('hour_', 'sec_');
      input = $(sec_id);
      input.value = '00';
    }  else {input.value = wert;} 

  } 
  else 
  { 
    if (id.indexOf('min_') != -1) 
    {
      if (wert < min) {wert = min;}
      hour_id = id.replace('min_', 'hour_');
      hour_input = $(hour_id);
      if (hour_input.value >= (max / 3600)) {input.value = '00';} else {input.value = wert;}
    } 
    else 
    {
       if(id.indexOf('sec_') != -1)
      {
        if (wert < min) {wert = min;}
        hour_id = id.replace('sec_', 'hour_');
        hour_input = $(hour_id);
        if (hour_input.value >= (max / 3600)) { input.value = '00';} else {input.value = wert;}
      }
    }
  }

  //3 
  var prn = id.split("_")[1];
  var pref = 1;
  
  try
  {
    x = $F("md_min_interval_" + prn + "_" + pref);
    if (x) throw "true";
    else throw "false";
  }
  catch (ergebniss)
  {
    if (ergebniss == "true") 
    {
      var hit = 1;
    } else hit = 0;
  }
  
  if ($F('dev_descr_sender_tmp').split("-")[0] == "MOTION_DETECTOR" && hit == 1)
  {
    var prn = id.split("_")[1];
    var pref = 1;
    var md_verweild = "md_verweildauer_" + prn + "_" + pref;
    var md_min_interval = "md_min_interval_" + prn + "_" + pref;
  
    // enthaelt den Wert des Geraeteparameters 'SHORT_ON_TIME_MODE'. Moegl. Werte 0 und 1
    var absolute_minimal = $F(md_min_interval).split(",")[1];

    try
    {
      if ($(md_verweild).data) throw true;
      else throw false;
    }
    catch (ergebniss)
    {
      if (ergebniss == true) md_verweildauer = true;
      else md_verweildauer = false;
    }
    
    //if (md_verweildauer == true) {$('md_verweildauer').data = "Verweildauer";}
    if (md_verweildauer == true) {$('md_verweildauer').data = translateKey("motionDetectorRetentionTime");}

    if (absolute_minimal == 1) //wenn Modus 'minimal' 
    {
      var profile = $(id).name.split("_");
      //4   
      var param_tmp = $('separate_receiver_' + profile[1] + "_" + profile[2]).name.split("|");
      param_tmp = param_tmp[0].split("_");
      var param = param_tmp[1] + "_" + param_tmp[2];
    
      if (param == "ON_TIME" || param == "OFF_TIME") 
      {
        var min_interval = $F(md_min_interval).split(",")[0]; // enthaelt den Wert des Kanalparameters 'Mindestsendeabstand'. Moegl. Werte 0, 1, 2, 3, 4
        var min_value = [15, 30, 60, 120, 240];
        var h = "hour_" + id.split("_")[1] + "_" + id.split("_")[2] + "_" + id.split("_")[3];
        var m = h.replace('hour_', 'min_');
        var s = h.replace('hour_', 'sec_');
        var t = (parseFloat($F(h)) * 3600) + (parseFloat($F(m)) * 60) + parseFloat($F(s));
        
        if (t < (min_value[min_interval] + 1) && $(id).selectedIndex !== 0 ) 
        {
          $(s).value = min_value[min_interval]; 
          MD_set_h_m_s(h, m, s);
        } 
      }
      //if (md_verweildauer == true) {$('md_verweildauer').data = "Mindestverweildauer";}
      if (md_verweildauer == true) {$('md_verweildauer').data = translateKey("motionDetectorMinimumRetentionTime");}
    }
  }
};

ProofFreePercent = function(id, min, max)
{
  var input = document.getElementById(id);
  
  var ausdr_float = /\d+.\d+/;
  var ausdr_int  = /\d+/;
  if (ausdr_float.test(input.value))
  {
    var wert_float = ausdr_float.exec(input.value);
    wert_float = wert_float[0];
  }
  if (ausdr_int.test(input.value)) 
  {
    var wert_int = ausdr_int.exec(input.value);
    wert_int = wert_int[0];
  }
  if (min == 0) { min = '00'; }
  var wert = '00';

  if (!(wert_int))          { wert = '00'; } //1 
  if (!(isNaN(wert_int)))   { wert = wert_int; }
  if (!(isNaN(wert_float))) { wert = wert_float; }
  
  if (wert < (min * 100)) { wert = (min * 100); }
  if (wert > (max * 100)) { wert = (max * 100); }
    
  input.value = wert;
};

ProofFreeTemp = function(id, min, max, unit)
{
  var input = document.getElementById(id);
  var ausdr_float = /\d+.\d+/; 
  var ausdr_int  = /\d+/;
  if (ausdr_float.test(input.value)) 
  {
    var wert_float = ausdr_float.exec(input.value);
    wert_float = wert_float[0];
  }
  if (ausdr_int.test(input.value))
  {
    var wert_int = ausdr_int.exec(input.value);
    wert_int = wert_int[0];
  }
  var wert     = min;

  if (unit) //1
  {
    min = ((min * 9) / 5) + 32 ;
    max = ((max * 9) / 5) + 32 ;
  }

  if (!(wert_int))          {wert = min; }    //2 
  if (!(isNaN(wert_int)))   {wert = wert_int; }
  if (!(isNaN(wert_float))) {wert = wert_float; }

  if (wert < min) { wert = min; }
  if (wert > max) { wert = max; }
    
  input.value = wert;
};

ProofFreeValue = function(id, min, max)
{
  var input = document.getElementById(id);
  var ausdr_float = /\d+.\d+/; 
  var ausdr_int  = /\d+/;
  if (ausdr_float.test(input.value)) 
  {
    var wert_float = ausdr_float.exec(input.value);
    wert_float = wert_float[0];
  }
  if (ausdr_int.test(input.value))
  {
    var wert_int = ausdr_int.exec(input.value);
    wert_int = wert_int[0];
  }
  var wert     = min;

  if (!(wert_int))          { wert = min; } //1 
  if (!(isNaN(wert_int)))   { wert = wert_int; }
  if (!(isNaN(wert_float))) { wert = wert_float; }


  if (wert < min) {wert = min; }
  if (wert > max) {wert = max; }
    
  input.value = wert;
};

proofMinMax4Voltage_X = function(param) {
  var voltage0 = "VOLTAGE_0",
    voltage100= "VOLTAGE_100",
    voltage0Elm = jQuery("[name='"+voltage0+"']")[0],
    voltage100Elm = jQuery("[name='"+voltage100+"']")[0],
    val0 = roundValue05(parseFloat(jQuery(voltage0Elm).val())),
    val100 = roundValue05(parseFloat(jQuery(voltage100Elm).val()));

  if (param == voltage0) {
    jQuery(voltage0Elm).val((val0 >= val100) ? val100 - 0.5 : val0);
  }
  if (param == voltage100) {
    jQuery(voltage100Elm).val((val100 <= val0) ? val0 +0.5 : val100);
  }
};

add_HMW_onchange_ = function(ch_type)
{  
  switch (ch_type) { 
    
    case "INPUT_OUTPUT":

      var inputType = document.getElementsByName("INPUT_TYPE");
      var behaviour = document.getElementsByName("BEHAVIOUR");

      for (var loop=0;loop < inputType.length;loop++) 
      {
        var onchange = document.createAttribute("onchange");
        onchange.nodeValue= "alert('A')";
        inputType[loop].setAttributeNode(onchange);
      }
      
      for (loop=0;loop < behaviour.length;loop++) 
      {
        var onchange = document.createAttribute("onchange");
        onchange.nodeValue= "alert('B')";
        behaviour[loop].setAttributeNode(onchange);
      }
      break;
    
    case "KEY" :
      
      var inputType = document.getElementsByName("INPUT_TYPE");
      
      for (var loop=0;loop < inputType.length;loop++) 
      {
        var onchange = document.createAttribute("onchange");
        onchange.nodeValue= "alert('C')";
        inputType[loop].setAttributeNode(onchange);
      }
      break;

    default:
      break;
  }

};

HMW_setIOType = function(elem)
{
  // Zeigt die einstellbaren Parameter des Kanals entsprechend der gewählten Einstellung an.
  // Es wird zwischen Schalter und Taster unterschieden.
  
  // gewählte Einstellung
  var sel = elem.selectedIndex;
  
  // Schalter (0)  oder Taster (1)
  var type = elem.options[sel].value;
  
  var tr = elem.parentNode.parentNode.nextSibling.nextSibling;

  switch (type) {
    
    case "0":
      tr.style.visibility = "hidden";
      tr.style.display = "none";
      break;

    case "1":
      tr.style.visibility = "visible";
      tr.style.display = "";
      break;

    default:
      break;
  }
};

HMW_setBehaviour = function(id)
{
  // Zeigt die einstellbaren Parameter des Kanals entsprechend der gewählten Einstellung an.
  // Es wird zwischen Ein-  und Ausgang unterschieden.

  // wird von tcl erledigt, da bei Ein- u. Ausgang verschiedene Parameter verwendet werden,
  // muß die Änderung zuerst an den Aktor gesendet werden.
};

HMW_WebUIsetChannel = function(id, ch_type)
{
  id = id.split("=")[1];
  id = id.substring(1, id.length -1); 
  
  var elem = document.getElementById(id);
  
  switch (ch_type) {
    
    case "INPUT_OUTPUT":
      
      switch (elem.name) { 
        case "INPUT_TYPE":
          HMW_setIOType(elem);
          $(id).observe('change', function(event) {HMW_setIOType(elem);});
          break;
        case "BEHAVIOUR":
          $(id).observe('change', function(event) {HMW_setBehaviour(elem);});
          break;
        default:
          break;
      }
    
    break;

    case "KEY":
      
      switch (elem.name) {
        case "INPUT_TYPE":
          HMW_setIOType(elem);
          $(id).observe('change', function(event) {HMW_setIOType(elem);});
        break;
        default:
          break;
      }  
    
    break;
  }  
};

showHintPrgLink = function(channel, prgExists) {
  var channel = parseInt(channel),
    classMultiMode = jQuery(".j_multiMode_" + channel)[0],
    tableElm = jQuery(".ProfileTbl tbody").parent().parent()[channel],
    wgtModeSelectorElm = jQuery("#wgtModeSelector"),
    dataAttr = jQuery(classMultiMode).attr("data"),
    elm = (typeof wgtModeSelectorElm == "object") ? wgtModeSelectorElm : jQuery(".j_multiMode_" + channel).find("[name='CHANNEL_OPERATION_MODE']")[0],
    hintPrgExists = "hintPrgExists",
    hintLinkExists = "hintLinkExists";

  jQuery(elm).prop("disabled", true);
  wgtHasLinksOrPrograms = true;

  if (typeof classMultiMode == "object") {
    if (prgExists) {
      if (typeof dataAttr != "undefined" && dataAttr == "hmip-wgt") {
        hintPrgExists = "hintPrgExists_WGT";
      }
      jQuery(classMultiMode).after("<div class=\"attention\" style='padding: 2px;'>" + translateKey("hintPrgExists") + "</div>");
    } else {
      arChnHasLinks[channel] = true;
      if (typeof dataAttr != "undefined" && dataAttr == "hmip-wgt") {
        hintLinkExists = "hintLinkExists_WGT";
      }
      jQuery(classMultiMode).after("<div class=\"attention\" style='padding: 2px;'>" + translateKey(hintLinkExists) + "</div>");
    }
  } else {
    if (prgExists) {
      jQuery(tableElm).append("<div class=\"attention\" style='padding: 2px;'>" + translateKey(hintPrgExists) + "</div>");
    } else {
      arChnHasLinks[channel] = true;
      jQuery(tableElm).append("<div class=\"attention\" style='padding: 2px;'>" + translateKey(hintLinkExists) + "</div>");
    }
  }
};

showHintInternalLink = function(channel) {
  var channel = parseInt(channel),
    classMultiMode = jQuery(".j_multiMode_" + channel)[0],
    txtHint = "<div class=\"attention\" style='padding: 2px;'>" + translateKey("hintInternalLinkExists") + "</div>";

  if (typeof classMultiMode == "object") {
    jQuery(classMultiMode).after(txtHint);
  } else {
    var tableElm = jQuery(".ProfileTbl tbody").parent().parent()[channel];
    jQuery(tableElm).append(txtHint);
  }
};

ShowHintIfProgramExists = function(id, ch) {
  homematic("Channel.hasProgramIds", {id: id}, function(result, error) {
    if (result) {
      showHintPrgLink(ch, true);
    } else {
      if((arChnHasLinks[parseInt(ch)] != true) && (! wgtHasLinksOrPrograms)) {
        var elm = jQuery(".j_multiMode_" + ch).find("[name='CHANNEL_OPERATION_MODE']")[0];
        jQuery(elm).prop("disabled", false);
      }
    }
  });
};

RF_existsLink = function(deviceType, ch, ch_type, internalLinkOnly) {
  var arDevMultiModeException = [],
    dataAttr = jQuery(jQuery(".j_multiMode_" + ch)[0]).attr("data");

  if ((typeof dataAttr != "undefined") && dataAttr == "hmip-wgt") {
    deviceType = "HmIP-WGT";
  }

  switch(deviceType) {
    case "HM-MOD-EM-8":
    case "HmIP-WGT":
      if (deviceType == "HmIP-WGT") {
        if (ch_type == "SWITCH_VIRTUAL_RECEIVER") {
          showHintPrgLink(ch, false);
        }
      } else {
        showHintPrgLink(ch, false);
      }
      break;
    default:
      break;
  }

  switch(ch_type) {
    case "MULTI_MODE_INPUT_TRANSMITTER":
      arDevMultiModeException = ["HmIP-FSI16", "HmIP-FSI16-2", "HmIP-DRDI3", "HmIP-BDT-I"];
      if ((arDevMultiModeException.indexOf(deviceType) == -1) || (internalLinkOnly == 0)) {
        showHintPrgLink(ch, false);
      } else {
        showHintInternalLink(ch);
      }
      break;
    default:
      break;
  }
};

HMW_existsLink = function(channel, ch_type)
{
  //var hint = document.createTextNode("Es besteht mindestens eine Verknüpfung. Daher sind einige Funktionen gesperrt.");
  var hint = document.createTextNode(translateKey("hintLinkExists"));
  var new_tr = document.createElement("tr");
  var new_td = document.createElement("td");
  var colspan = document.createAttribute("colspan");
  var class_attention = document.createAttribute("class");
  colspan.nodeValue = "5";
  class_attention.nodeValue = "attention ch_" + channel;

  if ($$('.ch_' + channel).length == 0)
  {
    switch (ch_type) {
    
      case "INPUT_OUTPUT":
        var elem1 = $('separate_CHANNEL_' + channel + '_3'); // Eingangsbeschaltung
        var elem2 = $('separate_CHANNEL_' + channel + '_6'); // Funktion Eingang
        var elem3 = $('separate_CHANNEL_' + channel + '_4'); // Funktion Ausgang
        
        if (elem1.name == 'INPUT_TYPE') 
        {
          elem1.disabled = true;
          elem2.disabled = true;
        
          var td = elem1.parentNode.parentNode.parentNode.appendChild(new_tr).appendChild(new_td);
          td.setAttributeNode(colspan);
          td.setAttributeNode(class_attention);
          td.appendChild(hint);
        } 
        else
        {
          elem3.disabled = "true";
        
          var td = elem3.parentNode.parentNode.parentNode.appendChild(new_tr).appendChild(new_td);
          td.setAttributeNode(colspan);
          td.setAttributeNode(class_attention);
          td.appendChild(hint);
        }
      break;

      case "KEY":
        var elem1 = $('separate_CHANNEL_' + channel + '_3'); // Eingangsbeschaltung
        elem1.disabled = true;
      
        var td = elem1.parentNode.parentNode.parentNode.appendChild(new_tr).appendChild(new_td);
        td.setAttributeNode(colspan);
        td.setAttributeNode(class_attention);
        td.appendChild(hint);
        break;
    
      default: 
        break;
    }
  }
};



TextColor = function(c)
{
  if (!c) { return WebUI.getColor("windowText"); }
  else    { return WebUI.getColor("gray"); }
};

VirtualChannel_help = function(ch, lc)
{
  var virtualChHelpElm = jQuery("#virtual_ch_help_" + ch),
    virtualChHelpElm2 = jQuery("#virtual_ch_help2_" + ch),
    virtualHelpButtonElm = jQuery("#virtual_help_button_" + ch),
    virtualHelpButtonElm2 = jQuery("#virtual_help_button2_" + ch);

  if (lc != "lc2") {
    if (virtualHelpButtonElm.val() == translateKey("genericBtnTxtHelp")) {
      virtualChHelpElm2.hide();
      virtualChHelpElm.show();
      virtualHelpButtonElm.val(translateKey("genericBtnTxtHelpOff"));
      virtualHelpButtonElm2.val(translateKey("genericBtnTxtHelp"));
    } else {
      virtualChHelpElm.hide();
      virtualHelpButtonElm.val(translateKey("genericBtnTxtHelp"));
    }
  } else {
    if (virtualHelpButtonElm2.val() == translateKey("genericBtnTxtHelp")) {
      virtualChHelpElm.hide();
      virtualChHelpElm2.show();
      virtualHelpButtonElm.val(translateKey("genericBtnTxtHelp"));
      virtualHelpButtonElm2.val(translateKey("genericBtnTxtHelpOff"));
    } else {
      virtualChHelpElm2.hide();
      virtualHelpButtonElm2.val(translateKey("genericBtnTxtHelp"));
    }
  }
};


WDS_DisableOnTime = function(selectelem)
{
  // Schaltet beim WATERDETECTIONSENSOR die Einschaltdauer
  // im Profil Änderungsignal / Subset Aus bei ....
  // unsichtbar

    if (selectelem.selectedIndex >= 5)
  {
    $('on_time').style.visibility = 'hidden';
  }  
  else
  {
    $('on_time').style.visibility = 'visible';
  }
};

WEATHER_change_thres = function(id)
{
  //1 
  switch_dir = $('separate_receiver_' +  id).selectedIndex; //2 
  WEATHER_check_dir();
};

WEATHER_check_dir = function()
{
  var newSensor = "HM-WDS100-C6-O-2";
  var sensorTypeDesc = jQuery("#weatherSensor").val();
  var selectedWindDirection = jQuery("[name=\"subset_1_1\"]").prop("selectedIndex");

  var ein;
  var aus;
  //1 

  if (sensorTypeDesc != newSensor) {
    if (switch_dir) {
      //ein = document.createTextNode("Einschaltschwelle");
      ein = document.createTextNode(translateKey("upperStormThreshold"));
      //aus = document.createTextNode("Ausschaltschwelle");
      aus = document.createTextNode(translateKey("lowerStormThreshold"));
    }
    else {
      //ein = document.createTextNode("Ausschaltschwelle");
      ein = document.createTextNode(translateKey("lowerStormThreshold"));
      //aus = document.createTextNode("Einschaltschwelle");
      aus = document.createTextNode(translateKey("upperStormThreshold"));
    }
  } else {
    // new Sensor
    var ctON = jQuery("[name=\"SHORT_CT_ON\"]").prop("selectedIndex");
    var ctOFF = jQuery("[name=\"SHORT_CT_OFF\"]").prop("selectedIndex");

    if (switch_dir == 1) {
      //ein = document.createTextNode("Einschaltschwelle");
      ein = document.createTextNode(translateKey("upperStormThreshold"));
      //aus = document.createTextNode("Ausschaltschwelle");
      aus = document.createTextNode(translateKey("lowerStormThreshold"));
      $('ein').replaceChild(ein, $('ein').firstChild);
      $('aus').replaceChild(aus, $('aus').firstChild);
      return;
    }
    else if (switch_dir == 0) {
      //ein = document.createTextNode("Ausschaltschwelle");
      ein = document.createTextNode(translateKey("lowerStormThreshold"));
      //aus = document.createTextNode("Einschaltschwelle");
      aus = document.createTextNode(translateKey("upperStormThreshold"));
      $('ein').replaceChild(ein, $('ein').firstChild);
      $('aus').replaceChild(aus, $('aus').firstChild);
      return;
    }

    // X GE LO = 0
    // X GE HI = 1
    // X LT LO = 2
    // X LT HI = 3
    // Starker Wind EIN, schwacher Wind AUS / oder EIN nur bei starkem Wind, nicht aus (2. Profil)
    if ((ctON == 2 && ctOFF == 1) || (ctON == 1 && ctOFF == 1)) {
      //ein = document.createTextNode("Einschaltschwelle");
      ein = document.createTextNode(translateKey("upperStormThreshold"));
      //aus = document.createTextNode("Ausschaltschwelle");
      aus = document.createTextNode(translateKey("lowerStormThreshold"));
    }
    // Starker Wind AUS, schwacher Wind EIN
    if (ctON == 1 && ctOFF == 2) {
      //ein = document.createTextNode("Ausschaltschwelle");
      ein = document.createTextNode(translateKey("lowerStormThreshold"));
      //aus = document.createTextNode("Einschaltschwelle");
      aus = document.createTextNode(translateKey("upperStormThreshold"));
    }



  }
  try {
    $('ein').replaceChild(ein, $('ein').firstChild);
    $('aus').replaceChild(aus, $('aus').firstChild);
  } catch (e) {}
};

WEATHER_check_expert = function()
{  
  //1
    
  try //2 
  {
    high = $F('separate_sender_0_3');
    if (high) { throw "true"; }
    else      { throw "false"; }
  }
  catch (ergebniss)
  {
    if (ergebniss == "true")
    {
      high = $F('separate_sender_0_3');  
      low  = $F('separate_sender_0_4');
      if (parseInt(low) > parseInt(high))  return true; //3 
      else return false;  
    } else return "noExpert";
  }
};

WEATHER_check_profile_switch = function(selectelem)
{
  var actor = $F('dev_descr_receiver_tmp');
  
  if (actor != "SWITCH") {switch_on_off = false; return 0;}

  if ((((selectelem.options[selectelem.selectedIndex].value) == "1") && ($('sender_profiles').options[$('sender_profiles').selectedIndex].value == "1")) ||
      (((selectelem.options[selectelem.selectedIndex].value) == "1") && ($('receiver_profiles').options[$('receiver_profiles').selectedIndex].value == "1")) ||
      (((selectelem.options[selectelem.selectedIndex].value) == "0") && ($('sender_profiles').options[$('sender_profiles').selectedIndex].value == "1") && ($('receiver_profiles').options[1].value == "1")) ||
      (((selectelem.options[selectelem.selectedIndex].value) == "1") && ($('receiver_profiles').options[$('receiver_profiles').selectedIndex].value == "0") && ($('receiver_profiles').options[1].value == "1")))
  {
    switch_on_off = true; //1 
    return 1;
  }
  else 
  {
    switch_on_off = false; //2
    return 0;
  }
};

WEATHER_check_weather = function()
{
  //1 
  var link = "", linkPeer = "";
  try {
    link = $('dev_descr_sender_tmp').value.split("-");
    linkPeer = $('dev_descr_receiver_tmp').value.split("-");
    if (link) { throw true; }
  } catch (e) {
    if ( e == true) {
      if (((link[0] == "WEATHER") || (link[0] == "WEATHER_2")) && (linkPeer[0] != "WEATHER_RECEIVER")) return true;
      else return false;
    } else return false;
  }
};

WEATHER_put_desc = function(id,x)
{
    //1 
    
    if ((WEATHER_check_expert()) && (x == 0))   //2 
    {
//    $('sender_profiles').options[0].selected = true;
//    $('separate_sender_1_1').options[4].selected = true;
//    $('separate_sender_1_2').options[2].selected = true;
    } 
    else if (WEATHER_check_expert() != "noExpert" && x == 1) //3 
    {
      $('separate_sender_0_3_temp').value = $('separate_sender_1_1').options[$('separate_sender_1_1').selectedIndex].value; 
      $('separate_sender_0_4_temp').value = $('separate_sender_1_2').options[$('separate_sender_1_2').selectedIndex].value; 
  }
    
    var upper_index = $('separate_sender_1_1').selectedIndex; //4 
    var lower_index = $('separate_sender_1_2').selectedIndex; //5 
    
    var desc = [];
    var upper_desc = document.getElementById('upper_desc');
    var lower_desc = document.getElementById('lower_desc');
    var elem = id.split("_");
    
    //6 
    $('separate_sender_1_1').options[0].disabled = true;
    $('separate_sender_1_1').options[0].style.color = WebUI.getColor("grayText");
    if ($('separate_sender_1_1').selectedIndex == 0) { $('separate_sender_1_1').options[1].selected = true; }
    
    for (var loop = 1; loop <= 12; loop++)
    {
      $('separate_sender_1_1').options[loop].style.color = WebUI.getColor("windowText"); //7 
      $('separate_sender_1_1').options[loop].disabled = false;
    }
  
    if ($('lower_tab').style.display == "block")
    {
      for (loop = 1; loop <= lower_index; loop++)
      {
        $('separate_sender_1_1').options[loop].style.color = WebUI.getColor("grayText"); //8 
        $('separate_sender_1_1').options[loop].disabled = true;
      }
    }
  
    if ((lower_index >= upper_index) && ($('lower_tab').style.display == "block") && (switch_on_off == true))
    {  
      if (lower_index <= 11)   
      {
        $('separate_sender_1_1').selectedIndex = lower_index + 1;
        if (WEATHER_check_expert() != "noExpert")
        $('separate_sender_0_3_temp').value = $('separate_sender_1_1').options[$('separate_sender_1_1').selectedIndex].value; 
      }
      else $('separate_sender_1_1').selectedIndex = 12;
    }
 
    for (loop = 0; loop <= 12; loop++) {
      desc[loop] = document.createTextNode(unescape(translateKey("windDesc"+loop)));
    }
  
    switch (elem[3]) {
      case ("1"):
        upper_desc.replaceChild(desc[$(id).selectedIndex], upper_desc.firstChild);
        break;  
      case ("2"):
        lower_desc.replaceChild(desc[$(id).selectedIndex], lower_desc.firstChild);
        break;
      default:
        break;
    }

    window.setTimeout("WEATHER_translate();",500)  ;
};

WEATHER_translate= function() {
  jQuery('#upper_desc').text(translateKey(jQuery('#upper_desc').text()));
  jQuery('#lower_desc').text(translateKey(jQuery('#lower_desc').text()));
  jQuery('#ein').text(translateKey(jQuery('#ein').text()));
  jQuery('#aus').text(translateKey(jQuery('#aus').text()));
};

WEATHER = function(selectelem)
{
  var loop;
  
  if (WEATHER_check_weather()) //1 
  {
    if ((((selectelem.options[selectelem.selectedIndex].value) == "2") && ($('sender_profiles').options[$('sender_profiles').selectedIndex].value == "1")) ||
        (((selectelem.options[selectelem.selectedIndex].value) == "1") && ($('receiver_profiles').options[$('receiver_profiles').selectedIndex].value == "2")))
    
    {  
    //2
      switch_on_off = false;  

      if ($('lower_tab')) {
        $('lower_tab').style.display = "none";
      }
      $('separate_sender_1_2').options[0].selected = true; // Ausschaltschwelle auf 0 setzten
      
      //var ein = document.createTextNode("Einschaltschwelle");
      var ein = document.createTextNode(translateKey("upperStormThreshold"));
      $('ein').replaceChild(ein, $('ein').firstChild);  //3
      
      $('separate_sender_1_1').options[0].disabled = true; //4
      $('separate_sender_1_1').options[0].style.color = WebUI.getColor("grayText"); //5 
      
      for (loop = 1; loop <= 12; loop++)
      {
        $('separate_sender_1_1').options[loop].style.color = WebUI.getColor("windowText"); //6
        $('separate_sender_1_1').options[loop].disabled = false; //7
      }
  } 
    else 
    {
      try 
      {
       
        if (WEATHER_check_profile_switch(selectelem) == 1)  //8    
        {
          throw "block"; 
        } else throw "none";
      }   
      catch (ergebniss) 
      {
        if (ergebniss == "none") //9
        {  
          switch_on_off = false;  
          $('lower_tab').style.display = "none";  
          $('separate_sender_1_2').options[0].selected = true; // Ausschaltschwelle auf 0 setzten
          
          $('separate_sender_1_1').options[0].disabled = true; //10
          $('separate_sender_1_1').options[0].style.color = WebUI.getColor("grayText") ; //11

          for (loop = 1; loop <= 12; loop++)
          {
            $('separate_sender_1_1').options[loop].disabled = false;
            $('separate_sender_1_1').options[loop].style.color = WebUI.getColor("windowText"); //12
          }
          WEATHER_check_dir(); //13
        } 
        else if (ergebniss == "block") //14
        {
        
          $('lower_tab').style.display = "block"; //15  
        
          var selected_high = $('separate_sender_1_1').selectedIndex;
          var selected_low = $('separate_sender_1_2').selectedIndex;
          
          if (selected_low >= selected_high)  //16
          {
            $('separate_sender_1_2').options[0].selected = true;
            
            $('separate_sender_1_1').options[0].style.color = WebUI.getColor("grayText") ; //17
            $('separate_sender_1_1').options[0].disabled = true;
            
            //var desc = document.createTextNode(unescape("Keine Luftbewegung, Rauch steigt senkrecht empor."));
            //var desc = document.createTextNode(unescape(translateKey("hintNoAirFlow")));
            var desc = document.createTextNode(unescape(translateKey("windDesc0")));
            lower_desc.replaceChild(desc, lower_desc.firstChild);
          } 
          else //18
          {
            for (loop = 0; loop <= $('separate_sender_1_2').selectedIndex; loop++)
            {
              $('separate_sender_1_1').options[loop].disabled = true;
              $('separate_sender_1_1').options[loop].style.color = WebUI.getColor("grayText"); //19
            }
          }
          
          prn = selectelem.options[selectelem.selectedIndex].value; //20 
            
          switch_dir = $('separate_receiver_' + prn + '_1').selectedIndex; //21 
          WEATHER_check_dir(); //22 
        }
      }
    }
  }
};

isJSFunc_active = function(fbib) {
  //prueft, ob die Funktionsbibl. schon geladen ist
  if (exists_bib[fbib] == true) return true; //schon aktiv
  else return false;  // nicht aktiv
};

load_JSFunc = function(fbib) {
  //fbib gibt die gewuenschte Funktionsbibliothek incl. Pfad an

  if (isJSFunc_active(fbib) == false) // falls die Bibliothek noch nicht geladen wurde 
  {
//    alert('Bib wird geladen'); 
      new Ajax.Request(fbib, 
        {
        method:   'get', 
        
        asynchronous: false,

        onSuccess:  function(success) {
                eval(success.responseText);
                exists_bib[fbib] = true; //Bibliothek geladen
              },
        
        onFailure:  function(failure) {
                alert(fbib + ': ' + failure.statusText);
              }
        }
      );
  }
};

showParamHelp = function(topic, x , y) {
 var width = (! isNaN(x)) ? x : 450;
 var height = (! isNaN(y)) ? y : 260;
 MessageBox.show(translateKey("HelpTitle"), translateKey(topic), "", width, height);
};

selectWGDIcon = function(chn, elmId, activeIcon) {
  var dlg = new WGDSelectIconDialog(translateKey("lblBaseImage"), "<div id='anchor_" + chn + "'></div>", function(btnPress) {
    if (btnPress == this.RESULT_YES) {
      jQuery("#" + elmId).val(this.getSelectedIconNo());
      jQuery("#image_" + chn ).attr("src", this.getSelectedIcon());
    }
  }, "html");
  dlg.btnTextNo(translateKey("btnCancel"));
  dlg.btnTextYes(translateKey("btnOk"));
  dlg.chn = chn;
  dlg.activeIcon = parseInt(activeIcon);
};


// Test
rfd_test = function() {
  homematic('Interface.isPresent', {"interface": "BidCos-RF"}, function(result, error) {
  if (result === true)
  {
    alert("rfd läuft");
  }
  else
  {
    alert(Object.toJSON(error) + "  Achtung: rfd läuft nicht!");
  }
  });
};
  
preventOnOffNonActive= function(elm) {
  var receiverType = jQuery("#receiver_paramid").val();

  if (receiverType  && (receiverType != "linkHmIP_HEATING_KEY_RECEIVER")) {
    var arFooterElems = jQuery(".FooterButton"),
      arOnOffElems = jQuery("[name='" + elm.name + "']"),
      onOffNotActive = 0,
      chn = elm.name.split("_")[1],
      counter;

    if (arOnOffElems.length == 2) {
      counter = 1;
      jQuery.each(arOnOffElems, function (index, elem) {
        if (jQuery(elem).val() == 0) {
          onOffNotActive++;
        }
      });
    } else if (arOnOffElems.length == 4) {
      counter = 0;
      if (
        ((jQuery(arOnOffElems[0]).val() == 0) && (jQuery(arOnOffElems[1]).val() == 0)) ||
        ((jQuery(arOnOffElems[2]).val() == 0) && (jQuery(arOnOffElems[3]).val() == 0))
      ) {
        onOffNotActive++;
      }
    }

    if (onOffNotActive > counter) {
      arFooterElems[1].hide();
      arFooterElems[2].hide();
      jQuery(".j_hint").remove();
      jQuery("#receiver_param_" + chn).append("<p class='j_hint attention'><b>" + translateKey('hintLinkParamOnOffNotActive') + "</b></p>");

    } else {
      jQuery(".j_hint").remove();
      arFooterElems[1].show();
      arFooterElems[2].show();
    }
  }
};

addAbortEventSendingChannels = function(chn, prn, devAddress, value) {
  var hookElm_1 = jQuery("#hookAbortEventSendingChannels_1_"+ chn),
    hookElm_2 = jQuery("#hookAbortEventSendingChannels_2_"+ chn),
    device = DeviceList.getDeviceByAddress(devAddress),
    counter = 0,
    html, html_1, html_2;

  setAbortEventSendingChannels = function(chn, prn) {
    var valElm = jQuery("#separate_CHANNEL_" + chn+ "_" + prn),
      arChkBoxes = jQuery("[name='abortEventSendingCh_"+chn+"']"),
      val = 0;

    jQuery.each(arChkBoxes, function(index, chkBox) {
      if(chkBox.checked) {
        val += parseInt(chkBox.value);
      }
    });

    valElm.val(val);
  };
  if (typeof device != "undefined") {
    jQuery.each(device.channels, function (index, channel) {

      if (
        channel.channelType == "KEY_TRANSCEIVER"
        || channel.channelType == "MULTI_MODE_INPUT_TRANSMITTER"
        || channel.channelType == "ACCESS_TRANSCEIVER"
       ) {

        html = (counter == 0 || counter == 16) ? "" : html;

        html += "<td style='text-align:center;'>";
        html += "<label for='abortEventSendingCh_" + chn + "_" + counter + "' style='background-color:white; display:block; text-align:center;'>" + channel.index + "</label>";
        if (isBitSet(value, counter)) {
          html += "<input id='abortEventSendingCh_" + chn + "_" + counter + "' name='abortEventSendingCh_" + chn + "' type='checkbox' value='" + Math.pow(2, counter) + "' checked onclick='setAbortEventSendingChannels(" + chn + "," + prn + ");'>";
        } else {
          html += "<input id='abortEventSendingCh_" + chn + "_" + counter + "' name='abortEventSendingCh_" + chn + "' type='checkbox' value='" + Math.pow(2, counter) + "' onclick='setAbortEventSendingChannels(" + chn + "," + prn + ");'>";
        }
        html += "</td>";

        if (counter <= 15) {
          html_1 = html;
        } else if (counter <= 31) {
          html_2 = html;
        }
        counter++;
      }
    });
  } else {
    // SPHM-884
    var mainElm = jQuery("[name='abortEventSendingChannels']");
    mainElm.children(":first-child").text(translateKey("hintSetReadyNotComplete"));
    mainElm.next().hide();
  }
  html_1 += "<td><input type='text' class='hidden' id='separate_CHANNEL_"+chn+"_"+prn+"' size='6' name='ABORT_EVENT_SENDING_CHANNELS' value='"+value+"'></td>";
  hookElm_1.html(html_1);

  if (html_2) {
    hookElm_2.html(html_2);
  }
};

addAbortEventSendingChannels4WGD = function(chn, prn, devAddress, value) {
  var hookElm_1 = jQuery("#hookAbortEventSendingChannels_1_"+ chn),
    hookElm_2 = jQuery("#hookAbortEventSendingChannels_2_"+ chn),
    device = DeviceList.getDeviceByAddress(devAddress),
    chnIsOdd = (parseInt(chn) % 2 != 0) ? true : false,
    counter = (chnIsOdd) ? 0 : 1, // determine the odd and even channels
    html;



  setAbortEventSendingChannels = function(chn, prn) {
    var valElm = jQuery("#separate_CHANNEL_" + chn+ "_" + prn),
      arChkBoxes = jQuery("[name='abortEventSendingCh_"+chn+"']"),
      val = 0;

    jQuery.each(arChkBoxes, function(index, chkBox) {
      if(chkBox.checked) {
        val += parseInt(chkBox.value);
      }
    });

    valElm.val(val);
  };
  if (typeof device != "undefined") {
    jQuery.each(device.channels, function (index, channel) {

      if (((channel.channelType == "DISPLAY_INPUT_TRANSMITTER") && (chnIsOdd)) || ((channel.channelType == "DISPLAY_LEVEL_INPUT_TRANSMITTER") && (! chnIsOdd))) {
        html += "<td style='text-align:center;'>";
        html += "<label for='abortEventSendingCh_" + chn + "_" + counter + "' style='background-color:white; display:block; text-align:center;'>" + channel.index + "</label>";
        if (isBitSet(value, counter)) {
          html += "<input id='abortEventSendingCh_" + chn + "_" + counter + "' name='abortEventSendingCh_" + chn + "' type='checkbox' value='" + Math.pow(2, counter) + "' checked onclick='setAbortEventSendingChannels(" + chn + "," + prn + ");'>";
        } else {
          html += "<input id='abortEventSendingCh_" + chn + "_" + counter + "' name='abortEventSendingCh_" + chn + "' type='checkbox' value='" + Math.pow(2, counter) + "' onclick='setAbortEventSendingChannels(" + chn + "," + prn + ");'>";
        }
        html += "</td>";
        counter+=2;
      }
    });
  } else {
    // SPHM-884
    var mainElm = jQuery("[name='abortEventSendingChannels']");
    mainElm.children(":first-child").text(translateKey("hintSetReadyNotComplete"));
    mainElm.next().hide();
  }
  html += "<td><input type='text' class='hidden' id='separate_CHANNEL_"+chn+"_"+prn+"' size='6' name='ABORT_EVENT_SENDING_CHANNELS' value='"+value+"'></td>";
  hookElm_1.html(html);
};

addHintHeatingGroupDevice = function (address) {
  if (typeof DeviceList.getDeviceByAddress() != "undefined") {
    var devId = DeviceList.getDeviceByAddress(address.split(":")[0]).id,
      inHeatingGroup = homematic("Interface.getMetadata", {"objectId": devId, "dataId": "inHeatingGroup"}),
      hint = "<div class='attention' style='width:100%; height:50px; line-height: 25px; background-color: white; text-align: center; position:fixed; z-index: 188;'>" + translateKey('hintGroupDevice') + "</div>";

    if (inHeatingGroup != "null") {   // MetaData available?
      conInfo("MetaData available", "inHeatingGroup: " + inHeatingGroup);
      if (inHeatingGroup == "true") {
        jQuery("#content").prepend(hint);
        jQuery("#ic_deviceparameters").animate({"margin-top": "50px"});
      }
    } else { // Read /etc/congig/groups.gson (fallback if no meta data available (migration))
      conInfo("MetaData not available");
      var allowedGroupMembers = [
          "RADIATOR_THERMOSTAT",
          "WALLMOUNTED_THERMOSTAT",
          "HM-CC-RT-DN",
          "HM-TC-IT-WM-W-EU"
        ],
        showHint = false,
        devId = DeviceList.getDeviceByAddress(address.split(":")[0]).id,
        groupList = JSON.parse(homematic("CCU.getHeatingGroupList", {}));

      if (groupList != -1 && typeof groupList == "object") {
        jQuery.each(groupList, function (index, groups) {
          jQuery.each(groups, function (index, group) {
            jQuery.each(group.groupMembers, function (index, groupMember) {
              if ((groupMember.id == address) && (jQuery.inArray(groupMember.memberType.id, allowedGroupMembers) != -1)) {
                showHint = true;
                homematic("Interface.setMetadata", {"objectId": devId, "dataId": "inHeatingGroup", "value": "true"});
              }
            });
          });
        });
      }
      if (showHint) {
        jQuery("#content").prepend(hint);
        jQuery("#ic_deviceparameters").animate({"margin-top": "50px"});
      }
    }
  }
};


daliRefreshDevices = function(address) {
  var device = DeviceList.getDeviceByAddress(address);

  MessageBox.show(translateKey('titleSearchDaliDevices'),'' +' <br/><br/><img id="msgBoxBarGraph" src="/ise/img/anim_bargraph.gif"><br/>','','320','60','msgBckID', 'msgBoxBarGraph');

  homematic("Interface.searchDaliDevices", {"interface": "HmIP-RF", "address": address, "valueKey": "DALI_ADDRESS", "type": "string", "value": "refreshDaliDevices"}, function (result) {
    if (result) {
      MessageBox.setText(translateKey("lblPleaseWaitAMoment"));
      MessageBox.centerText();

      // Store the UNIVERSAL_LIGHT_MAX_CAPABILITIES of the DALI channels as meta data
      window.setTimeout(function() {
        var devAddress = address,
          daliChannel;

        for (var loop = 1; loop <= 48; loop++) {
          var maxCap = homematic("Interface.getMasterValue", {
            "interface": "HmIP-RF",
            "address": devAddress + ":" + loop,
            "valueKey": "UNIVERSAL_LIGHT_MAX_CAPABILITIES"
          });
          daliChannel = DeviceList.getChannelByAddress(devAddress + ":" + loop);
          daliChannel.daliMaxCapabilities = maxCap;
          homematic("Interface.setMetadata", {"objectId": daliChannel.id , "dataId" : "maxCap", "value": maxCap});
        }
        MessageBox.close();
        reloadPage();
      },500);

    } else {
      MessageBox.close();
      alert(translateKey("dialogSettingsSecuritySSHMsgBoxErrorTitle")); // An error occurred
    }
  });
};

// Resets the history data of a specific channel
resetChnMetaEnergyCounter = function(chn, opMode) {
      /*
        initialVal
        Values for the last 30 days. The first 0 is yesterday......
        This is being used to store the values of the last 30 days.
      */
      var arDataID = ["","","startValA","startValB","startValC"];

      var initialVal = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
      homematic("Interface.setMetadata", {
        "objectId": chn.id,
        "dataId": "energyCounter30Days",
        "value": initialVal
      });
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy0", "value": 0}); // Today
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy1", "value": 0}); // Yesterday
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy7", "value": 0}); // 1 Week
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy30", "value": 0}); // 1 Month
};

// Resets the history data and the start value of all relevant channels
resetAllMetaEnergyCounter = function(dev, opMode) {
  var arStartDataID = ["","","startValA","startValB","startValC"],
    arTimeDataID = ["","","startTimeA","startTimeB","startTimeC"];

  jQuery.each(dev.channels,function(index,chn) {
    if (chn.index > 1) {
      /*
        initialVal
        Values for the last 30 days. The first 0 is yesterday......
        This is being used to store the values of the last 30 days.
      */
      var initialVal = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
      homematic("Interface.setMetadata", {
        "objectId": chn.id,
        "dataId": "energyCounter30Days",
        "value": initialVal
      });
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy0", "value": 0}); // Today
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy1", "value": 0}); // Yesterday
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy7", "value": 0}); // 1 Week
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "energy30", "value": 0}); // 1 Month
      homematic("Interface.setMetadata", {"objectId": chn.id, "dataId": "iecPrgFirstStart","value": 1});

      if (opMode < 3) {
        homematic('Interface.setMetadata', {'objectId': chn.id, 'dataId': arStartDataID[chn.index], 'value': 0}); // Reset start value
        homematic('SysVar.setFloat', {'name': 'svEnergyCounter_' + chn.id + '_' + chn.address, 'value': 0});
        homematic('SysVar.setFloat', {'name': 'svEnergyCounterOldVal_' + chn.id, 'value': 0});
        homematic('Interface.setMetadata', {'objectId': chn.id, 'dataId': arTimeDataID[chn.index], 'value': getEsiStartTime()}); // Reset time stamp

      } else {
        var devCounter = homematic("Interface.getValue", {'interface': 'HmIP-RF', 'address' : chn.address, 'valueKey': 'ENERGY_COUNTER'});

        //if (devCounter == "") {devCounter = "0.000";}

        homematic('Interface.setMetadata', {'objectId': chn.id, 'dataId': arStartDataID[chn.index], 'value': devCounter}); // Reset start value
        homematic('SysVar.setFloat', {'name': 'svEnergyCounter_' + chn.id + '_' + chn.address, 'value': devCounter});
        homematic('SysVar.setFloat', {'name': 'svEnergyCounterOldVal_' + chn.id, 'value': devCounter});
        homematic('Interface.setMetadata', {'objectId': chn.id, 'dataId': arTimeDataID[chn.index], 'value': getEsiStartTime()}); // Reset time stamp
        homematic('Interface.setMetadata', {'objectId': chn.id, 'dataId': 'firstStart', 'value' : 1});
      }
    }
  });
};

powerIdentSensor = function(address) {
  var device = DeviceList.getDeviceByAddress(address.split(":")[0]);

  var dlgYesNo = new YesNoDialog(translateKey("btnSensorDetection"), translateKey("dialogEsiSearchButtonContent"), function(result) {
    if (result == YesNoDialog.RESULT_YES) {
      var opMode = -1, counter = 0, cntNoSensorFound = 0,
      intervalId = setInterval(getOperationMode, 1000);

      homematic("Interface.putParamset", {
        'interface': "HmIP-RF",
        'address': address,
        'paramsetKey': 'MASTER',
        'set':
          [
            {name: 'CHANNEL_OPERATION_MODE', type: 'int', value: 0}
          ]
      });

      DeviceListPage.showConfiguration(false, 'DEVICE', device.id);

      function getOperationMode() {
        var chnPS = homematic("Interface.getParamset", {
          "interface": "HmIP-RF",
          "address": address,
          "paramsetKey": "MASTER"
        });
        opMode = chnPS.CHANNEL_OPERATION_MODE;
        if (typeof opMode != "undefined") {
          if ((opMode != -1) && (opMode != 0)) {
            clearInterval(intervalId);
            DeviceListPage.showConfiguration(false, 'DEVICE', device.id);
            resetAllMetaEnergyCounter(device, opMode);
          } else {
            conInfo("ESI - searching sensor: " + counter);
            counter++;
            if (counter > 120) {
              // If on the config page of this device, after 2 minutes stop the search and show a message that the system button of the device has to be pressed.
              // After the message has been confirmed start the search again.
              // Do this 3 times (6 minutes). After that, stop the search. There is probably no sensor connected.
              if ((jQuery("#btnSensorIdent").length == 1) && (cntNoSensorFound < 3)) {
                alert("Please press the system button of the device\n\n" + device.name + "."); // ToDo - translate
                counter = 0;
                cntNoSensorFound++;
              } else {
                // If not on the config page, stop the search.
                clearInterval(intervalId);
                if (cntNoSensorFound > 2) {
                  alert("No sensor found."); // ToDo translate
                }
              }
            }
          }
        } else {
          clearInterval(intervalId);
          console.log("Problem: CHANNEL_OPERATION_MODE not found!");
        }
      }
    }
  },"html");
  dlgYesNo.btnTextNo(translateKey("dialogBack"));
  dlgYesNo.btnTextYes(translateKey("btnNext"));
  dlgYesNo.setContentClass("YesNoDialogContentNoBold");
  dlgYesNo.resetHeight();
};

getEsiStartTime = function() {
  var d = new Date(),
  dateString = ("0" + d.getDate()).slice(-2) + "." + ("0"+(d.getMonth()+1)).slice(-2) + "." +
    d.getFullYear() + " " + ("0" + d.getHours()).slice(-2) + ":" + ("0" + d.getMinutes()).slice(-2);

  return dateString;
};