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
    sliderSize: 25, // height
    color: {h: hue, s: 100, v: 100},
    handleSvg: '#handle',
    layout: [
      {
        component: iro.ui.Slider,
        options: {
          sliderType: 'hue'
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


getColorTempSliderMinMax = function(prn, pref) {
  var anchorSlider = jQuery("#colorTempSliderMinMax_"+prn+"_"+pref),
    receiverAddress = jQuery("#global_receiver_address").val(),
    iface = jQuery("#global_iface").val(),
    sliderOpts = {},
    chnDescription = homematic("Interface.getParamset", {"interface":iface, "address": receiverAddress, "paramsetKey": "MASTER"}),
    val2SendElm = jQuery("#separate_receiver_"+prn+"_" + pref);

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
  });

  sliderElm.on("slidestop", function(event, ui) {
    var sliderVal = parseInt(ui.value);
    sliderElm.slider("value", sliderVal);
    val2SendElm.val(sliderVal);
  });

  val2SendElm.keyup(function(event) {
    var val, newVal;

    if (event.keyCode == 13) {
      val = parseInt(jQuery(this).val());
      if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
      jQuery(this).val(newVal);
      sliderElm.slider("value", parseInt(newVal));
    }
  });

  val2SendElm.blur(function(event) {
    var val, newVal;
    val = parseInt(jQuery(this).val());
    if (val < sliderOpts.min || isNaN(val)) {newVal = sliderOpts.min;} else if (val > sliderOpts.max) {newVal = sliderOpts.max;} else {newVal = val;}
    jQuery(this).val(newVal);
    sliderElm.slider("value", parseInt(newVal));
  });

};