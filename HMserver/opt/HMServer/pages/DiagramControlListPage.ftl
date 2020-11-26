<html>
<head>
<style>
.StdButtonBig {
  padding-right: 12px;
  padding-left: 12px;
}
.hideAtStart {
  visibility:hidden;
}
#legendTooltip {
  color:#192C6E;
  position:absolute;
  top:-14px;
  right:-5px;
  font-weight:bold;
}

</style>

<script language="text/javascript">
  var selectedDiagramId,
  noDiagramData = true,
  refreshDiagramOnRefreshTimeout,
  lastDiagramSettingsAsJson,
  showComparisonPeriod = false,
  comparisonLegendExtension = "",
  timePeriod = "unknown",
  defaultPeriod = undefined,
  origXAxis = {},
  diagramRenderer = undefined,
  barRenderer = false,
  selectedPeriod = -1, // -1 = unknown, 0 = hour, 1 = day, 2 = week, 3 = month, 4 = year
  arPeriod = ["hour", "24h", "week", "month", "year"],
  arTicks = ["10 minutes", "60 minutes", "1440 minutes", "2880 minutes", "52560 minutes"],   // 0 = hour, 1 = day, 2 = week, 3 = month, 4 = year
  numberOfDataSets = 1,
  diagramElem = jQuery('#currentDiagram'),
  btnPeriodDay = jQuery('#selectPeriodLastDay'),
  btnPeriodWeek = jQuery('#selectPeriodLastWeek'),
  btnPeriodMonth = jQuery('#selectPeriodLastMonth'),
  btnPeriodYear = jQuery('#selectPeriodLastYear'),
  btnComparisonPeriod = jQuery('#showComparisonPeriod'),
  selBoxComparisonDevice = jQuery('#selectDeviceForComparisonPeriod'),
  lblNoDataAvailable = jQuery("#hintNoDataAvailable"),
  consolidationElem = jQuery('#selectConsolidationFunction'),
  debug = jQuery.url().param('debug'),
  createDummy = jQuery.url().param('createDummy'),
  curDate = new Date(),
  comparisonSelectedDevice = 0,
  numberOfDevices = 1,
  consolidationMode = 0;

  function initSite() {
    jQuery('#contentRight').css('visibility','hidden');
    setPath("<span onclick='WebUI.enter(ControlPage);'>"+translateKey('menuControlPage')+"</span> &gt; "+ translateKey('submenuDiagramListPage'));
    var s = "";
    s += "<table cellspacing='8'>";
    s += "<tr>";
    s += "<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.goBack();'>"+ translateKey('footerBtnPageBack') +"</div></td>";    
    s += "</tr>";
    s += "</table>";
    setFooter(s);
    translateButtons("diagramPeriodLastHour, diagramPeriodLastDay, diagramPeriodLastWeek, diagramPeriodLastMonth, diagramPeriodLastYear, btnDiagramRepaint, btnDiagramExport, btnDiagramResetDiagramZoom, btnDiagramShowComparisonPeriod");
    translatePage("#${TableId}");
    jQuery("#${TableId}").show();
  }

  function storeOrigXAxisTimePeriod(min, max) {
    origXAxis.min = min;
    origXAxis.max = max;
  }

  function getComparisonOptions() {
    return {
      label: translateKey("diagramComparisonPeriod") + ": " + translateKey(comparisonLegendExtension),
      lineWidth: 1,
      rendererOptions: {smooth: true},
      showMarker: false
    };
  }

  function getComparisonColor(deviceColor) {
    /* Currently not in use
    var compColor = {
      "#FF0000" : "#1E1E1E", // Rot
      "#00FF00" : "#2D2D2D", // Grün
      "#0000FF" : "#3D3D3D", // Blau
      "#FFFF00" : "#4C4D4C", // Gelb
      "#FF00FF" : "#5B5B5B", // Magenta
      "#00FFFF" : "#6B6B6B", // Zyan
      "#FF9900" : "#7A7A7A", // Orange
      "#9999FF" : "#898989", // Schieferblau
      "#339966" : "#999999", // Meeresgrün
      "#993366" : "#A3A3A3", // Violet
      "#33CCD2" : "#ADADAD", // Türkis
      "#FFCC99" : "#B7B7B7", // Weizen
      "#666699" : "#C1C1C1", // Dunkles Schieferblau
      "#FF8080" : "#CCCCCC", // Lachsrosa
    }
    return compColor[deviceColor];
    */
    return "#7A7A7A";
  }

  function getSelectedDeviceForComparison() {
    return comparisonSelectedDevice;
  }

  function getBarGraphXAxis(period) {
    // period > 0 = hour, 1 = today, 2 = this week, 3 = this month, 4 = this year
    var d = curDate;
    var result = {};
    switch (arPeriod[period]) {
       case 0:
        // Todo default
        // hour not used
        break;
      case "24h":
        var date = parseInt(d.getMonth() + 1) + "-" +d.getDate() + "-" + d.getFullYear()+" ";
        result.min = date + "00:00";
        result.max = date + "24:00";
        result.tickInterval = "1 hours";
        result.timeFormatString = "%H:%M";
        comparisonLegendExtension = "diagramComparisonYesterday";
        break;
      case "week":
        result.min = parseInt(d.getMonth() + 1) + "-" +((d.getDate()-(d.getDay()-1)))+"-"+d.getFullYear()+ " 0:00";
        result.max = parseInt(d.getMonth() + 1) + "-" +((d.getDate()-(d.getDay()-1))+6)+"-"+d.getFullYear()+ " 24:00";
        result.tickInterval = "1 day";
        result.timeFormatString = "%d.%m.%y";
        comparisonLegendExtension = "diagramComparisonLastWeek";
        break;
      case "month":
         result.min = parseInt(d.getMonth() + 1) + "-1-" + d.getFullYear()+" 00:00";
        result.max = parseInt(d.getMonth() + 1) + "-30-" + d.getFullYear()+" 24:00";
        result.tickInterval = "1 day";
        result.timeFormatString = "%d.%m.%y";
        comparisonLegendExtension = "diagramComparisonLastMonth";
        break;
      case "year":
        result.min = "1-1-" + d.getFullYear()+" 00:00";
        result.max = "12-31-" + d.getFullYear()+" 24:00";
        result.tickInterval = "1 month";
        result.timeFormatString = "%m.%y";
        comparisonLegendExtension = "diagramComparisonLastYear";
        break;
    }
    return result;
  };

  // Mode = int 1 - 3
  function setButtonText(mode) {
    var strippedPeriod = [
      translateKey("diagramPeriodToday"),
      translateKey("diagramPeriodThisWeek"),
      translateKey("diagramPeriodThisMonth"),
      translateKey("diagramPeriodThisYear")
    ],
    fullPeriod = [
      translateKey("diagramPeriodLastDay"),
      translateKey("diagramPeriodLastWeek"),
      translateKey("diagramPeriodLastMonth"),
      translateKey("diagramPeriodLastYear")
    ];
    var result;
    if (mode == 3 || mode == 4) {
      // Power consumption and User defined
      result = jQuery.merge([], fullPeriod);
    } else {
      // Temperature and Power
      result = jQuery.merge([], strippedPeriod);
    }
    btnPeriodDay.val(result[0]);
    btnPeriodWeek.val(result[1]);
    btnPeriodMonth.val(result[2]);
    btnPeriodYear.val(result[3]);
  };

  function getConsolitation() {
   return consolidationMode;
  };

  function setRenderer(id) {
    if (id == 3) {
      diagramRenderer = jQuery.jqplot.BarRenderer;
      barRenderer = true;
    } else {
      diagramRenderer = undefined;
      barRenderer = false;
    }
  };

  function getBarWidth() {
    return null; // The with of the bars will be calculated automatically

    var viewPortWidth = jQuery(window).width();
    var factor = (showComparisonPeriod == false) ? 80 : 160;
    var singleBarWidth = parseInt(viewPortWidth / factor);
    return parseInt(singleBarWidth / (numberOfDataSets + 2));
  };

  function getNumberOfData(valToCheck, sizeOfData) {
    var numberOfData = 0;
    if (sizeOfData >= valToCheck) {
      numberOfData = valToCheck;
    } else {numberOfData = sizeOfData;}
    return numberOfData;
  };

  function getMinMaxValue(data, sMode) {
    var value = 0;
    var result = 0;
    var numberOfData = 0;
    var sizeOfData; // = data.size() - 1;
    var date = curDate;
    var periodSelector;
    var arValues = [];
    switch (arPeriod[selectedPeriod]) {
      case "24h" :
        periodSelector = date.getHours();
        break;
      case "week" :
        var weekDay = date.getDay();
        //periodSelector = (weekDay==0) ? 6 : weekDay; // Su = 6, Mo = 1, Di = 2 .....
        periodSelector = 6;
        break;
      case "month" :
        periodSelector = date.getDate();
        break;
      case "year" :
       periodSelector = date.getMonth() + 1;
        break;
      default:
        periodSelector = 0;
        value = 1000;
        break;
    }

    jQuery.each(data, function(index, valueSet) {
      arValues = valueSet;
      sizeOfData = arValues.size() - 1;
      numberOfData = getNumberOfData(periodSelector, sizeOfData);
      for (var x = (sizeOfData - numberOfData); x <= sizeOfData; x++) {
          //conInfo(x + " - " + data[x]);
          result = arValues[x];
          if (sMode == "max") {
            if (result > value) {
              value = result;
            }
          } else if(sMode == "min") {
            if (result < value) {
              value = result;
            }
          }
        }
      });
      if (sMode == "max") {value = value + (value * 0.1) ;}
      if (sMode == "min") {value = value - (value * 0.1) ;}

      return value;
  };

  function y2k(number) { return (number < 1000) ? number + 1900 : number; };

  function getWeekNumber(year,month,day) {
      var when = new Date(year,month,day);
      var newYear = new Date(y2k(year),0,1);
      var modDay = newYear.getDay();
      if (modDay == 0) modDay=6; else modDay--;
      var daynum = ((Date.UTC(y2k(year),when.getMonth(),when.getDate(),0,0,0) -
                   Date.UTC(y2k(year),0,1,0,0,0)) /1000/60/60/24) + 1;

      if (modDay < 4 ) {
          var weeknum = Math.floor((daynum+modDay-1)/7)+1;
      }
      else {
          var weeknum = Math.floor((daynum+modDay-1)/7);
          if (weeknum == 0) {
              year--;
              var prevNewYear = new Date(year,0,1);
              var prevmodDay = prevNewYear.getDay();
              if (prevmodDay == 0) prevmodDay = 6; else prevmodDay--;
              if (prevmodDay < 4) weeknum = 53; else weeknum = 52;
          }
      }
      return + weeknum;
  };

  // Returns the hour of the diagram data timestamp
  function getHour(timeStamp) {
    var tmp = timeStamp.split(" ");
    var PM = timeStamp.indexOf("PM");
    var result =  tmp[1].split(":")[0]; // hour of the timestamp

    // This is necessary for the IE (at least version 8)
    // This amazing browser interprets a 'parseInt("01")' as 0 instead of 1;
    result = parseInt(result, 10);

    if (PM != -1 && result != 12) {
      result+=12;
    }
    // 12:00AM = 0:00AM
    if (PM == -1 && result == 12) {
      result-=12;
    }
    return result;
  };

  // Returns the day of the diagram data timestamp
  function getDayOfTheWeek(timeStamp) {
    var oStampDate = getStampDateObject(timeStamp);
    var date = new Date(oStampDate.year, oStampDate.month - 1, oStampDate.day);
    if (date.getDay() == 0) {return 6;} // Sunday
    return (date.getDay() - 1);
  };

  function getDayOfTheMonth(timeStamp) {
    var oStampDate = getStampDateObject(timeStamp);
    return oStampDate.day - 1;
  };

  function getMonthOfTheYear(timeStamp) {
    var oStampDate = getStampDateObject(timeStamp);
    return oStampDate.month - 1;
  };

  function getStampDateObject(timeStamp) {
    var result = {};
    var stampDate = timeStamp.split(" ");
    var arStampDate = stampDate[0].split("-");

    // IMPORTANT use parseInt with radix 10. Otherwise some browser (e.g. IE8) will not work properly.
    // Without the radix the IE8 will return 0 instead of 8 with 'parseInt("08")'
    result.day = parseInt(arStampDate[2], 10);
    result.month = parseInt(arStampDate[1], 10);
    result.year = parseInt(arStampDate[0], 10);
    return result;
  };

  // Checks if it is todays timestamp
  function isValidDay(timeStamp, bComparisonPeriod) {
    var oStampDate = getStampDateObject(timeStamp);
    var date = curDate;
    var dateYesterday = new Date();
    if (!bComparisonPeriod) {
      if ((date.getDate() == oStampDate.day) && (parseInt(date.getMonth() + 1) == oStampDate.month) && (date.getFullYear() == oStampDate.year)) return true;
    } else {
        dateYesterday.setDate(date.getDate() - 1); // yesterday
        if (((parseInt(dateYesterday.getDate())) == parseInt(oStampDate.day)) && (parseInt(dateYesterday.getMonth() + 1) == oStampDate.month) && (dateYesterday.getFullYear() == oStampDate.year)) return true;
    }
    return false;
  };

  function isValidWeek(timeStamp, bComparisonPeriod) {
    var oStampDate = getStampDateObject(timeStamp);
    var date = curDate;
    var dateLastWeek = new Date();
    var curWeek = getWeekNumber(date.getYear(), date.getMonth(), date.getDate()); // the current week number
    var weekOfTimeStamp = getWeekNumber(oStampDate.year, oStampDate.month - 1, oStampDate.day); // the week number of the timestamp

    if (!bComparisonPeriod) {
      if (curWeek == weekOfTimeStamp) return true;
    } else {
      dateLastWeek.setDate(date.getDate() - 7); // last week
      var lastWeek = getWeekNumber(dateLastWeek.getYear(), dateLastWeek.getMonth(), dateLastWeek.getDate()); // the week number of last week
      if (parseInt(lastWeek) == parseInt(weekOfTimeStamp)){return true;}
    }
    return false;
  };

  function isValidMonth(timeStamp, bComparisonPeriod) {
    var oStampDate = getStampDateObject(timeStamp);
    var date = curDate;
    var dateLastMonth = new Date();
    if (!bComparisonPeriod) {
      if (oStampDate.month == (parseInt(date.getMonth()) + 1)) return true;
    } else {
      dateLastMonth.setMonth(date.getMonth() - 1);
      if ((parseInt(oStampDate.month) - 1) == parseInt(dateLastMonth.getMonth())) return true;
    }
    return false;
  };

  function isValidYear(timeStamp, bComparisonPeriod) {
    var oStampDate = getStampDateObject(timeStamp);
    var date = curDate;
    if (!bComparisonPeriod) {
      if (oStampDate.year == date.getFullYear()) return true;
    } else {
      if (parseInt(oStampDate.year) == (date.getFullYear() - 1)) return true;
    }
    return false;
  };

  function isValidDataSet(timeStamp, bComparison) {
    var result = false;
    switch (arPeriod[selectedPeriod]) {
      case "24h":
        result = isValidDay(timeStamp, bComparison);
        break;
      case "week":
        result = isValidWeek(timeStamp, bComparison);
        break;
      case "month":
        result = isValidMonth(timeStamp, bComparison);
        break;
     case "year":
        result = isValidYear(timeStamp, bComparison);
        break;
    }
    return result;
  };

  function getIndexOfDataSet(timeStamp) {
    var result;
    switch (arPeriod[selectedPeriod]) {
      case "24h":
        result = getHour(timeStamp);
        break;
      case "week":
        result = getDayOfTheWeek(timeStamp);
        break;
      case "month":
        result = getDayOfTheMonth(timeStamp);
        break;
      case "year":
        result = getMonthOfTheYear(timeStamp);
        break;
    }
    return result;
  };

  // Converts the data for the use of the CategoryAxisRenderer instead of the DateAxisRenderer
  function stripDiagramData(data) {
    var result = [];
    var tmp,timeStamp, value;
    jQuery.each(data,function(index, valueSet) {
      tmp = [];
      // Begin at the end of the values and leave the for-loop when there are no more appropriate valuesets.
      for (var x = valueSet.size() - 1; x >= 0; x--) {
        timeStamp = valueSet[x][0];
        if(isValidDataSet(timeStamp, false)) {
          value = valueSet[x][1];
          tmp[getIndexOfDataSet(timeStamp)] = value;
        } else {
          break;
        }
      }
      result.push(tmp);
    });
    return result;
  };

  function getCompareData(data) {
    var tmpData = [];
    jQuery.extend(true, tmpData, data);
    var result = [];
    var tmp,timeStamp, value;

    // Delete all entries of the current period - e. g. today or this week
    jQuery.each(data,function(index, valueSet) {
      if (valueSet) {
        // Checks if this is the current period, e. g. today or this week
        // If it´s true then delete this entry
        timeStamp = valueSet[0];
        if(isValidDataSet(timeStamp, false)) {
          // remove the value from the end of the dataset
          tmpData.splice(-1,1);
        }
      }
    });
    // Now the dataset contains all values without the current period

    // Take all data of the previous period
    jQuery.each(tmpData, function(index, valueSet) {
      tmp = [];
      timeStamp = valueSet[0];
      // Check if the dataset contains the data of the previous period - e. g. yesterday or last week
      if (isValidDataSet(timeStamp, true)) {
       value = valueSet[1];
       tmp[getIndexOfDataSet(timeStamp)] = value;
       result[getIndexOfDataSet(timeStamp)] = value;
      }
    });
    // Now the dataset contains all values of the previous period
    return result;
  }

  function getNumberOfDaysInMonth(month, fullYear) {
    return 32 - new Date(fullYear, month, 32).getDate();
  };

  function getTickInterval() {
    return arTicks[selectedPeriod];
  };

  function getBarGraphRenderOptions() {
    return {
      "barWidth" : getBarWidth(),
      "highlightMouseOver" : false,
      "waterfall" : false,
      "fillToZero" : true,
      "shadow" : false,
    };
  };

  function getBarGraphTicks() {
    var arTicks = [];
    switch (arPeriod[selectedPeriod]) {
      case "24h":
        for(x = 0; x < 24; x++) {
          arTicks.push(x.toString());
        }
        break;
      case "week":
        var arWeekDays = [
          translateKey("Mon"),
          translateKey("Tue"),
          translateKey("Wed"),
          translateKey("Thu"),
          translateKey("Fri"),
          translateKey("Sat"),
          translateKey("Sun")
          ];
        for(x = 0; x < 7; x++) {
          arTicks.push(arWeekDays[x]);
        }
        break;
      case "month":
        for (x = 1; x <= getNumberOfDaysInMonth(curDate.getMonth(), curDate.getFullYear()); x++) {
          arTicks.push(x.toString());
        }
        break;
      case "year":
        var arMonth = [
        translateKey("Jan"),
        translateKey("Feb"),
        translateKey("Mar"),
        translateKey("Apr"),
        translateKey("May"),
        translateKey("Jun"),
        translateKey("Jul"),
        translateKey("Aug"),
        translateKey("Sep"),
        translateKey("Oct"),
        translateKey("Nov"),
        translateKey("Dec")
        ];
        for (x = 0; x <= 11; x++) {
          arTicks.push(arMonth[x]);
        }
        break;
    }
    return arTicks;
  }

  function resetAllBtn() {
    jQuery(".jPeriodButton").css("color","#000000");
  }

  function setSelectedBtn(mode) {
    var arMode = ["Hour","Day","Week","Month","Year"];
    resetAllBtn();
    jQuery("#selectPeriodLast"+arMode[mode]).css("color","green");
  };

  function setTimeSelectors() {
    jElemsDate = jQuery("#selectPeriodStartDate, #selectPeriodEndDate");
    jElemsTime = jQuery("#selectPeriodStartTime, #selectPeriodEndTime");

    if (consolidationMode == 3) {
      jElemsDate.attr("readonly", true);
      jElemsTime.attr("readonly", true);
      jQuery(".datepicker").datepicker("disable");
      jQuery(".timepicker").timepicker("disable");
    } else {
      jElemsDate.attr("readonly", false);
      jElemsTime.attr("readonly", false);
      jQuery(".datepicker").datepicker("enable");
      jQuery(".timepicker").timepicker("enable");
    }
  };

  function initGui() {
    jQuery(window).unbind('resize');
    jQuery(window).resize(function() {
      clearTimeout(refreshDiagramOnRefreshTimeout);
      refreshDiagramOnRefreshTimeout = setTimeout(doneResizing, 250);
    });

    setTimeSelectors();

    jQuery("#selectConsolidationFunction").change(function() {
      consolidationMode = this.value;
      setTimeSelectors();
      setRenderer(this.value);
      refreshDiagram();
    });

    jQuery("#selectPeriodLastHour").click(function() {
      defaultPeriod = 0;
      timePeriod = arPeriod[defaultPeriod];
      showPeriod(defaultPeriod);
      refreshDiagram();
    });

    jQuery("#showCustomModeHelp").click(function() {
      showCustomModeHelp();
    });

    btnPeriodDay.click(function() {
      defaultPeriod = 1;
      timePeriod = arPeriod[defaultPeriod];
      showPeriod(defaultPeriod);
      refreshDiagram();
    });
      
    btnPeriodWeek.click(function() {
      defaultPeriod = 2;
      timePeriod = arPeriod[defaultPeriod];
      showPeriod(defaultPeriod);
      refreshDiagram();
    });
    
    btnPeriodMonth.click(function() {
      defaultPeriod = 3;
      timePeriod = arPeriod[defaultPeriod];
      showPeriod(defaultPeriod);
      refreshDiagram();
    });
    
    btnPeriodYear.click(function() {
      defaultPeriod = 4;
      timePeriod = arPeriod[defaultPeriod];
      showPeriod(defaultPeriod);
      refreshDiagram();
    });
    
    jQuery("#selectPeriodDo").click(function() {
      refreshDiagram();
    });
    
    jQuery("#exportPeriodDo").click(function() {
      exportDiagram();
    });
    
    jQuery("#resetDiagramZoom").click(function() {
      resetDiagramZoom();
    });

    btnComparisonPeriod.click(function() {

      if (!noDiagramData) {
        comparisonSelectedDevice = 0;
        showComparisonPeriod = (showComparisonPeriod == true) ? false : true;
        (showComparisonPeriod == true && (numberOfDevices > 1)) ? selBoxComparisonDevice.show() : selBoxComparisonDevice.hide();
        ShowDiagram(lastDiagramSettingsAsJson);
      }
    });

    selBoxComparisonDevice.change(function() {
       comparisonSelectedDevice = this.value;
       showComparisonPeriod = true;
       ShowDiagram(lastDiagramSettingsAsJson);
    });

    // Only for testing
    jQuery("#toggleRenderer").click(function() {
      if (diagramRenderer == undefined) {
        diagramRenderer = jQuery.jqplot.BarRenderer;
      } else {
        diagramRenderer = undefined;
      }
      refreshDiagram();
    });
    var legendTooltipText = jQuery('#legendTooltipText').text();
    jQuery('#legendTooltip').attr('title', legendTooltipText);
    initPicker();
  };
  
  function doneResizing(){
    if (lastDiagramSettingsAsJson != undefined) {
       ShowDiagram(lastDiagramSettingsAsJson);
    }
  }
  
  function initPicker() {
    var langDatePicker = {
      monthNames: [
        translateKey('timeModuleSelectSerialPatternJan'),
        translateKey('timeModuleSelectSerialPatternFeb'),
        translateKey('timeModuleSelectSerialPatternMar'),
        translateKey('timeModuleSelectSerialPatternApr'),
        translateKey('timeModuleSelectSerialPatternMay'),
        translateKey('timeModuleSelectSerialPatternJun'),
        translateKey('timeModuleSelectSerialPatternJul'),
        translateKey('timeModuleSelectSerialPatternAug'),
        translateKey('timeModuleSelectSerialPatternSep'),
        translateKey('timeModuleSelectSerialPatternOct'),
        translateKey('timeModuleSelectSerialPatternNov'),
        translateKey('timeModuleSelectSerialPatternDec')
        ],
      dayNames: [
        translateKey('timeModuleLblSelSerialPatternSunday'),
        translateKey('timeModuleLblSelSerialPatternMonday'),,
        translateKey('timeModuleLblSelSerialPatternTuesday'),
        translateKey('timeModuleLblSelSerialPatternWednesday'),
        translateKey('timeModuleLblSelSerialPatternThursday'),
        translateKey('timeModuleLblSelSerialPatternFriday'),
        translateKey('timeModuleLblSelSerialPatternSaturday')
        ],
      dayNamesMin: [
        translateKey('Sun'),
        translateKey('Mon'),
        translateKey('Tue'),
        translateKey('Wed'),
        translateKey('Thu'),
        translateKey('Fre'),
        translateKey('Sat')
        ],
      firstDay: 1,
      isRTL: false
    };
    jQuery.datepicker.setDefaults(langDatePicker);
    
    jQuery(".datepicker").datepicker({
      dateFormat: 'dd.mm.yy',
      showButtonPanel: true,
      closeText: translateKey("btnOk")
    });
    
    jQuery(".timepicker").timepicker({
      showAnim: 'blind',
      hourText: translateKey('Hou'),
      minuteText: translateKey('Min'),
      amPmText: ['AM', 'PM'],
      showCloseButton: true,
      closeButtonText: translateKey("btnOk")
    });
  }
  
  showPeriod = function(periodChoice) {
    var offset1 = (barRenderer) ? 2 : 1;
    var offset2 = (barRenderer) ? 14 : 7;
    selectedPeriod = parseInt(periodChoice);

    var start;
    switch (selectedPeriod) {
    // last hour
    //case 0:
      //start = new Date(new Date().setHours(new Date().getHours() - offset1));
      //break;
    // last day
    case 0:
    case 1:
      //start = new Date(new Date().setDate(new Date().getDate() - 1));
      start = new Date(new Date().setDate(new Date().getDate() - offset1));
      break;
    // last week
    case 2:
      //start = new Date(new Date().setDate(new Date().getDate() - 7));
      start = new Date(new Date().setDate(new Date().getDate() - offset2));
      break;
      
    // last month
    case 3:
      //start = new Date(new Date().setMonth(new Date().getMonth() - 1));
      start = new Date(new Date().setMonth(new Date().getMonth() - offset1));
      break;
      
    // last year
    case 4:
      //start = new Date(new Date().setFullYear(new Date().getFullYear() - 1));
      start = new Date(new Date().setFullYear(new Date().getFullYear() - offset1));
      break;
    }

    if (barRenderer) {
      jQuery("#tdCustomModeHelp").hide();
      jQuery(".j_barGraphMode").show();
    } else {
      jQuery("#tdCustomModeHelp").show();
      jQuery(".j_barGraphMode").hide();
      resetAllBtn();
    }
    setSelectedBtn(selectedPeriod);
    var end = curDate;
    showPeriodInGui(start, end);
  };
  
  showPeriodInGui = function(start, end) {
    jQuery('#selectPeriodStartDate').val(getFormattedDate(start));
    jQuery('#selectPeriodEndDate').val(getFormattedDate(end));
    jQuery('#selectPeriodStartTime').val(getFormattedTime(start));
    jQuery('#selectPeriodEndTime').val(getFormattedTime(end));
  };
  
  function getFormattedDate(date) {
    return manageLeadingZero(date.getDate(), 2) + '.' + manageLeadingZero((date.getMonth() + 1), 2) + '.' + manageLeadingZero(date.getFullYear(), 4);
  };
  
  function getFormattedTime(date) {
    return manageLeadingZero(date.getHours(), 2) + ':' + manageLeadingZero(date.getMinutes(), 2);
  };
  
  function manageLeadingZero(number, size) {  
    var result = number + "";
    while (result.length < size) {
      result = "0" + result;
    }
    
    return result;
  };
  
  triggerDiagram = function(diagramID) {
    if (!${initialized?string('true', 'false')}) {
      return;
    }
    showComparisonPeriod = false;
    selBoxComparisonDevice.hide();
    highlightSelectedDiagram(diagramID);
  
    selectedDiagramId = diagramID;
    triggerDiagramRefresh(selectedDiagramId, false);
  };

  triggerDiagramRefresh = function(diagramID, useCustomPeriod) {
    if (!${initialized?string('true', 'false')}) {
      return;
    }
    var url = '/pages/jpages/diagram/control/show?sid=' + SessionId + '&diagramid=' + diagramID + '&consolidationFunction=' + getConsolitation() + '&timePeriod=' + arPeriod[defaultPeriod];

    if (useCustomPeriod) {
      var customPeriodStart = jQuery('#selectPeriodStartDate').val() + '_' + jQuery('#selectPeriodStartTime').val();
      var customPeriodEnd = jQuery('#selectPeriodEndDate').val() + '_' + jQuery('#selectPeriodEndTime').val();
      url += '&start=' + customPeriodStart + '&end=' + customPeriodEnd;
    } else {
      appendDiagramSettings(diagramID);
    }

    if (!barRenderer) {
      showComparisonPeriod = false;
    }
    blockUI();
    var opt =
    {
      onComplete: function(t) {
        var response = JSON.parse(t.responseText);
        if(!response.isSuccessful)
        {
          if(response.errorCode == "42")
          {
            jQuery("#content").html(response.content);
          } else if(response.errorCode == "not_initialized")
          {
            var s = "<table id=\"dataloggingError\" class=\"tTable\" cellpadding=\"3\" cellspacing=\"3\"><tr><td class=\"CLASS21906\">";
            s += translateKey('diagramDataloggingNotInitialised');
            s += "</td></tr></table>";
            jQuery('#contentRight').html(s);
            jQuery('#contentRight').css('visibility','visible');
          } else{
            alert(response.content);
          }
        } else {
          lblNoDataAvailable.hide();
          noDiagramData = false;
          ShowDiagram([response.content]);
        }
        
        jQuery.unblockUI();
      },
      onException: function(t) {
        conInfo("Exception triggerDiagramRefresh!");
        lblNoDataAvailable.show();
        //Draw an empty chart
        diagramElem.empty();
        var options = {
          seriesDefaults: {
            renderer: jQuery.jqplot.BarRenderer
          },
          axesDefaults: {
            tickRenderer: jQuery.jqplot.CanvasAxisTickRenderer,
            tickOptions: {angle: 37}
          },
          axes: {
            xaxis: {
              renderer:jQuery.jqplot.CategoryAxisRenderer,
              ticks: getBarGraphTicks(),
            }
          }
        };
        noDiagramData = true;
        var lastPlotter = jQuery.jqplot('currentDiagram', [[null]], options );
        jQuery.unblockUI();
      }
    };
    setTimeout(function() {jQuery.unblockUI();}, 10000); // Fallback after 10000ms.....
    new Ajax.Request(url, opt);
  };

  refreshDiagram = function() {
    triggerDiagramRefresh(selectedDiagramId, true);
  };

  exportDiagram = function() {
    var url = '/pages/jpages/diagram/control/export?sid=' + SessionId + '&language=' + getLang() + '&diagramid=' + selectedDiagramId + '&consolidationFunction=' + getConsolitation();
    var customPeriodStart = jQuery('#selectPeriodStartDate').val() + '_' + jQuery('#selectPeriodStartTime').val();
    var customPeriodEnd = jQuery('#selectPeriodEndDate').val() + '_' + jQuery('#selectPeriodEndTime').val();    
    url += '&start=' + customPeriodStart + '&end=' + customPeriodEnd;
        window.open(url,'_blank');
  };


  function resetDiagramZoom() {
    if (window.lastPlotter != undefined) {
      window.lastPlotter.resetZoom();
    }
  };

  function hideCustomModeElements() {
    jQuery("[name='customMode']").hide();
  };

  function showCustomModeElements() {
    jQuery("[name='customMode']").show();
  };

  function ShowDiagram(diagramSettingsAsJson) {
    setTimeSelectors();
    // only show diagram and its options if data is available
    if (diagramSettingsAsJson) {
      jQuery('#contentRight').css('visibility','visible');
    } else {
      jQuery('#contentRight').css('visibility','hidden');
    }

    var diagramSettings = JSON.parse(diagramSettingsAsJson);
    storeOrigXAxisTimePeriod(diagramSettings.options.axes.xaxis.min, diagramSettings.options.axes.xaxis.max);

    var numberOfNecessaryDatapoints = (barRenderer == false) ? 2 : 1;
    // Show hint when no diagram data available
    // With the line diagram we need at least 2 datapoints, the bargraph diagram needs 1 datapoint
    jQuery.each(diagramSettings.diagram, function(index,diagram) {
      if (diagram.length < numberOfNecessaryDatapoints ) {
        lblNoDataAvailable.show();
        noDiagramData = true;
      }
    });

    // release memory and empty the chart if necessary
    if (window.lastPlotter != undefined) {
      window.lastPlotter.destroy();
    }

    // clear diagramm and initialize renderers
    diagramElem.empty();
    diagramSettings.options.axes.xaxis.renderer = jQuery.jqplot.DateAxisRenderer;
    diagramSettings.options.axesDefaults = { tickRenderer: jQuery.jqplot.CanvasAxisTickRenderer};
    diagramSettings.options.legend.renderer = jQuery.jqplot.EnhancedLegendRenderer;

    if (homematic('CCU.existsFile', {'file': "/etc/config/showDiagramDatapoints"})) {
      //AG Displays a tooltip at the datapoint of a line diagram
      diagramSettings.options.highlighter = {
        show: !barRenderer,
        sizeAdjust: 3,
        tooltipLocation: "sw",
        tooltipAxes: "piered",
        formatString: "<table><tr><td>%s</td></tr><tr><td style='text-align:center'>%.1f</td></tr></table>",
        fadeTooltip: true,
        tooltipFadeSpeed: "fast",
        useAxesFormatters: true
      };
    }

    // Hides the small tooltip in the right bottom edge of line graphs
    //diagramSettings.options.cursor.showTooltip = barRenderer;



    // do not allow zoom if no series has a value
    if (!hasOneSeriesAtLeastOneValue(diagramSettings.diagram)) {
      diagramSettings.options.cursor.zoom = false;
    }
    
    // disable reset diagram zoom button if zoom is not enabled
    if(diagramSettings.options.cursor.zoom == true) {
      jQuery("#resetDiagramZoom").show(); 
    } else {
      jQuery("#resetDiagramZoom").hide();
    }
    
    // set device name as series value
    for (var i = 0; i < diagramSettings.options.series.length; i++)
    {
      var oldLabel = diagramSettings.options.series[i].label;
      
      var label = GetChannelName(oldLabel.substring(0,oldLabel.indexOf('_'))) + " ";
      label += translateKey('diagramValueType' + oldLabel.split(" ")[1]);
      diagramSettings.options.series[i].label = label;
    }    
    
    // show chart even if no data is available for selected period (jqplot needs at least one value for plotting)
    if (diagramSettings.diagram.length == 0) {
      diagramSettings.diagram = [[null]];
    } else {
      for (var i = 0; i < diagramSettings.diagram.length; i++)
      {
        if(diagramSettings.diagram[i].length == 0) {
          diagramSettings.diagram[i] = [null];
        }
      }
    }
    
    // adjust diagramm width and height
    var isLegendOutsideOfDiagram = diagramSettings.options.legend.placement == "outside";
    adjustDiagramSize(diagramSettings.diagram.length, isLegendOutsideOfDiagram);
    
    // show single data point instead of empty chart if only one value for a series is available
    for (var i = 0; i < diagramSettings.diagram.length; i++) {
      diagramSettings.options.series[i].showMarker = diagramSettings.diagram.indexOf(i).length == 1;
    }

    // Only for debugging! Don´t forget to uncomment this. Otherwise you will experience massive problems with some MS browsers :-(
    // console.dir(diagramSettings);

    setButtonText(diagramSettings.type);
    // plot the diagram
    diagramSettings.options.seriesDefaults.renderer = diagramRenderer;

    if (homematic('CCU.existsFile', {'file': "/etc/config/showDiagramDatapoints"})) {
      // The default jqPlot marker renderer, rendering the points on the line.
      diagramSettings.options.seriesDefaults.markerRenderer = jQuery.jqplot.MarkerRenderer;
      diagramSettings.options.seriesDefaults.markerOptions = {
        show: true,
        size: 5,
        style: 'filledCircle', //circle, diamond, square - filledCirce, filledDiamond, filledSquare
        shadow: false,
        lineWidth: 1
      };
    }
    if (barRenderer) {
      selBoxComparisonDevice.html("");
      diagramSettings.options.cursor.barRendererToday = (timePeriod == "unknown" || timePeriod == "24h") ? true : false;

      if (createDummy) {
        // ************ DUMMY DEVICE ************
        // Creates a dummy device with nearly identical data
        var dummyDiagramData = [];
        jQuery.extend(true, dummyDiagramData, diagramSettings.diagram);
        jQuery.each(dummyDiagramData[0], function(index,value) {
          if (value[1]) {
            // Dummy data = original * 0.95 so it is somewhat different
            dummyDiagramData[0][index][1] = value[1] * 0.95 ;
          }
        });
        diagramSettings.diagram.push(dummyDiagramData[0]);
        jQuery.extend(true, dummyDiagramData, diagramSettings.options.series);
        diagramSettings.options.series.push(dummyDiagramData[0]);
        diagramSettings.options.series[1].label = "DummY Nr. 1";
        diagramSettings.options.seriesColors.push("#FFFF00");

        // ************ END DUMMY DEVICE ************

        /*
        // ************ DUMMY DEVICE ************
        // Creates a dummy device with nearly identical data
        var dummyDiagramData = [];
        jQuery.extend(true, dummyDiagramData, diagramSettings.diagram);
        jQuery.each(dummyDiagramData[0], function(index,value) {
          if (value[1]) {
            // Dummy data = original * 1.25 so it is somewhat different
            dummyDiagramData[0][index][1] = value[1] * 1.25 ;
          }
        });
        diagramSettings.diagram.push(dummyDiagramData[0]);
        jQuery.extend(true, dummyDiagramData, diagramSettings.options.series);
        diagramSettings.options.series.push(dummyDiagramData[0]);
        diagramSettings.options.series[2].label = "DummY Nr. 2";
        diagramSettings.options.seriesColors.push("#666699");
        // ************ END DUMMY DEVICE ************
        */
      }

      numberOfDevices = diagramSettings.diagram.length;

      jQuery.each(diagramSettings.options.series, function (index, item) {
          selBoxComparisonDevice.append(jQuery('<option>', {
              value: index,
              text : item.label
          }));
      });

      selBoxComparisonDevice.val(getSelectedDeviceForComparison());

      var origDiagramData = [];
      var comparisonOptions = [];
      var comparisonDiagram = [];

      jQuery.extend(true, origDiagramData, diagramSettings.diagram);

      numberOfDataSets = diagramSettings.diagram.size();
       hideCustomModeElements();
      diagramSettings.options.seriesDefaults.rendererOptions = getBarGraphRenderOptions();
      diagramSettings.options.axes.xaxis.tickInterval = getTickInterval();
      diagramSettings.options.axes.yaxis.tickOptions = {formatString: "%.2f"}; // %d is another option (without zoom)

      // The next 3 lines are changing the x-axis renderer
      diagramSettings.diagram = stripDiagramData(diagramSettings.diagram);
      diagramSettings.options.axes.xaxis.renderer = jQuery.jqplot.CategoryAxisRenderer;
      diagramSettings.options.axes.xaxis.ticks = getBarGraphTicks();

      // 1 = Temperature, 2 = Power, 3 = Consumption, 4 = User
      if (diagramSettings.type == 1 || diagramSettings.type == 2) {
        var xAxis = getBarGraphXAxis(defaultPeriod);
        diagramSettings.options.axes.xaxis.min = xAxis.min;
        diagramSettings.options.axes.xaxis.max = xAxis.max;
        diagramSettings.options.axes.xaxis.tickInterval = xAxis.tickInterval;
        diagramSettings.options.axes.xaxis.tickOptions.formatString = xAxis.timeFormatString;
        //diagramSettings.options.axes.xaxis.tickOptions.angle = 0;
      } else {
        diagramSettings.options.axes.xaxis.min = origXAxis.min;
        diagramSettings.options.axes.xaxis.max = origXAxis.max;
      }

      if (showComparisonPeriod)  {
        jQuery.extend(true, comparisonOptions, diagramSettings.options);

        // This will display only one device with its comparison data
        var selectedDevice = getSelectedDeviceForComparison();
        comparisonDiagram.push(diagramSettings.diagram[selectedDevice]);
        comparisonDiagram.push(getCompareData(origDiagramData[selectedDevice]));
        comparisonOptions.seriesColors[0] = diagramSettings.options.seriesColors[selectedDevice];
        comparisonOptions.seriesColors[1] = getComparisonColor(diagramSettings.options.seriesColors[selectedDevice]);

        comparisonOptions.series[0].label = diagramSettings.options.series[selectedDevice].label;
        comparisonOptions.series[1] = getComparisonOptions();
        comparisonOptions.series[1].label =  translateKey("diagramComparisonPeriod") + ": " + translateKey(comparisonLegendExtension);


        /*
        With this we can display all devices including the comparision data
        This will lead to a mayhem of bar graphs when more devices are involved.

        jQuery.each(origDiagramData, function(index, diagram) {
          comparisonDiagram.push(diagramSettings.diagram[index]);
          comparisonDiagram.push(getCompareData(origDiagramData[index]));
          comparisonOptions.seriesColors.splice((index * 2) + 1, 0, getComparisonColor(diagramSettings.options.seriesColors[index]));
          comparisonOptions.series.splice(index * 2 + 1, 0, (getComparisonOptions()));
        });
        */

        diagramSettings.options = comparisonOptions;
        diagramSettings.options.axes.yaxis.max = getMinMaxValue(comparisonDiagram, "max");

        // Min value of the y-Axis set to 'auto'
        if (!diagramSettings.options.axes.yaxis.customMin) {
          diagramSettings.options.axes.yaxis.min = getMinMaxValue(comparisonDiagram, "min");
        }
        // Max value of the y-Axis set to 'auto'
        if (!diagramSettings.options.axes.yaxis.customMax) {
          diagramSettings.options.axes.yaxis.max = getMinMaxValue(comparisonDiagram, "max");
        }
      } else {
        // Min value of the y-Axis set to 'auto'
        if (!diagramSettings.options.axes.yaxis.customMin) {
          diagramSettings.options.axes.yaxis.min = getMinMaxValue(diagramSettings.diagram, "min");
        }

        // Max value of the y-Axis set to 'auto'
        if (!diagramSettings.options.axes.yaxis.customMax) {
          diagramSettings.options.axes.yaxis.max = getMinMaxValue(diagramSettings.diagram, "max");
        }
      }
    } else {
      diagramSettings.options.axes.yaxis.tickOptions = {formatString: "%.1f"};
      showCustomModeElements();
    }
    // ATTENTION only for debugging - IE might crash when not in debugging mode (console available)
    if ((debug == "true") && (typeof console == "object")) {
      console.dir(diagramSettings);
    }

    if (showComparisonPeriod)  {
      lastPlotter = jQuery.jqplot('currentDiagram', comparisonDiagram, diagramSettings.options );
    } else {
      lastPlotter = jQuery.jqplot('currentDiagram', diagramSettings.diagram, diagramSettings.options );
    }
    lastDiagramSettingsAsJson = diagramSettingsAsJson;

    try {
      // add tooltip
      addLegendTooltip();
      jQuery.jqplot.postDrawHooks.push(addLegendTooltip);
    } catch (e) {
      // the tooltip doesn´t work with lte IE8
      jQuery("#legendTooltipText, #legendTooltip, #diagramPleaseWaitForLoadingNextDiagram").hide();
    }
  };

  function hasOneSeriesAtLeastOneValue(series) {
    for (var i = 0; i < series.length; i++) {      
      if (series[i].length > 0) {
        return true;
      }
    }
  
    return false;
  }
  
  function adjustDiagramSize(amountOfSeries, isLegendOutsideOfDiagram) {
    var minWidth = 400;
    var minHeight = 200;
  
    var offsetRight = 50; // correct displaying of all x axis labels
    var offsetTopDown = 370; // space for header, control elements and footer
    
    if (isLegendOutsideOfDiagram) {
      offsetTopDown += calculatePossibleLegendHeight(amountOfSeries);
    }
    
    var calculatedWidth = jQuery(window).width() - jQuery('#contentLeft').width() - offsetRight;
    var calculatedHeight = jQuery(window).height() - offsetTopDown;
    
    if (calculatedWidth < minWidth) {
      calculatedWidth = minWidth;
    }
    
    if (calculatedHeight < minHeight) {
      calculatedHeight = minHeight;
    }
    
    jQuery('#currentDiagram').width(calculatedWidth);
    jQuery('#currentDiagram').height(calculatedHeight);
  }
  
  function calculatePossibleLegendHeight(amountOfSeries) {
    var legendColumns = 4;
    var heightForEachRow = 42;
    
    var amountOfRowsInLegend = Math.ceil(amountOfSeries / legendColumns);
    return amountOfRowsInLegend * heightForEachRow;
  }
  
  function addLegendTooltip() {
    jQuery('#legendTooltip').css('visibility', 'visible');
    
    var tooltipDiv = jQuery('#legendTooltip').clone();    
    jQuery('.jqplot-table-legend:last').append(tooltipDiv);
  }

  function appendDiagramSettings(diagramID) {    
    var url = '/pages/jpages/diagram/control/settings?sid=' + SessionId + '&diagramid=' + diagramID;
    var opt =
    {
      onComplete: function(t) {
        var response = JSON.parse(t.responseText);
        if(!response.isSuccessful)
        {
          if(response.errorCode == "42")
          {
            jQuery("#content").html(response.content);
          } else {
            alert(response.content);
          }
        } else {
          var diagramSettings = JSON.parse(response.content);          
          parseDiagramSettings(diagramSettings);
        }
      }
    };
    
    new Ajax.Request(url, opt);
  };
  
  function parseDiagramSettings(diagramSettings) {
    var tmpDefaultPeriod = defaultPeriod,
    tmpConsolidationFunction = getConsolitation();
    setConsolidationFunction(diagramSettings.consolidationFunction);
    defaultPeriod = diagramSettings.defaultPeriod;
    setVisibilitySelectPeriod(diagramSettings.isOperable);
    showPeriod(defaultPeriod);
    if ((tmpDefaultPeriod != diagramSettings.defaultPeriod) || (tmpConsolidationFunction != diagramSettings.consolidationFunction)) {
      triggerDiagram(selectedDiagramId);
    }
  };
  
  function setVisibilitySelectPeriod(isVisible) {
    if (isVisible) {
      jQuery('#selectPeriod').show();
    } else {
      jQuery('#selectPeriod').hide();
    }
  };

  function setConsolidationFunction(consolidationFunction) {
    setRenderer(consolidationFunction);
    consolidationMode = consolidationFunction;
  };
  
  function highlightSelectedDiagram(diagramID) {
    jQuery('#diagrams td').removeClass('ButtonStatusRoomsSelected');
    jQuery('#diagram' + diagramID).addClass('ButtonStatusRoomsSelected');
    jQuery('#diagram' + diagramID).css('text-align', 'left');
  };
  
  function blockUI() {
    jQuery.blockUI({
      message: jQuery('#diagramPleaseWaitForLoadingNextDiagram').text()
    });
  }

  function showCustomModeHelp() {
    MessageBox.show(translateKey("diagramHelpCustomModeTitle"),
     translateKey("diagramHelpCustomModeContent")
    ,
    "",
    600,
    250
    );
  }

  GetChannelName = function(address) {
    var ch = DeviceList.getChannelByAddress(address);
    if (ch != undefined) {
      return ch.getName();
    } else {
      return address;
    }
  };

  (function () {
    initSite();
    
    if (!${initialized?string('true', 'false')}) {
    
      var s = "<table id=\"dataloggingError\" class=\"tTable\" cellpadding=\"3\" cellspacing=\"3\"><tr><td class=\"CLASS21906\">";
      s += translateKey('diagramDataloggingNotInitialised');
      s += "</td></tr></table>";
      jQuery('#contentRight').html(s);
      jQuery('#contentRight').css('visibility','visible');
      return;
    }
    
    initGui();
    
    var firstDiagram = ${firstDiagram};
    if (firstDiagram != -1) {
      triggerDiagram(firstDiagram);
    }
  })();
</script>
</head>
<body>
<table id="${TableId}" width="100%" class="CLASS03900" cellpadding="0" cellspacing="0">
  <tr>
    <td id="contentLeft">
    <div class="CLASS04002" style="height: 719px;">
      <table id="tblFunctionNames" class="CLASS03903" border="1" cellpadding="4" cellspacing="0" style="width:200px">
        <#list objectList as diagram>
          <tr id="diagrams">
            <td id='diagram${diagram.id}' class="ButtonStatusRooms CLASS03905" onclick="triggerDiagram(${diagram.id});">
              <table>
                <tr class='CLASS03904'>
                  <td style="font-weight:bold;">${diagram.name}</td></td>
                </tr>
                <tr>
                  <td>${diagram.description}</td>
                </tr>
              </table>
            </td>
          </tr>
        </#list>
      </table>
    </div>
   </td>
   
   <td id="contentRight" class="j_translate">
    <div id="selectPeriod">
      <table>
        <tr>
          <!--
          <td>
            <input type="button" value="diagramPeriodLastHour" name="diagramPeriodLastHour" id="selectPeriodLastHour" class="StdButtonBig jPeriodButton"/>
          </td>
          -->
          <td>
            <input type="button" value="diagramPeriodLastDay" name="diagramPeriodLastDay" id="selectPeriodLastDay" class="StdButtonBig jPeriodButton"/>
          </td>
          <td>
            <input type="button" value="diagramPeriodLastWeek" name="diagramPeriodLastWeek" id="selectPeriodLastWeek" class="StdButtonBig jPeriodButton"/>
          </td>
          <td>
            <input type="button" value="diagramPeriodLastMonth" name="diagramPeriodLastMonth" id="selectPeriodLastMonth" class="StdButtonBig jPeriodButton"/>
          </td>
          <td>
            <input type="button" value="diagramPeriodLastYear" name="diagramPeriodLastYear" id="selectPeriodLastYear" class="StdButtonBig jPeriodButton"/>
          </td>
        </tr>
      </table>
      <table name="customMode">
        <tr>
          <td>${"$"}{diagramPeriodCustomStart}</td>
          <td><input type="text" id="selectPeriodStartDate" class="datepicker"/></td>
          <td><input type="text" id="selectPeriodStartTime" class="timepicker"/></td>
          <td width="15px"></td>
          <td>${"$"}{diagramPeriodCustomEnd}</td>
          <td><input type="text" id="selectPeriodEndDate" class="datepicker"/></td>
          <td><input type="text" id="selectPeriodEndTime" class="timepicker"/></td>
        </tr>
      </table>
      <table>
        <tr>
          <td name="customMode">${"$"}{thDiagramSelectTempConsolidationFunction}</td>
          <td name="customMode">
            <select id="selectConsolidationFunction" size="1">
              <option value="0">${"$"}{diagramConsolidationFunctionAverage}</option>
              <option value="1">${"$"}{diagramConsolidationFunctionMinimum}</option>
              <option value="2">${"$"}{diagramConsolidationFunctionMaximum}</option>
            </select>
          </td>

          <td id="tdCustomModeHelp" class="CLASS01408 hidden">
            &nbsp;
            <img id="showCustomModeHelp" height="25" width="25" src="/ise/img/help.png">
          </td>

          <td>
            <input type="button" value="btnDiagramShowComparisonPeriod" name="btnDiagramShowComparisonPeriod" class="j_barGraphMode StdButtonBig hidden" id="showComparisonPeriod"/>
          </td>

          <td>
            <select class="hidden" id="selectDeviceForComparisonPeriod" />
          </td>

          <!-- for testing only -->
          <!--
          <td>
            <input type="button" value="ToggleRenderer" name="" class="StdButtonBig" id="toggleRenderer"/>
          </td>
          -->

        </tr>
      </table>
    </div>
    <table>
      <tr>
        <td>
          <input type="button" value="btnDiagramRepaint" name="btnDiagramRepaint" class="StdButtonBig" id="selectPeriodDo"/>
        </td>
        <td>
          <input type="button" value="btnDiagramResetZoom" name="btnDiagramResetDiagramZoom" class="StdButtonBig" id="resetDiagramZoom"/>
        </td>
        <td>
          <input type="button" value="btnDiagramExport" name="btnDiagramExport" class="StdButtonBig" id="exportPeriodDo"/>
        </td>
      </tr>
    </table>
    <div id='hintNoDataAvailable' class='hidden attention' style='text-align:center'><b>${'$'}{diagramNoDataAvailable}</b></div>
    <div id="currentDiagram" style="margin-left: 25px;"></div>
    
    <div id="legendTooltipText" class="hideAtStart">${"$"}{diagramLegendExplanationTooltip}</div>
    <div id="legendTooltip" class="hideAtStart">${"$"}{diagramLegendExplanationTeaser}</div>
    <div id="diagramPleaseWaitForLoadingNextDiagram" class="hideAtStart">${"$"}{diagramPleaseWaitForLoadingNextDiagram}</div>

   </td>
</table>
</body>
</html>