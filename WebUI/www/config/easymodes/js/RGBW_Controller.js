activateColorPickerMinMax = function(curValue, elm, showWhite) {
  this.arElmID = elm.id.split("_");
  this.strColorElm = elm;
  this.strColorActiveElm = jQuery("#" + "borderColorActive_" + this.arElmID[1]+"_"+this.arElmID[2]+"_"+this.arElmID[3]);
  this.curValue = curValue;
  this.showWhite = showWhite;
  this.pickerState;
  this.maxValue = (showWhite) ? 201 : 200;

  curRGBWColor = new Array();

  for (var x = 1; x <= 6; x++) {
    curRGBWColor[x] = new Object();
    curRGBWColor[x]["receiver"] = - 1;
    curRGBWColor[x]["receivergroup"] = - 1;
  }

  this.strColorActiveElm.change(function(e){
    var colorElmID =  "#"  + this.id.replace(/borderColorActive/,"separate");
    var arElmID = colorElmID.split("_");
    var prn = parseInt(arElmID[2]);
    var pref = parseInt(arElmID[3]);
    var colorElmShort = jQuery(arElmID[0] + "_" + arElmID[1] + "_" + prn + "_" + pref);
    var colorElmLong = jQuery(arElmID[0] + "_" + arElmID[1] + "_" + prn + "_" + (pref + 2));
    var curColor = curRGBWColor[pref][arElmID[1]];

    if (curColor == -1 && parseInt(jQuery(colorElmShort).val()) != 255)  {
      curRGBWColor[pref][arElmID[1]] = jQuery(colorElmShort).val();
    }
    if (jQuery(this).prop("checked")) {
      jQuery(colorElmID).spectrum("enable");
         // Checkbox MinColor selected
        colorElmShort.val(curColor);
        colorElmLong.val(curColor);
        jQuery(colorElmShort).spectrum("set", "hsv("+parseInt(curColor / 199 * 360)+",100%,100%)");
        //jQuery(colorElmLong).spectrum("set", "hsv("+curColor+",100%,100%)");
    } else {
      jQuery(colorElmID).spectrum("disable");
      colorElmShort.val(255);
      colorElmLong.val(255);
    }
  });

  if (this.curValue >= this.maxValue) {
    jQuery(this.strColorActiveElm).prop("checked", false);
  } else {
    jQuery(this.strColorActiveElm).prop("checked", true);
  }
  pickerState = (this.curValue >= this.maxValue) ? true : false;

  var saturation = "100%";
  var hsvVal = parseInt(this.curValue / 199 * 360);

  // White is active
  if (this.showWhite && this.curValue == 200) {
    saturation = "0%";
    hsvVal = 0;
  }

  var palette = (this.showWhite) ? ['white'] : [];

  jQuery(this.strColorElm).val(this.curValue);

  jQuery(this.strColorElm).spectrum({
    preferredFormat: "convert360To200",
    showInput: false,
    color: "hsv(" + hsvVal + "," + saturation + ",100%)",
    showPalette: true,
    disabled: pickerState,
    palette: palette,
    cancelText: translateKey("btnCancel"),
    chooseText: translateKey("btnOk")
  });
};

setValueLONG = function(specialID, prn, pref) {
  var source = jQuery("#separate_" + specialID + "_" + prn + "_" + pref);
  var target = jQuery("#separate_" + specialID + "_" + prn + "_" + parseInt(pref + 2));
  target.val(source.val());
};