self.displayCustom = function (elem) {
  var mode = ($(elem.id).checked == 1) ? "hide" : "show";
  $$(".j_custom").invoke(mode);
};

isLowerGTUpper = function(elmName, type) {
  var lowerElement, upperElement;
  switch (type) {
    case "channel" : 
      lowerElement = document.getElementsByName('tmp_WATER_LOWER_THRESHOLD_CH')[0];
      upperElement = document.getElementsByName('tmp_WATER_UPPER_THRESHOLD_CH')[0];
      break;

    case "linkSender" : 
      lowerElement = document.getElementsByName('tmp_FILL_LEVEL_LOWER_THRESHOLD')[0];
      upperElement = document.getElementsByName('tmp_FILL_LEVEL_UPPER_THRESHOLD')[0];
      break;
  }

  var lowerValue = parseFloat(lowerElement.value);
  var upperValue = parseFloat(upperElement.value);
  var hasLowerElementChanged = elmName.indexOf("LOWER_THRESHOLD");
   
  if (hasLowerElementChanged != -1) {
    //Die untere Schwelle wurde geändert
    if (lowerValue >= upperValue) {
    //die untere Schwelle ist groesser oder gleich als die obere Schwelle
      if (!upperElement.disabled) {  
        upperElement.value = lowerValue + 5.0;
        upperElement.onchange();
      }
    }
  } else {
    //Die obere Schwelle wurde geändert
    if (upperValue <= lowerValue) {
      // Die obere Schwelle ist kleiner oder gleich als die untere Schwelle
      if (!lowerElement.disabled) {
        lowerElement.value = upperValue - 5.0;
        lowerElement.onchange();
      }
    }
    //Der untere Wert ist < 0
    if (parseFloat(lowerElement.value) < 0) {
      lowerElement.value = '0.0';
      if (!upperElement.disabled) {  
        upperElement.value = '5.0';
        upperElement.onchange();
      }
    }

    //Der obere Wert ist > 100
    if (parseFloat(upperElement.value) > 100) {
      upperElement.value = '100.0';
      if (!lowerElement.disabled) {
        lowerElement.value = '95.0';
        lowerElement.onchange();
      }
    }
  }
};

setVal = function(tmpElm, type) {
  var elmID; 
  
  switch (type) {
    case "channel" : 
      elmID = tmpElm.id.replace(/tmp/,"separate_CHANNEL");
      break;
    case "linkSender" : 
      elmID = tmpElm.id.replace(/tmp/,"separate_sender");
      break;
    case "linkReceiver" : 
      elmID = tmpElm.id.replace(/tmp_separate/,"separate_receiver");
      break;
  }

  if (tmpElm.value > 100) {tmpElm.value = 100;}
  if (tmpElm.value < 0) {tmpElm.value = 0;}
  
  if (type != "linkReceiver") {
    //Falls die untere Schwelle groesser als die obere Schwelle und umgekehrt.....
    isLowerGTUpper(tmpElm.name, type);
  }
  var convertedValue = (2 * parseFloat(tmpElm.value));
  if (isNaN(convertedValue)) {convertedValue = 0; tmpElm.value = 0;}
  document.getElementById(elmID).value = convertedValue.toFixed(0);
};

// Je nach Gehäuseform dürfen nur bestimmte Parameter sichtbar sein.
// This doesn�t work with IE10 therefore this function was rewritten
_caseHasChanged = function(elm) {

  var lblFillingLevel = translateKey('lblFillingLevel100');
  var addOn = "&nbsp;("+ lblFillingLevel+ "%)";

  var hasAddOn = document.getElementById("caseHeight").innerHTML.search(lblFillingLevel);

  var caseHeightElem;
  if (hasAddOn == -1) {
    document.getElementById("caseHeight").innerHTML += addOn;
  }

  $$('[name="CASE_HIGH"]')[0].value = "300";

  switch (elm.selectedIndex) {
    case 0:
      $$(".j_caseLength, .j_caseFilllevel").invoke("hide");
      document.getElementById("caseHeightMinMaxA").style.display = "none";
      document.getElementById("caseHeightMinMaxB").style.display = "inline";
      break;
    case 1:
      caseHeightElem = document.getElementById("caseHeight"); 
      // Den String '(Füllstand bei 100%)' entfernen.
      caseHeightElem.innerHTML = caseHeightElem.innerHTML.replace(addOn, "");
      document.getElementById("caseHeightMinMaxA").style.display = "inline";
      document.getElementById("caseHeightMinMaxB").style.display = "none";
      $$(".j_caseLength").invoke("hide");
      $$(".j_caseFilllevel").invoke("show");
      break;
    case 2:
      document.getElementById("caseHeightMinMaxA").style.display = "none";
      document.getElementById("caseHeightMinMaxB").style.display = "inline";
      $$(".j_caseFilllevel").invoke("hide");
      $$(".j_caseLength").invoke("show");
      break;
  }

};

caseHasChanged = function(elm) {
  conInfo("Case has changed....");
  var addOn = "&nbsp;(F&uuml;llstand bei 100%)";
  //var hasAddOn = document.getElementById("caseHeight").innerHTML.search(/F\u00FCllstand bei 100/);
  var hasAddOn = jQuery("#caseHeight").html().search(/F\u00FCllstand bei 100/);
  var caseHeightElem;

  if (hasAddOn == -1) {
    //document.getElementById("caseHeight").innerHTML += addOn;
    var html = jQuery("#caseHeight").html();
    jQuery("#caseHeight").html(html + addOn);
  }

  jQuery('[name="CASE_HIGH"]').first().val("300");

  switch (elm.selectedIndex) {
    case 0:
      jQuery(".j_caseLength, .j_caseFilllevel").hide();
      jQuery("#caseHeightMinMaxA").css("display","none");
      jQuery("#caseHeightMinMaxB").css("display","inline");
      break;
    case 1:
      caseHeightElem = jQuery("#caseHeight");
      // Den String '(F�llstand bei 100%)' entfernen.
      caseHeightElem.html( caseHeightElem.html().replace(/\u0028F\u00FCllstand bei 100%\u0029/, "") );
      jQuery("#caseHeightMinMaxA").css("display", "inline");
      jQuery("#caseHeightMinMaxB").css("display","none");
      jQuery(".j_caseLength").hide();
      jQuery(".j_caseFilllevel").show();
      break;
    case 2:
      jQuery("#caseHeightMinMaxA").css("display","none");
      jQuery("#caseHeightMinMaxB").css("display","inline");
      jQuery(".j_caseFilllevel").hide();
      jQuery(".j_caseLength").show();
      break;
  }

};

ProofValue = function(elmID, min, caseSelectorID, deviceMaxValue) {
  
  var isValModified = (document.getElementById("caseHeightMinMaxA").style.display == "none") ? true : false ;
  var elm = $(elmID);
  var max, value; 
  var valLength = elm.value.length;

  if (isValModified && (elm.name != "MEA_LENGTH")) {
    max = 300;  
  } else {
    max = deviceMaxValue;
  }
  
  // Die Werte dürfen nur in 10cm Schritten eingegeben werden.
  if (valLength == 3) {
    value = (elm.value / 10).toFixed(0) * 10;
    elm.value = (value <= max) ? value : max;
  } 
  ProofAndSetValue(elmID, elmID, min, max, 1);
};

showHelpElem = function(mode) {
  if (!mode || (mode != "hide")) {
    $("caseHelp").show();
    document.getElementById("caseHelp").scrollIntoView();
  }
};


setThresholdActiv = function(checkBox,parentID, elemID, origVal, type) {
 var valueElem = document.getElementById(elemID),
 parentElem = document.getElementById(parentID),
 checked = $(checkBox.id).checked ;

 if (!checked) {
  valueElem.value = "255";
  parentElem.disabled = true;
 } else {
  valueElem.value = origVal;
  parentElem.disabled = false;
  setVal(parentElem, type);
 }
};
