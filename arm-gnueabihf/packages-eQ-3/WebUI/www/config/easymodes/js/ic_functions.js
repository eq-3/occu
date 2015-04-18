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
arModEM8 = [];

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
      time_tmp = x_max; 		//9
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
	  } else	document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);

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
      if (time2d[pnr][loopy] == 1) 	{time_textcolor = 1; break;}
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
			} else	document.getElementById(special_input_id + "_profiles").options[selectelem.selectedIndex].style.color = TextColor(_textcolor);
			
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
			if (perc2d[pnr][loopy] == 1) 	{perc_textcolor = 1; break;}
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

Disable_SimKey = function(ch, prn, specialInputId) 
{
	var arrSpecialInputId = specialInputId.split("_"),
	pref_dirty = false,
	i = 1,
	jBtnSim = $("SimKey_" + arrSpecialInputId[1] + "_" +  arrSpecialInputId[2] + "_" + prn),
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
			//jBtnSim.value = "Simulation nicht möglich!";
			jBtnSim.value = translateKey("simulateKeyPressBtnTxtNotPossible");
			jHintSim.style.display = "inline";
		} 
		else
		{
			jBtnSim.disabled = false;
			//jBtnSim.value = "Simuliere Tastendruck";
			jBtnSim.value = translateKey("simulateKeyPressBtnTxt");
			jHintSim.style.display = "none";
		}
  }
};


MD_catchBrightness = function(url, sender_address, receiver_address, set_value, id, commando, parameter)
{
	ResetPostString();
	poststr += "&url=" +url;
	poststr += "&sender_address="   +sender_address;
	poststr += "&receiver_address=" +receiver_address;
	poststr += "&set_value=" +set_value;
	poststr += "&id=" +id;
	poststr += "&commando=" +commando;
	poststr += "&parameter=" +parameter;
	poststr += "&active_bright=" + $F(id);
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
	var	prn = id_on_time.split("_")[2];
	var	pref = id_on_time.split("_")[3];
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
			
			case("0"): 	$('hint_'+ prn + '_' + pref).style.color = WebUI.getColor('red');
						$('hint_'+ prn + '_' + pref).firstChild.data = unescape(localized[0]['hint_ontime_0']);
						break;

			case("1"):	$('hint_'+ prn + '_' + pref).style.color = WebUI.getColor('red');
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
	
	
	var min_value = new Array(15, 30, 60, 120, 240);
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
		$(id_on_time + '_hint0').firstChild.data = unescape(localized[0]['hint0a']) +  min_value[min_interval] + unescape(localized[0]['hint0b']);
		$(id_on_time + '_hint1').firstChild.data = unescape(localized[0]['hint1a']) +  min_value[min_interval] + unescape(localized[0]['hint1b']);
	} else {
		$(id_on_time + '_hint0').firstChild.data = " "; 
		$(id_on_time + '_hint1').firstChild.data = " "; 
	}
};

MD_init = function(id, min, max)
{
	var input = document.getElementById(id);
	var ausdr_int	= /\d+/;
	if (ausdr_int.test(input.value)) {var wert_int = ausdr_int.exec(input.value); wert_int = wert_int[0];}
	var wert 		= min;
  var channel = id.split("_")[2];

	if (! wert_int) {wert = min;} //1 
	if (! isNaN(wert_int)) {wert = wert_int;}

	if (wert < min) {wert = min;}
	if (wert > max) {wert = max;}
		
	input.value = wert;

	if (input.name == "EVENT_FILTER_NUMBER")
	{
		var efn = document.getElementsByClassName('event_filter_number');
		if (wert == 1) 
		{
			//input.options[0].text = "jedem";
			input.options[0].text = translateKey("motionDetectorEventFilterNumberA");
			//efn[0].firstChild.data = " Sensor-Impuls";
			efn[0].firstChild.data = translateKey("motionDetectorEventFilterNumberB");
			efn[1].firstChild.data = " ";

      $('separate_CHANNEL_' + channel + '_2').style.display = "none";
		} else
		{
			input.options[0].text = "1";
			//efn[0].firstChild.data = " Sensor-Impulsen innerhalb ";
			efn[0].firstChild.data = translateKey("motionDetectorEventFilterNumberC");
			//efn[1].firstChild.data = " Sekunden";
			efn[1].firstChild.data = translateKey("motionDetectorEventFilterNumberD");
      $('separate_CHANNEL_' + channel + '_2').style.display = "inline";
		}
	}

	if (input.name == "BRIGHTNESS_FILTER")
	{
		var brightness = document.getElementsByClassName('brightness')[0];
		//if (wert == 0) 	brightness.firstChild.data = "der zuletzt ermittelte Wert";
		if (wert == 0) 	brightness.firstChild.data = translateKey("motionDetectorMinumumOfLastValuesB0");
		//else brightness.firstChild.data = "das Minimum der letzten " + (parseInt(input.value) + 1) + " Werte";
		else brightness.firstChild.data = translateKey("motionDetectorMinumumOfLastValuesB1") + (parseInt(input.value) + 1) + translateKey("motionDetectorMinumumOfLastValuesC");
	}
};

MD_getHelp = function(min, max, brightness, ready)
{
	// liest die Hilfedatei für den MotionSensor ein
//	var language = $F('language') ;
  var language = getLang();
	var font_bold = "\"font-style:normal; font-weight:bold\"";
	var font_underline = "\"font-style:normal; text-decoration:underline\"";
	var active = localized[0]['active_' + ready];
	
	//Je nachdem, ob die aktuelle Helligkeit zur Verfügung steht, oder nicht, werden verschiedene Hilfstexte generiert.
	if (brightness != -1) {	var path = '/config/easymodes/etc/localization/' + language + '/MOTION_DETECTOR_1.txt';}
	else {var path = '/config/easymodes/etc/localization/' + language + '/MOTION_DETECTOR_0.txt';}
	
	// die entsprechende Uebersetzungstabellen der Easymodes einlesen
	new Ajax.Request(path ,
		{
		method:		'get',
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

MD_catchBright_help = function(min, max, brightness, ready)
{
	//Hilfetext für die Helligkeitsschwelle des Motion-Detectors		
	var help_txt = MD_getHelp(min, max, brightness, ready);

	MessageBox.show(help_txt[0]['title_brightness'], help_txt[0]['help_brightness'] ,"" ,475 ,185);

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
	//	Mehr als 5 Eintraege vorhanden?
	//	min_interval.options[0].selected = true;
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
	
	switch ($F(id_s)) {

	case "15":
		var h = '00'; var m = '00'; var s = '15';
		break;
	case "30":
		var h = '00'; var m = '00'; var s = '30';
		break;
	case "60":
		var h = '00'; var m = '01'; var s = '00';
		break;
	case "120":
		var h = '00'; var m = '02'; var s = '00';
		break;
	case "240":
		var h = '00'; var m = '05'; var s = '00'; //klassich minimum 5 Minuten (4 Min + Toleranz)
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


ProofFreeTime = function(id, min, max)
{
	var input = $(id);
  input.value = input.value.replace(/,/g,".");
	//1 
	var ausdr_float = /\d+.\d+/;
	var ausdr_int	= /\d+/;
	if (ausdr_float.test(input.value)) {var wert_float = ausdr_float.exec(input.value); wert_float = wert_float[0];}
	if (ausdr_int.test(input.value)) {var wert_int = ausdr_int.exec(input.value); wert_int = wert_int[0];}
//	if (min == 0) {min = '00'};
	var wert 		= '00';

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
		}	else {input.value = wert;} 

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
				var min_value = new Array(15, 30, 60, 120, 240);
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


setHM_MOD_EM_X = function(channel, prgExists) {
  var channel = parseInt(channel);
  var tableElm = jQuery(".ProfileTbl tbody").parent().parent()[channel -1];
  var elm = jQuery("[name='CHANNEL_FUNCTION']")[channel -1];
  jQuery(elm).prop("disabled", true);
  if (prgExists) {
    jQuery(tableElm).append("<div class=\"attention\" style='padding: 2px;'>"+translateKey("hintPrgExists")+"</div>");
  } else {
    arModEM8[channel] = true;
    jQuery(tableElm).append("<div class=\"attention\" style='padding: 2px;'>"+translateKey("hintLinkExists")+"</div>");
  }
};

ShowHintIfProgramExists = function(id, ch) {
    homematic("Channel.listProgramIds", {id: id}, function(result, error) {
    if (result[0] != undefined) {
      setHM_MOD_EM_X(ch, true);
    } else {
      if(arModEM8[parseInt(ch)] != true) {
        var elm = jQuery("[name='CHANNEL_FUNCTION']")[ch - 1];
        jQuery(elm).prop("disabled", false);
      }
    }
  });
};

RF_existsLink = function(deviceType, address, ch) {
  switch(deviceType) {
    case "HM-MOD-EM-8":
      setHM_MOD_EM_X(ch, false);
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

Virtual_DimmerChannel_help = function(ch)
{
	//if ($F("virtual_help_button_" + ch) == "Hilfe")
	if ($F("virtual_help_button_" + ch) == translateKey("genericBtnTxtHelp"))
	{
		$("virtual_ch_help_" + ch).style.display = "inline";
		$("virtual_help_button_" + ch).value = translateKey("genericBtnTxtHelpOff");
	} else
	{
		$("virtual_ch_help_" + ch).style.display = "none";
		$("virtual_help_button_" + ch).value = translateKey("genericBtnTxtHelp");
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
  var ein;
  var aus;
  //1 
  
  if (switch_dir) 
  {  
    //ein = document.createTextNode("Einschaltschwelle");
    ein = document.createTextNode(translateKey("upperStormThreshold"));
    //aus = document.createTextNode("Ausschaltschwelle");
    aus = document.createTextNode(translateKey("lowerStormThreshold"));
  }
  else 
  {
    //ein = document.createTextNode("Ausschaltschwelle");
    ein = document.createTextNode(translateKey("lowerStormThreshold"));
    //aus = document.createTextNode("Einschaltschwelle");
    aus = document.createTextNode(translateKey("upperStormThreshold"));
  }  
  $('ein').replaceChild(ein, $('ein').firstChild);
  $('aus').replaceChild(aus, $('aus').firstChild);
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
      if ((link[0] == "WEATHER") && (linkPeer[0] != "WEATHER_RECEIVER")) return true;
      else return false;
    } else return false;
  }
};

WEATHER_put_desc = function(id,x)
{
    //1 
    
    if ((WEATHER_check_expert()) && (x == 0))   //2 
    {
//	  $('sender_profiles').options[0].selected = true;
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
    
    var desc = new Array();
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
	else return false;	// nicht aktiv
};

load_JSFunc = function(fbib) {
	//fbib gibt die gewuenschte Funktionsbibliothek incl. Pfad an

	if (isJSFunc_active(fbib) == false) // falls die Bibliothek noch nicht geladen wurde 
	{
//		alert('Bib wird geladen'); 
			new Ajax.Request(fbib, 
				{
				method:	 'get', 
				
				asynchronous: false,

				onSuccess:	function(success) {
								eval(success.responseText);
								exists_bib[fbib] = true; //Bibliothek geladen
							},
				
				onFailure:	function(failure) {
								alert(fbib + ': ' + failure.statusText);
							}
				}
			);
	}
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
	
