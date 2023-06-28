var new_slider = new Array();

self.Proof_Slider_Value = function(id, min, max)
{
  var input = document.getElementById(id);
  var ausdr_float = /\d+.\d+/;
  var ausdr_int  = /\d+/;
  if (ausdr_float.test(input.value)) {var wert_float = ausdr_float.exec(input.value); wert_float = wert_float[0];}
  if (ausdr_int.test(input.value)) {var wert_int = ausdr_int.exec(input.value); wert_int = wert_int[0];}
  var wert     = min;
  var pref     = id.split("_")[3];

  if (! wert_int) {wert = min;} //1 
  if (! isNaN(wert_int)) {wert = wert_int;}
  if (! isNaN(wert_float)) {wert = wert_float;}


  if (wert < min) {wert = min;}
  if (wert > max) {wert = max;}
  input.value = wert;
  new_slider[pref].setValue(input.value);
};


self.Set_Slider_Value = function(slider, element)
{
  for (loop = 0; loop <= document.getElementsByTagName('p').length - 1; loop++)
  {
    var knoten = document.getElementsByTagName('p')[loop];
    if (knoten.hasChildNodes())
    {
      if (knoten.id == slider.id)
      {
        element.value = knoten.firstChild.data;
      }
    }
  }

};

self.uSlider = function(handle, track, elem, min, max, step)
{
  var prn = elem.split("_")[1];
  var pref = elem.split("_")[2];

  var element = $('separate_' + elem);
  var slider = $('slider_' + prn + '_' + pref);

  var valid_values = new Array();

  //1
  var fix = 0;
  if (String(step).split(".")[1]) fix = String(step).split(".")[1].length;

  //2
  for (var loop = min; loop <= max;loop = parseFloat((loop += step).toFixed(fix)))
  {
    if (fix != 0) valid_values.push(loop.toFixed(fix));
    else valid_values.push(loop);
  }

  new_slider[pref] = new Control.Slider(handle, track, {

    range: $R(min, max),
    values: valid_values,
    sliderValue: element.value,
    onSlide:   function(value) {

      slider.style.display = "none";
      slider.update(value);
      Set_Slider_Value(slider, element);
    },
    onChange:   function(value) {

      slider.update(value);
      Set_Slider_Value(slider, element);
      slider.style.display = "none";
    }
  });
  new_slider[pref].setValue(element.value);
};

selectOnColor = function(value, prn, pref, valHUE, valSAT) {
  var shortOnHueElm = jQuery("#separate_receiver_"+prn+"_" + pref),
    shortOffHueElm = jQuery("#separate_receiver_"+prn+"_" + parseInt(pref +1)),
    longOnHueElm = jQuery("#separate_receiver_"+prn+"_" + parseInt(pref +2)),
    longOffHueElm = jQuery("#separate_receiver_"+prn+"_" + parseInt(pref +3)),

    shortOnSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 4)),
    shortOffSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 5)),
    longOnSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 6)),
    longOffSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 7)),

    tmpShortOnSatElm = jQuery("#tmp_SHORT_ON_SATURATION_"+prn+"_" + (parseInt(pref) +4)),
    tmpShortOffSatElm = jQuery("#tmp_SHORT_OFF_SATURATION_"+prn+"_" + (parseInt(pref) +5)),
    tmpLongOnSatElm = jQuery("#tmp_LONG_ON_SATURATION_"+prn+"_" + (parseInt(pref) +6)),
    tmpLongOffSatElm = jQuery("#tmp_LONG_OFF_SATURATION_"+prn+"_" + (parseInt(pref) +7)),

    colorPickerElm = jQuery("#anchorColorPicker_"+prn+"_" + pref),
    trColorPicker = jQuery("#trColorPicker_"+prn+"_" + pref),
    valSatPercent;

  if (value == "lastValue") {
    trColorPicker.hide();
    shortOnHueElm.val("361");
    shortOffHueElm.val("361");
    longOnHueElm.val("361");
    longOffHueElm.val("361");

    tmpShortOnSatElm.val("101");
    tmpShortOffSatElm.val("101");
    tmpLongOnSatElm.val("101");
    tmpLongOffSatElm.val("101");

    shortOnSatElm.val("1.01");
    shortOffSatElm.val("1.01");
    longOnSatElm.val("1.01");
    longOffSatElm.val("1.01");
    
  } else if (value == "setColor") {
    shortOnHueElm.val(valHUE);
    shortOffHueElm.val(valHUE);
    longOnHueElm.val(valHUE);
    longOffHueElm.val(valHUE);

    valSatPercent = parseInt((parseFloat(valSAT) * 100));

    tmpShortOnSatElm.val(valSatPercent);
    tmpShortOffSatElm.val(valSatPercent);
    tmpLongOnSatElm.val(valSatPercent);
    tmpLongOffSatElm.val(valSatPercent);

    shortOnSatElm.val(valSAT);
    shortOffSatElm.val(valSAT);
    longOnSatElm.val(valSAT);
    longOffSatElm.val(valSAT);

    colorPickerElm.show();

    trColorPicker.show();
  }
};

selectOnColorTemp = function(value, prn, pref, valCT_Son, valCT_Lon, valCT_Soff, valCT_Loff, maxCOLOR_TEMP, onOroff) {
  var iPref = parseInt(pref),
    shortOnColorTempElm = jQuery(""), longOnColorTempElm = jQuery(""), shortOffColorTempElm = jQuery(""), longOffColorTempElm = jQuery(""),
    trColorTemp = jQuery("#trColorTempSlider_"+prn+"_" + pref);

    if (onOroff == "") {
      shortOnColorTempElm = jQuery("#separate_receiver_"+prn+"_" + pref);
      longOnColorTempElm = jQuery("#separate_receiver_"+prn+"_" + (iPref + 1));
      shortOffColorTempElm = jQuery("#separate_receiver_"+prn+"_" + (iPref + 2));
      longOffColorTempElm = jQuery("#separate_receiver_"+prn+"_" + (iPref + 3));
    } else if (onOroff == "ON") {
      shortOnColorTempElm = jQuery("#separate_receiver_" + prn + "_" + pref);
      longOnColorTempElm = jQuery("#separate_receiver_" + prn + "_" + (iPref + 1));
    } else if (onOroff == "OFF") {
      shortOffColorTempElm = jQuery("#separate_receiver_" + prn + "_" + pref);
      longOffColorTempElm = jQuery("#separate_receiver_" + prn + "_" + (iPref + 1));
    }


  if (value == "lastValue") {
    trColorTemp.hide();
    shortOnColorTempElm.val("10100");
    longOnColorTempElm.val("10100");
    shortOffColorTempElm.val("10100");
    longOffColorTempElm.val("10100");
  } else if (value == "setColorTemp") {
    if (parseInt(valCT_Son) > parseInt(maxCOLOR_TEMP) ) {
      shortOnColorTempElm.val(maxCOLOR_TEMP);
      longOnColorTempElm.val(maxCOLOR_TEMP);
      shortOffColorTempElm.val(maxCOLOR_TEMP);
      longOffColorTempElm.val(maxCOLOR_TEMP);
    } else {
      shortOnColorTempElm.val(valCT_Son);
      longOnColorTempElm.val(valCT_Lon);
      shortOffColorTempElm.val(valCT_Soff);
      longOffColorTempElm.val(valCT_Loff);

    }
    trColorTemp.show();
  }
};

getHSV_ColorPicker = function(prn, pref) {

  var shortOnHueElm = jQuery("#separate_receiver_"+prn +"_"+ pref),
    shortOffHueElm = jQuery("#separate_receiver_"+prn +"_"+ parseInt(pref +1)),
    longOnHueElm = jQuery("#separate_receiver_"+prn +"_"+ parseInt(pref +2)),
    longOffHueElm = jQuery("#separate_receiver_"+prn +"_"+ parseInt(pref +3)),
    shortOnSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 4)),
    shortOffSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 5)),
    longOnSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 6)),
    longOffSatElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 7)),

    tmpShortOnSatElm = jQuery("#tmp_SHORT_ON_SATURATION_"+prn+"_" + (parseInt(pref) +4)),
    tmpShortOffSatElm = jQuery("#tmp_SHORT_OFF_SATURATION_"+prn+"_" + (parseInt(pref) +5)),
    tmpLongOnSatElm = jQuery("#tmp_LONG_ON_SATURATION_"+prn+"_" + (parseInt(pref) +6)),
    tmpLongOffSatElm = jQuery("#tmp_LONG_OFF_SATURATION_"+prn+"_" + (parseInt(pref) +7)),

    selectedColorIndicatorElm = jQuery("#selectedColor_"+prn+ "_" + (parseInt(pref) +7));

  var hue = shortOnHueElm.val(), saturation = shortOnSatElm.val();

  var colorPicker = new iro.ColorPicker("#anchorColorPicker_" + prn + "_" + pref, {
    // Set the size of the color picker
    width: 90,
    color: {h: hue, s: parseInt(saturation * 100), v: 100},
    wheelLightness: false, // If set to false, the color wheel will not fade to black when the lightness decreases.
    layout: [{component: iro.ui.Wheel}], // Don't show the V slider below the wheel - this value is the LEVEL Parameter of the profile
    handleRadius: 4
    }
  );

  colorPicker.on("mount", function(color) {
    var rgbVal = hsvToRgb(hue, parseInt(saturation * 100), 100);
    selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
  });

  colorPicker.on("input:end", function(color) {
    var hsv_H = color.hsv.h,
      hsv_S,
      hsv_S_Percent = parseInt(color.hsv.s),
      rgbVal;

    hsv_S = (parseInt(color.hsv.s) / 100);
    shortOnHueElm.val(hsv_H);
    shortOffHueElm.val(hsv_H);
    longOnHueElm.val(hsv_H);
    longOffHueElm.val(hsv_H);

    shortOnSatElm.val(hsv_S);
    shortOffSatElm.val(hsv_S);
    longOnSatElm.val(hsv_S);
    longOffSatElm.val(hsv_S);

    tmpShortOnSatElm.val(parseInt(hsv_S * 100));
    tmpShortOffSatElm.val(parseInt(hsv_S * 100));
    tmpLongOnSatElm.val(parseInt(hsv_S * 100));
    tmpLongOffSatElm.val(parseInt(hsv_S * 100));

    rgbVal = hsvToRgb(color.hsv.h, color.hsv.s, 100);
    selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
  });

  shortOnHueElm.keyup(function(event) {
    var val, HUE, rgbVal;
    if (event.keyCode == 13) {
      val = parseInt(jQuery(this).val());
      if (val < 0 || isNaN(val)) {HUE = 0;} else if (val > 360) {HUE = 360;} else {HUE = val;};
      jQuery(this).val(HUE);
      shortOffHueElm.val(HUE);
      longOnHueElm.val(HUE);
      longOffHueElm.val(HUE);

      colorPicker.color.hsv = {h: HUE, s: parseInt(shortOnSatElm.val() * 100), v: 100};
      rgbVal = hsvToRgb(colorPicker.color.hsv.h,colorPicker.color.hsv.s, 100);
      selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
    }
  });

  shortOnHueElm.blur(function(event) {
    var val, HUE, rgbVal;
    val = parseInt(jQuery(this).val());
    if (val < 0 || isNaN(val)) {HUE = 0;} else if (val > 360) {HUE = 360;} else {HUE = val;};
    jQuery(this).val(HUE);
    shortOffHueElm.val(HUE);
    longOnHueElm.val(HUE);
    longOffHueElm.val(HUE);

    colorPicker.color.hsv = {h: HUE, s: parseInt(shortOnSatElm.val() * 100), v: 100};
    rgbVal = hsvToRgb(colorPicker.color.hsv.h,colorPicker.color.hsv.s, 100);
    selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
  });

  tmpShortOnSatElm.keyup(function(event) {
    var val, SATURATION, rgbVal, satDiv100;

    if (event.keyCode == 13) {
      val = parseInt(jQuery(this).val());
      if (val < 0 || isNaN(val)) {SATURATION = 0;} else if (val > 100) {SATURATION = 100;} else {SATURATION = val;};
      satDiv100 = SATURATION / 100;
      jQuery(this).val(SATURATION);
      tmpShortOffSatElm.val(SATURATION);
      tmpLongOnSatElm.val(SATURATION);
      tmpLongOffSatElm.val(SATURATION);

      shortOnSatElm.val(satDiv100);
      shortOffSatElm.val(satDiv100);
      longOnSatElm.val(satDiv100);
      longOffSatElm.val(satDiv100);


      colorPicker.color.hsv = {h: shortOnHueElm.val(), s: SATURATION, v: 100};
      rgbVal = hsvToRgb(colorPicker.color.hsv.h,colorPicker.color.hsv.s, 100);
      selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
    }
  });

  tmpShortOnSatElm.blur(function(event) {
    var val, SATURATION, rgbVal, satDiv100;
    val = parseInt(jQuery(this).val());
    if (val < 0 || isNaN(val)) {SATURATION = 0;} else if (val > 100) {SATURATION = 100;} else {SATURATION = val;};
    satDiv100 = SATURATION / 100;
    jQuery(this).val(SATURATION);
    tmpShortOffSatElm.val(SATURATION);
    tmpLongOnSatElm.val(SATURATION);
    tmpLongOffSatElm.val(SATURATION);

    shortOnSatElm.val(satDiv100);
    shortOffSatElm.val(satDiv100);
    longOnSatElm.val(satDiv100);
    longOffSatElm.val(satDiv100);

    colorPicker.color.hsv = {h: shortOnHueElm.val(), s: SATURATION, v: 100};
    rgbVal = hsvToRgb(colorPicker.color.hsv.h,colorPicker.color.hsv.s, 100);
    selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
  });
};

// onOff = either ON or OFF
// sliderOnOffavail false = on color slider, true = 2 color slider (one for ON, one for OFF)
getColorHueSlider = function(prn, pref, onOff, sliderOnOffavail) {

  var offsetPref = (sliderOnOffavail && (onOff == "ON")) ? 5 : 0; // this is for the profile color up/down - here we have 2 color slider

  var anchorHueSlider = "#anchorColorHueSlider_"+prn+"_"+pref,
    shortOnHueElm = jQuery("#separate_receiver_"+prn +"_"+ pref),
    selectedColorIndicatorElm = jQuery("#selectedColor_"+prn+ "_" + pref),
    longDimMinHueElm = jQuery("#separate_receiver_"+prn+ "_" + ((parseInt(pref) + 4) + offsetPref)),
    longDimMaxHueElm = jQuery("#separate_receiver_"+prn+ "_" + ((parseInt(pref) + 5) + offsetPref)),
    hue = shortOnHueElm.val(),
    rgbVal;

  var colorPicker = new iro.ColorPicker(anchorHueSlider, {
    width: 120,
    sliderSize: 20, // height
    color: {h: hue, s: 100, v: 100},
    handleSvg: '#handle',
    layout: [
      {
        component: iro.ui.Slider,
        options: {
          sliderType: 'hue',
          edgeRadius: 0
        }
      }
    ]
  });

  function setValues2Send (infinitiveDimActive,sliderOnOffavail,onOff,val) {
    if (!infinitiveDimActive) {
      if (! sliderOnOffavail) {
        switch (onOff) {
          case "ON" :
            longDimMinHueElm.val(0);
            longDimMaxHueElm.val(val);
            break;
          case "OFF" :
            longDimMinHueElm.val(val);
            longDimMaxHueElm.val(359);
            break;
        }
      } else {
        // Profile color up/down - here we have 2 color slider
        switch (onOff) {
          case "ON" :
            longDimMaxHueElm.val(val);
            break;
          case "OFF" :
            longDimMinHueElm.val(val);
            break;
        }
      }
    }
  }

  colorPicker.on("input:end", function(color) {

    var infinitiveDimActive = jQuery("#chkDimInfinitive_"+prn).is(':checked'),
    hsv_H = parseInt(color.hsv.h),
    rgbVal;

    hsv_H = (hsv_H >= 360) ? 359 : hsv_H;
    shortOnHueElm.val(hsv_H);

    setValues2Send(infinitiveDimActive,sliderOnOffavail,onOff,hsv_H);

    rgbVal = hsvToRgb(color.hsv.h, 100, 100);
    selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
  });

  shortOnHueElm.keyup(function(event) {
    var val, HUE, rgbVal,infinitiveDimActive = jQuery("#chkDimInfinitive_"+prn).is(':checked');
    if (event.keyCode == 13) {
      val = parseInt(jQuery(this).val());
      if (val < 0 || isNaN(val)) {HUE = 0;} else if (val >= 360) {HUE = 359;} else {HUE = val;};
      jQuery(this).val(HUE);

      setValues2Send(infinitiveDimActive,sliderOnOffavail,onOff,HUE);

      colorPicker.color.hsv = {h: HUE, s: 100, v: 100};
      rgbVal = hsvToRgb(colorPicker.color.hsv.h,100, 100);
      selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
    }
  });

  shortOnHueElm.blur(function(event) {
    var val, HUE, rgbVal, infinitiveDimActive = jQuery("#chkDimInfinitive_"+prn).is(':checked');
    val = parseInt(jQuery(this).val());
    if (val < 0 || isNaN(val)) {HUE = 0;} else if (val >= 360) {HUE = 359;} else {HUE = val;};
    jQuery(this).val(HUE);

    setValues2Send(infinitiveDimActive,sliderOnOffavail,onOff,HUE);

    colorPicker.color.hsv = {h: HUE, s: 100, v: 100};
    rgbVal = hsvToRgb(colorPicker.color.hsv.h,100, 100);
    selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
  });

  colorPicker.color.hsv = {h: shortOnHueElm.val(), s: 100, v: 100};
  rgbVal = hsvToRgb(colorPicker.color.hsv.h,100, 100);
  selectedColorIndicatorElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");

};

getColorTempSlider = function(prn, pref, onOroff) {
  var anchorSlider = jQuery("#colorTempSlider_"+prn+"_"+pref),
    receiverAddress = jQuery("#global_receiver_address").val(),
    iface = jQuery("#global_iface").val(),
    sliderOpts = {},
    chnDescription = homematic("Interface.getParamset", {"interface":iface, "address": receiverAddress, "paramsetKey": "MASTER"}),
    val2SendElmShortON = jQuery(""), val2SendElmLongON = jQuery(""), val2SendElmShortOFF = jQuery(""), val2SendElmLongOFF = jQuery("");

    if (onOroff == "") {
      val2SendElmShortON = jQuery("#separate_receiver_" + prn + "_" + pref);
      val2SendElmLongON = jQuery("#separate_receiver_" + prn + "_" + (parseInt(pref) + 1));
      val2SendElmShortOFF = jQuery("#separate_receiver_" + prn + "_" + (parseInt(pref) + 2));
      val2SendElmLongOFF = jQuery("#separate_receiver_" + prn + "_" + (parseInt(pref) + 3));
    } else if (onOroff == "ON") {
      val2SendElmShortON = jQuery("#separate_receiver_" + prn + "_" + pref);
      val2SendElmLongON = jQuery("#separate_receiver_" + prn + "_" + (parseInt(pref) + 1));
    } else if (onOroff == "OFF") {
      val2SendElmShortOFF = jQuery("#separate_receiver_" + prn + "_" + pref);
      val2SendElmLongOFF = jQuery("#separate_receiver_" + prn + "_" + (parseInt(pref) + 1));
    }

  sliderOpts.animate = 'fast';

  sliderOpts.min = parseInt(chnDescription.HARDWARE_COLOR_TEMPERATURE_WARM_WHITE);
  sliderOpts.max = parseInt(chnDescription.HARDWARE_COLOR_TEMPERATURE_COLD_WHITE);

  if (parseInt(val2SendElmShortON.val()) < sliderOpts.min) {
    val2SendElmShortON.val(sliderOpts.min);
    val2SendElmLongON.val(sliderOpts.min);
  } else if (parseInt(val2SendElmShortON.val()) > sliderOpts.max) {
    val2SendElmShortON.val(sliderOpts.max);
    val2SendElmLongON.val(sliderOpts.max);
  }

  sliderOpts.value = (onOroff == "" || onOroff == "ON") ? parseInt(val2SendElmShortON.val()) : parseInt(val2SendElmShortOFF.val()) ;
  sliderOpts.step = 50;
  sliderOpts.orientation = 'horizontal';

  var sliderElm = jQuery(anchorSlider).slider(sliderOpts);

  sliderElm.on("slide", function (event, ui) {
    val2SendElmShortON.val(ui.value);
    val2SendElmLongON.val(ui.value);
    val2SendElmShortOFF.val(ui.value);
    val2SendElmLongOFF.val(ui.value);
  });

  sliderElm.on("slidestop", function(event, ui){
    val2SendElmShortON.val(ui.value);
    val2SendElmLongON.val(ui.value);
    val2SendElmShortOFF.val(ui.value);
    val2SendElmLongOFF.val(ui.value);
  });

  val2SendElmShortON.keyup(function(event) {
    var val, newVal;
    if (event.keyCode == 13) {
      val = parseInt(jQuery(this).val());
      if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
      jQuery(this).val(newVal);
      val2SendElmLongON.val(newVal);
      val2SendElmShortOFF.val(newVal);
      val2SendElmLongOFF.val(newVal);
      sliderElm.slider("value", parseInt(newVal));
    }
  });

  val2SendElmShortON.blur(function(event) {
    var val, newVal;
      val = parseInt(jQuery(this).val());
      if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
      jQuery(this).val(newVal);
      val2SendElmLongON.val(newVal);
      val2SendElmShortOFF.val(newVal);
      val2SendElmLongOFF.val(newVal);
      sliderElm.slider("value", parseInt(newVal));
  });

  val2SendElmShortOFF.keyup(function(event) {
    var val, newVal;
    if (event.keyCode == 13) {
      val = parseInt(jQuery(this).val());
      if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
      jQuery(this).val(newVal);
      val2SendElmLongON.val(newVal);
      val2SendElmShortOFF.val(newVal);
      val2SendElmLongOFF.val(newVal);
      sliderElm.slider("value", parseInt(newVal));
    }
  });

  val2SendElmShortOFF.blur(function(event) {
    var val, newVal;
    val = parseInt(jQuery(this).val());
    if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
    jQuery(this).val(newVal);
    val2SendElmLongON.val(newVal);
    val2SendElmShortOFF.val(newVal);
    val2SendElmLongOFF.val(newVal);
    sliderElm.slider("value", parseInt(newVal));
  });

};


getColorTempSliderMinMax = function(prn, pref, keypress) {
  var anchorSlider = jQuery("#colorTempSliderMinMax_"+prn+"_"+pref),
    receiverAddress = jQuery("#global_receiver_address").val(),
    iface = jQuery("#global_iface").val(),
    sliderOpts = {},
    chnDescription = homematic("Interface.getParamset", {"interface":iface, "address": receiverAddress, "paramsetKey": "MASTER"}),
    val2SendElm = jQuery("#separate_receiver_"+prn+"_" + pref);

  if (keypress == "SHORT_LONG") {
    var valLongElm = jQuery("#separate_receiver_"+prn+"_" + (parseInt(pref) + 1));
  }

  sliderOpts.animate = 'fast';
  sliderOpts.min = parseInt(chnDescription.HARDWARE_COLOR_TEMPERATURE_WARM_WHITE);
  sliderOpts.max = parseInt(chnDescription.HARDWARE_COLOR_TEMPERATURE_COLD_WHITE);

  if (parseInt(val2SendElm.val()) < sliderOpts.min) {
    val2SendElm.val(sliderOpts.min);
  } else if (parseInt(val2SendElm.val()) > sliderOpts.max) {
    val2SendElm.val(sliderOpts.max);
  }

  sliderOpts.value = parseInt(val2SendElm.val());
  sliderOpts.step = 50;
  sliderOpts.orientation = 'horizontal';

  var sliderElm = jQuery(anchorSlider).slider(sliderOpts);

  sliderElm.on("slide", function (event, ui) {
    val2SendElm.val(ui.value);
    if (valLongElm) {valLongElm.val(val2SendElm.val());};
  });

  sliderElm.on("slidestop", function(event, ui) {
    var sliderVal = parseInt(ui.value);
    sliderElm.slider("value", sliderVal);
    val2SendElm.val(sliderVal);
    if (valLongElm) {valLongElm.val(val2SendElm.val());};
  });

  val2SendElm.keyup(function(event) {
    var val, newVal;

    if (event.keyCode == 13) {
      val = parseInt(jQuery(this).val());
      if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
      jQuery(this).val(newVal);
      if (valLongElm) {valLongElm.val(val2SendElm.val());};
      sliderElm.slider("value", parseInt(newVal));
    }
  });

  val2SendElm.blur(function(event) {
    var val, newVal;
    val = parseInt(jQuery(this).val());
    if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
    jQuery(this).val(newVal);
    if (valLongElm) {valLongElm.val(val2SendElm.val());};
    sliderElm.slider("value", parseInt(newVal));
  });

  val2SendElm.trigger("blur");

};

// HmIP-RGBW and HmIP-DRG-DALI Effects

addLeadingZero = function(val) {
  if (typeof val == "string") {
    if (val[0] == "0") {return val;}
  }
  return (parseInt(val) < 10) ? "0"+val : val;
};

convertSeconds2Option = function(sec) {
  var hours, minutes, seconds, optionText = "--";

  hours = Math.floor(sec / 3600);
  sec %= 3600;
  minutes = Math.floor(sec / 60);
  seconds = sec % 60;

  if (seconds.toString().indexOf(".") != -1) {
    seconds = parseFloat(seconds).toFixed(1);
  }

  if (hours > 30) {return translateKey("optionPermanently")};
  if ((hours == 0) && (minutes == 0) && (seconds != 0)) {return seconds + " " + translateKey("optionUnitS");}
  if ((hours == 0) && (minutes != 0) && (seconds == 0)) {return minutes + " " + translateKey("optionUnitM");}
  if ((hours != 0) && (minutes == 0) && (seconds == 0)) {return hours + " " + translateKey("optionUnitH");}

  if ((hours == 0) && (minutes != 0) && (seconds != 0)) {return minutes + " Min / " + seconds + " Sec";}
  if ((hours != 0) && (minutes != 0) && (seconds == 0)) {return hours + " Std / " + minutes + " Min";}

  return hours + " Std / " +minutes + " Min / " + seconds + " Sec";
};

get8BitString = function(bString) {
  var binString = bString;
  for (var x = binString.length; binString.length <= 7; x++) {
    binString = "0" + binString;
  }
  return binString;
};

proofUserTimeValue = function(elm) {
  var valTimeBase = jQuery("#timeBase").val(),
    valTimeFactor = parseInt(elm.value);
  if ((isNaN(valTimeFactor) || (valTimeFactor) < 0)) {
    elm.value = 0;
  } else if (valTimeFactor > 30) {
    elm.value = 30;
  }
};

proofUserEffectLevel = function(elm) {
  var valLevel = parseInt(jQuery("#effectLevel").val());

  if (isNaN(valLevel) || (valLevel < 0)) {
    elm.value = 0;
  } else if (valLevel > 100) {
    elm.value = 100;
  }
};

getHTMLUserTime = function () {
  var html = "";

  html += "<table class='center'>";
    html += "<tr>";
      html += "<td>";
        html += "Base: ";
      html += "</td>";
      html += "<td>";
        html += "<select id='timeBase'>";
          html += "<option value='0'>100ms</option>";
          html += "<option value='1'>1S</option>";
          html += "<option value='2'>5S</option>";
          html += "<option value='3'>10S</option>";
          html += "<option value='4'>1M</option>";
          html += "<option value='5'>5M</option>";
          html += "<option value='6'>10M</option>";
          html += "<option value='7'>1H</option>";
        html += "</select>";
      html += "</td>";
    html += "</tr>";

    html += "<tr>";
      html += "<td>";
        html += "Factor: ";
      html += "</td>";
      html += "<td>";
       html += "<input type='text' id='timeFactor' class='alignCenter' size='5' onchange='proofUserTimeValue(this)'>";
      html += "</td>";
    html += "</tr>";
  html += "</table>";

  return html;
};

getHTMLEffectLevel = function() {
  var html = "";

  html += "<table class='center'>";
    html += "<tr>";
      html += "<td>";
        html += translateKey('stringTableDimmerLevel') + " in %  ";
      html += "</td>";
      html += "<td>";
        html += "<input type='text' id='effectLevel' class='alignCenter' size='5' onchange='proofUserEffectLevel(this)'>";
      html += "</td>";
    html += "</tr>";
  html += "</table>"

  return html;

};

getUsrDefinedTimeOption = function (base, factor) {
  //100ms, 1S, 5S, 10S, 1M, 5M, 10M 1H
  var arFactor = [0.1,1,5,10,60,300,600,3600],
    seconds = arFactor[parseInt(base)] * parseInt(factor),
    newOption = new Option(convertSeconds2Option(seconds), 8);
  newOption.userVal = base+"_"+factor;

  return newOption;
};

getUsrDefinedLevelOption = function (level) {
  var decimalPoints = ((level == 0) || (level == 100)) ? 1 : 2;

  var newOption = new Option(level + " %", (parseFloat(level) / 100).toFixed(decimalPoints));
  newOption.userVal = level;
  return newOption;
};


getSortedOptions = function(selectBox) {
  return selectBox.find("option").sort(function (a, b) {
    a = a.value;
    b = b.value;
    return a-b;
  });
};

setEffectColorMode = function(value, effectNo) {
  // 01_EFFECT_COLOR_MODE
  var elm = jQuery("[name='"+effectNo+"_EFFECT_COLOR_MODE']").first();
  elm.val(value);
};

setEffectRepetitions = function(elm, effectNo) {
  // 01_EFFECT_REPETITIONS
  var val = parseInt(elm.value),
  repetitionElm = jQuery("[name='"+effectNo+"_EFFECT_REPETITIONS']").first();
  if (isNaN(val) || val < 0) {val = 0;} else if (val > 63) {val = 63;}
  elm.value = val;
  repetitionElm.val(val);
};

setEffectTime = function(elm, mode, effectNo, subEffectNo) {
  if (elm.value == 10) {
    var dlg = new YesNoDialog("", getHTMLUserTime(), function(result) {

      if (result == 1) {
        jQuery("#" + elm.id + " option[value='8']").remove(); // Remove a possible existing user option
        var el = jQuery(elm),
          arResult = this.getUserTime();

        // Add user defined Option
        el.append(getUsrDefinedTimeOption(arResult[0], arResult[1]));
        el.html(getSortedOptions(el));
        el.val(8); // User defined value

        _setEffectTime(elm, mode, effectNo, subEffectNo)

      }
    }, "html");

    dlg.setWidth(450);
    dlg.timeBase = jQuery("#timeBase");
    dlg.timeFactor = jQuery("#timeFactor");
    dlg.getUserTime = function() {
      return [this.timeBase.val(),this.timeFactor.val()];
    };

  } else {
    _setEffectTime(elm, mode, effectNo, subEffectNo);
  }
};

_setEffectTime = function(elm, mode, effectNo, subEffectNo) {
  // 01_EFFECT_01_COLOR_FADE_IN_TIME_BASE - 01_EFFECT_01_COLOR_FADE_IN_TIME_FACTOR
  // 01_EFFECT_01_COLOR_HOLD_TIME_BASE - 01_EFFECT_01_COLOR_HOLD_TIME_FACTOR
  var preParam = effectNo+"_EFFECT_"+subEffectNo+"_",
    timeBase = "_TIME_BASE", timeFactor = "_TIME_FACTOR",
    baseElm, factorElm,
    selectedVal = elm.value,
    userOption,
    arUsrBaseFactor = [],

    //The 1st val is the base, the 2nd value is the value
    //base >> 0 = 100ms, 1 = 1S, 2 = 5S, 3 = 10S, 4 = 1M, 5 = 5M, 6 = 10M, 7 = 1H

    arFadeInTime = [[0,0],[1,1],[1,2],[1,4],[1,5],[1,30],[4,1],[4,2]],
    arHoldTime = [[0,0],[0,1],[0,2],[0,5],[1,1],[1,2],[1,5],[1,10]];

  // Here we check if a user value is selected.
  if ((selectedVal > (arFadeInTime.length) - 1) && (selectedVal < 10)) { // 10 = Enter Value
    selectedVal = arFadeInTime.length ; // User defined value
    userOption = jQuery(elm).find(":selected");
    arUsrBaseFactor = userOption.prop("userVal").split("_");
  }

  // baseElm and factorElm are containing the current value as well as the value to send (when changed)
  switch (mode) {
    case "colorFadeInTime":
      // Here we check if a user value is selected.
      if ((selectedVal > (arFadeInTime.length) - 1)) {
        arFadeInTime.push([arUsrBaseFactor[0], arUsrBaseFactor[1]]);
      }

      baseElm = jQuery("[name='" + preParam + "COLOR_FADE_IN" + timeBase +"']").first();
      factorElm = jQuery("[name='" + preParam + "COLOR_FADE_IN" + timeFactor +"']").first();
      baseElm.val(arFadeInTime[selectedVal][0]);
      factorElm.val(arFadeInTime[selectedVal][1]);
      break;
    case "colorHoldTime":
      // Here we check if a user value is selected.
      if ((selectedVal > (arHoldTime.length) - 1)) {
        arHoldTime.push([arUsrBaseFactor[0], arUsrBaseFactor[1]]);
      }

      baseElm = jQuery("[name='" + preParam + "COLOR_HOLD" + timeBase +"']").first();
      factorElm = jQuery("[name='" + preParam + "COLOR_HOLD" + timeFactor +"']").first();
      baseElm.val(arHoldTime[selectedVal][0]);
      factorElm.val(arHoldTime[selectedVal][1]);
      break;
  }
};

initFadeInTime = function() {
  // id   = colorFadeInTime_01_01
  // name = colorFadeInTime

  // name = 01(-10)_EFFECT_01(-08)_COLOR_FADE_IN_TIME_BASE
  // name = 01(-10)_EFFECT_01(-08)_COLOR_FADE_IN_TIME_FACTOR

  var curFadeInElm, curHoldTimeElm, curValFadeInTimeBase, curValFadeInTimeFactor, curValHoldTimeBase, curValHoldTimeFactor,
    effectNo, subEffectNo, needNewFadeInOpton, needNewHoldTimeOption;

  //The 1st val is the base, the 2nd value is the value
  //base >> 0 = 100ms, 1 = 1S, 2 = 5S, 3 = 10S, 4 = 1M, 5 = 5M, 6 = 10M, 7 = 1H
  var arFadeInTime = [[0,0],[1,1],[1,2],[1,4],[1,5],[1,30],[4,1],[4,2]],
    arHoldTime = [[0,0],[0,1],[0,2],[0,5],[1,1],[1,2],[1,5],[1,10]];

  for (var loopx = 1; loopx <= 10; loopx++) {
    for (var loopy = 1; loopy <= 8; loopy++) {
      needNewFadeInOpton = true;
      needNewHoldTimeOption = true;
      effectNo = addLeadingZero(loopx);
      subEffectNo = addLeadingZero(loopy);

      curFadeInElm = jQuery("#colorFadeInTime_"+effectNo+"_"+subEffectNo);
      curHoldTimeElm = jQuery("#colorHoldTime_"+effectNo+"_"+subEffectNo);

      curValFadeInTimeBase = jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_FADE_IN_TIME_BASE']").first().val();
      curValFadeInTimeFactor = jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_FADE_IN_TIME_FACTOR']").first().val();

      curValHoldTimeBase = jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HOLD_TIME_BASE']").first().val();
      curValHoldTimeFactor = jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HOLD_TIME_FACTOR']").first().val();

      jQuery.each(arFadeInTime, function(index, val) {
        if ((curValFadeInTimeBase == val[0]) && (curValFadeInTimeFactor == val[1])) {
          curFadeInElm.val(index);
          needNewFadeInOpton = false;
        }
      });
      if (needNewFadeInOpton) {
        // Add user defined Option
        curFadeInElm.append(getUsrDefinedTimeOption(curValFadeInTimeBase, curValFadeInTimeFactor));
        curFadeInElm.html(getSortedOptions(curFadeInElm));
        curFadeInElm.val(8); // User defined value
      }

      jQuery.each(arHoldTime, function(index, val) {
        if ((curValHoldTimeBase == val[0]) && (curValHoldTimeFactor == val[1])) {
          curHoldTimeElm.val(index);
          needNewHoldTimeOption = false;
        }
      });
      if (needNewHoldTimeOption) {
        // Add user defined Option
        curHoldTimeElm.append(getUsrDefinedTimeOption(curValHoldTimeBase, curValHoldTimeFactor));
        curHoldTimeElm.html(getSortedOptions(curHoldTimeElm));
        curHoldTimeElm.val(8); // User defined value
      }
    }
  }
};

setEffectLevel = function(elm, effectNo, subEffectNo) {

  if (parseInt(elm.value) == 2) {
    var dlg = new YesNoDialog("", getHTMLEffectLevel(), function(result) {

      var arAvailOptions = [0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0],
        createUserVal = false;

      if (result == 1) {
        var el =  jQuery("#" + elm.id),
        optionEnterValue =  jQuery("#" + elm.id + " option[value='2']");

        if (jQuery.inArray(this.level, arAvailOptions) == -1) {createUserVal = true;}

        if (createUserVal) {
          // Add user defined Option
          jQuery(getUsrDefinedLevelOption(parseInt(this.level))).insertBefore(optionEnterValue);
          el.html(getSortedOptions(el));
        }
        el.val(parseFloat(this.level / 100));
        _setEffectLevel(el.val(), effectNo, subEffectNo);

      }
    }, "html");

    dlg.setWidth(450);
    dlg.close = function (result) {
      this.level = jQuery("#effectLevel").val();
      Layer.remove(this.m_layer);
      if (this.m_callback) { this.m_callback(result); }
    };

  } else {
    _setEffectLevel(elm.value, effectNo, subEffectNo);
  }

};

_setEffectLevel = function(value, effectNo, subEffectNo) {
  jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_LEVEL']").first().val(value);
};

initEffectLevel = function() {
  //name = 01(-10)_EFFECT_01(-08)_COLOR_LEVEL
  var effectNo, subEffectNo, sCurValue, curValue, levelSelectElm, optionEnterValue,
    arAvailOptions = ["0.00","0.10","0.20","0.30","0.40","0.50","0.60","0.70","0.80","0.90","1.00"],
    createUserVal;

  for (var loopx = 1; loopx <= 10; loopx++) {
    for (var loopy = 1; loopy <= 8; loopy++) {
      createUserVal = false;
      effectNo = addLeadingZero(loopx);
      subEffectNo = addLeadingZero(loopy);
      levelSelectElm = jQuery("#level_"+ effectNo +"_" + subEffectNo);
      optionEnterValue =  jQuery("#" + levelSelectElm.prop('id') + " option[value='2']");
      sCurValue = jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_LEVEL']").first().val().substring(0,4),
      curValue = parseFloat(sCurValue);

      if (jQuery.inArray(sCurValue, arAvailOptions) == -1) {createUserVal = true;}

      if (createUserVal) {
        // Add user defined Option
        jQuery(getUsrDefinedLevelOption(parseInt(curValue * 100))).insertBefore(optionEnterValue);
        levelSelectElm.html(getSortedOptions(levelSelectElm));
      }
      levelSelectElm.val(curValue);

    }
  }
};

setSatColorTempType = function(elm, effectNo, subEffectNo) {
  var selectedVal = parseInt(elm.value);

  //01_EFFECT_01_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_TYPE
  jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_TYPE']").first().val(elm.value);

  if ((selectedVal == 0) || (selectedVal == 1)) { // HUE
    jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first().val(0); //HUE 0 0
    jQuery("#color_" + effectNo + "_" + subEffectNo).html("&nbsp;").css("background-color", "rgb(" + rgbVal.r + "," + rgbVal.g + "," + rgbVal.b + ")");
  } else if (selectedVal == 2) { // Color Temp
    jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first().val(20); // 20 == 50 * 20 == 1000K
    jQuery("#color_" + effectNo + "_" + subEffectNo).html("1000 K").css("background-color", "rgb(255,255,255)");
  }

};

initSatColorTempType = function() {
  var effectNo, subEffectNo, curValue;

  for (var loopx = 1; loopx <= 10; loopx++) {
    for (var loopy = 1; loopy <= 8; loopy++) {
      effectNo = addLeadingZero(loopx);
      subEffectNo = addLeadingZero(loopy);
      curValue = parseInt(jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_TYPE']").first().val());
      jQuery("#satColorTempType_"+ effectNo +"_" + subEffectNo).val(curValue);
    }
  }
};

setSatColorTempValue = function(elm, effectNo, subEffectNo) {
  var valEffectType = parseInt(jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_TYPE']").first().val()); //Inactive, HUE/SAT or Color Temp

  switch (valEffectType) {
    case 0:
      alert(translateKey("hintNoModeActive"));
      break;
    case 1:
      setEffectHueSat(elm, effectNo, subEffectNo);
      break;
    case 2:
      setEffectColorTemp(elm, effectNo, subEffectNo);
      break;
  }
};

getHTMLHueSatPicker = function() {
  var html = "";

  html += "<table class='center'>";
    html += "<tr>";

      html += "<td style='width:90px;'>";
        html += "<div id='effectColorPicker'></div>";
      html += "</td>";

      // Inputs of the color picker
      html += "<td>";
        html += "<table class='ControlBtnInfo'>";

          html += "<tr>";
            html += "<td><span style='color:white'>H</span></td>";
            html += "<td>";
              html += "<input id='hueElm' type='text' size='3' style='text-align:center'>";
            html += "</td>";
            html += "<td><span style='color:white'>&deg;</span></td>";
          html += "</tr>";

          html += "<tr>";
            html += "<td><span style='color:white'>S</span></td>";
            html += "<td>";
              html += "<input id='satElm' type='text' size='3' style='text-align:center'>";
            html += "</td>";
            html += "<td><span style='color:white'>%</span></td>";
          html += "</tr>";

          html += "<tr>";
            html += "<td></td>";
            html += "<td>";
             html += "<div id='bckGndlm' style='width:auto;'>&nbsp;</div>";
            html += "</td>";
          html += "</tr>";

        html += "</table>";
      html += "</td>";

    html += "</tr>";
  html += "</table>";


  return html;
};


getHTMLColorTemp = function() {
  var html = "";


  html += "<table class='center'>";
    html += "<tr>";

      html += "<td id='trSliderPanel' class='_hidden'>";
        html += "<table id='sliderPanel' class='ControlBtnOff' style='width: 250px; margin-left: 5px;'>";
          html += "<tr>";
              html += "<td class='CLASS02546' style='text-align:right'>";
                html += "<div class='_PercBtn' style='height:35px; line-height:35px; width:100px; display:inline-block;'>";
                  html += "<input id='infoSliderPos' type='text' value='0' size='3' class='CLASS02542' style='margin-top: 6px; text-align:center' disabled/>&nbsp;${lblKelvin}";
                html += "</div>";
            html += "</td>";
          html += "</tr>";

          html += "<tr>";
            html += "<td colspan='2'>";
              html += "<div id='slider' class='ControlBtnInfo' style='width:220px;height:3px;min-height:unset'></div>";
            html += "</td>";
          html += "</tr>";
        html += "</table>";
      html += "</td>";
    html += "</tr>";
  html += "</table>";

  return html ;
};

getHTMLEffectName = function (curText) {
  var html = "";

  html += "<table class='center'>";
    html += "<tr>";
      html += "<td style='padding-right:10px;'>";
        html += "Name des Effekts: ";
      html += "</td>";
      html += "<td>";
        html += "<input type='text' id='effectName' class='alignCenter' size='15' maxlength='15' value="+curText+">";
      html += "</td>";
    html += "</tr>";
  html += "</table>"

  return html;
};

setEffectHueSat = function(elm, effectNo, subEffectNo) {
  var colorSelectElm = jQuery("#color_"+effectNo+"_" + subEffectNo),
    // 01_EFFECT_01_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE
    hueSatTempElm = jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first(),
    binHue, binSat;

  var dlg = new YesNoDialog("", getHTMLHueSatPicker(), function(result) {
    var binColor;

    if (result == 1) {
      colorSelectElm.css("background-color", this.CSS_COLOR_ELM);

      binHue = get8BitString(parseInt(this.HUE).toString(2));
      binSat = get8BitString(parseInt(this.SATURATION).toString(2));

      binColor = binHue + binSat;
      hueSatTempElm.val(parseInt(binColor,2));
    }
  }, "html");

  dlg.setWidth(450);
  dlg.run = function() {
    var self = this,
     hueElm = jQuery("#hueElm"),
     satElm = jQuery("#satElm"),
     bckGndElm = jQuery("#bckGndlm"),
     curHueSatTempVal = parseInt(jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first().val()), // 01_EFFECT_01_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE
     curHueSatTempBin = curHueSatTempVal.toString(2),
     curHueValBin, curSatValBin,
     valHUE, valSAT, valLevel;

    if (curHueSatTempBin == "0") {curHueSatTempBin = "0000000000000000";};

    curHueValBin = curHueSatTempBin.substr(0, curHueSatTempBin.length - 8);
    if (curHueValBin.length == 0) {curHueValBin = "0";}
    curSatValBin = curHueSatTempBin.slice(-8);

    valLevel = 100;
    valHUE = parseInt(curHueValBin,2);
    valSAT = (parseInt(curSatValBin,2) / 2);

    this.HUE = valHUE;
    this.SATURATION = parseInt(valSAT * 2);

    var effectColorPicker = new iro.ColorPicker("#effectColorPicker", {
      // Set the size of the color picker
      width: 90,
      color: {h: valHUE, s: valSAT, v: valLevel},
      wheelLightness: false, // If set to false, the color wheel will not fade to black when the lightness decreases.
      layout: [{component: iro.ui.Wheel}], // don't show the V slider below the wheel - this value has an own parameter
      handleRadius: 4
    });

    effectColorPicker.on("mount", function(color) {
      var rgbVal = hsvToRgb(valHUE, valSAT, 100);
      hueElm.val(valHUE); satElm.val(valSAT);
      bckGndElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
      self.CSS_COLOR_ELM = bckGndElm.css("background-color");
    });

    effectColorPicker.on("input:end", function(color) {
      var hsv_H = color.hsv.h,
        hsv_S = parseInt(color.hsv.s),
        rgbVal;

      hueElm.val(hsv_H);
      self.HUE = hsv_H;

      satElm.val(hsv_S);
      self.SATURATION = parseInt(hsv_S * 2);

      rgbVal = hsvToRgb(color.hsv.h, color.hsv.s, 100);
      bckGndElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
      self.CSS_COLOR_ELM = bckGndElm.css("background-color");
    });

    // User input HUE
    hueElm.keyup(function(event) {
      var val, HUE, rgbVal;
      if (event.keyCode == 13) {
        val = parseInt(jQuery(this).val());
        if (val < 0 || isNaN(val)) {HUE = 0;} else if (val >= 360) {HUE = 359;} else {HUE = val;};
        jQuery(this).val(HUE);
        self.HUE = HUE;
        effectColorPicker.color.hsv = {h: parseInt(HUE), s: parseInt(self.SATURATION / 2), v: 100};
        rgbVal = hsvToRgb(effectColorPicker.color.hsv.h, parseInt(self.SATURATION / 2), 100);
        bckGndElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
        self.CSS_COLOR_ELM = bckGndElm.css("background-color");
      }
    });

    hueElm.blur(function(event) {
      var val, HUE, rgbVal;
      val = parseInt(jQuery(this).val());
      if (val < 0 || isNaN(val)) {HUE = 0;} else if (val >= 360) {HUE = 359;} else {HUE = val;};
      jQuery(this).val(HUE);
      self.HUE = HUE;
      effectColorPicker.color.hsv = {h: parseInt(HUE), s: parseInt(self.SATURATION / 2), v: 100};
      rgbVal = hsvToRgb(effectColorPicker.color.hsv.h, parseInt(self.SATURATION / 2), 100);
      bckGndElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
      self.CSS_COLOR_ELM = bckGndElm.css("background-color");
    });

    // User input SATURATION
    satElm.keyup(function(event) {
      var val, SATURATION, rgbVal;
      if (event.keyCode == 13) {
        val = parseInt(jQuery(this).val());
        if (val < 0 || isNaN(val)) {SATURATION = 0;} else if (val >= 100) {SATURATION = 100;} else {SATURATION = val;};
        jQuery(this).val(SATURATION);
        self.SATURATION = parseInt(SATURATION * 2);

        effectColorPicker.color.hsv = {h: parseInt(self.HUE), s: parseInt(SATURATION), v: 100};
        rgbVal = hsvToRgb(effectColorPicker.color.hsv.h, parseInt(SATURATION), 100);
        bckGndElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
        self.CSS_COLOR_ELM = bckGndElm.css("background-color");
      }
    });

    satElm.blur(function(event) {
      var val, SATURATION, rgbVal;
        val = parseInt(jQuery(this).val());
        if (val < 0 || isNaN(val)) {SATURATION = 0;} else if (val >= 100) {SATURATION = 100;} else {SATURATION = val;};
        jQuery(this).val(SATURATION);
        self.SATURATION = parseInt(SATURATION * 2);

        effectColorPicker.color.hsv = {h: parseInt(self.HUE), s: parseInt(SATURATION), v: 100};
        rgbVal = hsvToRgb(effectColorPicker.color.hsv.h, parseInt(SATURATION), 100);
        bckGndElm.css("background-color", "rgb("+rgbVal.r+","+rgbVal.g+","+rgbVal.b+")");
        self.CSS_COLOR_ELM = bckGndElm.css("background-color");
    });

  };
  dlg.effectNo = effectNo;
  dlg.subEffectNo = subEffectNo;
  dlg.run();
  dlg.resetHeight();
};

initSatColorTemp = function() {
  var effectNo, subEffectNo, curType, curVal, curHueSatTempBin, curHueValBin, curSatValBin, valHUE, valSAT, rgbVal;

  for (var loopx = 1; loopx <= 10; loopx++) {
    for (var loopy = 1; loopy <= 8; loopy++) {
      effectNo = addLeadingZero(loopx);
      subEffectNo = addLeadingZero(loopy);
      curType = parseInt(jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_TYPE']").first().val());
      curVal = parseInt(jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first().val());

      curHueSatTempBin = curVal.toString(2);
      if (curHueSatTempBin == "0") {curHueSatTempBin = "0000000000000000";};

      curHueValBin = curHueSatTempBin.substr(0, curHueSatTempBin.length - 8);
      if (curHueValBin.length == 0) {curHueValBin = "0";}
      curSatValBin = curHueSatTempBin.slice(-8);
      valHUE = parseInt(curHueValBin,2);
      valSAT = (parseInt(curSatValBin,2) / 2);

      rgbVal = hsvToRgb(valHUE, valSAT, 100);
      if (curType == 1) {
        jQuery("#color_" + effectNo + "_" + subEffectNo).css("background-color", "rgb(" + rgbVal.r + "," + rgbVal.g + "," + rgbVal.b + ")");
      } else {
        jQuery("#color_" + effectNo + "_" + subEffectNo).css("background-color", "rgb(255,255,255)");
      }
    }
  }
};

setEffectColorTemp = function(elm, effectNo, subEffectNo) {

  var dlg = new YesNoDialog("", getHTMLColorTemp(), function(result) {

    var colorSelectElm = jQuery("#color_"+effectNo+"_" + subEffectNo),
      // 01_EFFECT_01_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE
      hueSatTempElm = jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first();

    if (result == 1) {
      colorSelectElm.css("background-color", this.CSS_COLOR_ELM);
      hueSatTempElm.val(this.COLOR_TEMP);
      jQuery("#color_" + effectNo + "_" + subEffectNo).text((parseInt(this.COLOR_TEMP) * 50) + " K");
    }
  }, "html");

  dlg.run = function() {
    var self = this;
      anchorSlider = jQuery("#slider"),
      infoSliderPos = jQuery("#infoSliderPos"),
      sliderOpts = {},
      curTempVal = parseInt(jQuery("[name='"+effectNo+"_EFFECT_"+subEffectNo+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first().val()), // 01_EFFECT_01_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE
      valTemp = parseInt(curTempVal * 50);

    this.COLOR_TEMP = valTemp;

    infoSliderPos.val(valTemp);

    sliderOpts.animate = 'fast';

    sliderOpts.min = 1000;
    sliderOpts.max = 10000;

    sliderOpts.value = valTemp;
    sliderOpts.step = 50;
    sliderOpts.orientation = 'horizontal';

    var sliderElm = jQuery(anchorSlider).slider(sliderOpts);

    sliderElm.on("slide", function (event, ui) {
      var sliderVal = parseInt(ui.value);
      infoSliderPos.val(sliderVal);
      self.COLOR_TEMP = parseInt(sliderVal / 50);
    });

    sliderElm.on("slidestop", function(event, ui) {
      var sliderVal = parseInt(ui.value);
      infoSliderPos.val(sliderVal);
      self.COLOR_TEMP = parseInt(sliderVal / 50);
    });
  };
  dlg.run();

};

initColorTemp = function () {
  var curTempVal, valTemp;
  for (var loopx = 1; loopx <= 10; loopx++) {
    for (var loopy = 1; loopy <= 8; loopy++) {
      if (parseInt(jQuery("[name='"+addLeadingZero(loopx)+"_EFFECT_"+addLeadingZero(loopy)+"_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_TYPE']").first().val()) == 2) {
        curTempVal = parseInt(jQuery("[name='" + addLeadingZero(loopx) + "_EFFECT_" + addLeadingZero(loopy) + "_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE']").first().val());
        valTemp = parseInt(curTempVal * 50);
        jQuery("#color_" + addLeadingZero(loopx) + "_" + addLeadingZero(loopy)).text(valTemp + " K");
      }
    }
  }
};

getEffectName = function (effectNr, devAddress) {
  var oDevice = DeviceList.getDeviceByAddress(devAddress),
    effectName = homematic("Interface.getMetadata", {"objectId": oDevice.id, "dataId": "effectName_" + effectNr}); // null when not available

  if ((effectName == "null") || (effectName == "")) {
    effectName = translateKey("lblEffect") + " " + effectNr;
  }

  return effectName;
};

setEffectName = function(elm, effectNr, devAddress) {
  var oDevice = DeviceList.getDeviceByAddress(devAddress);

  var dlg = new YesNoDialog("", getHTMLEffectName("'" + elm.innerText + "'"), function(result) {
    if (result == 1) {
      jQuery(elm).text(this.effectName);
      arNewEffectName.push(effectNr + "," + this.effectName);
    } else {
      delete arNewEffectName;
    }
  }, "html");

  dlg.close = function (result) {
    this.effectName = jQuery("#effectName").val();
    Layer.remove(this.m_layer);
    if (this.m_callback) { this.m_callback(result); }
  };

};

storeEffectName = function(devAddress) {
  var oDevice = DeviceList.getDeviceByAddress(devAddress);
  jQuery.each(arNewEffectName, function(index, value) {
    var arValue = value.split(",");
    homematic("Interface.setMetadata", {"objectId": oDevice.id , "dataId" : "effectName_" + arValue[0], "value": arValue[1]});
  });
  delete arNewEffectName;
};