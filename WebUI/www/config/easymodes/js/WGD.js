
highlightActiveScreens = function() {
  var arlblScreen = jQuery("[name='lblScreen']"),
    cssBold = "bold";

  jQuery.each(arlblScreen, function (index, lbl) {
    if (lbl.innerText != "|") {
      jQuery(lbl).css("font-weight", cssBold);
    } else {
      cssBold = cssBold = "normal";
    }
  });
};

// This sets the current position of the screens.
setInitialScreenValues = function(devAddress) {
  var arScreenElements = jQuery("[name='sortScreen']"),
    device = DeviceList.getDeviceByAddress(devAddress),
    screenOrder = homematic("Interface.getMetadata", {"objectId": device.id, "dataId": "screenOrder"}); // Retrieve the screen order

    // This shouldn't be happen. The screenOrder will be stored while teach in. So this is only a fallback.
    if (screenOrder == "null") {
      if (device.typeName == "HmIPW-WGD") {
        screenOrder = "0,1,2,3,4,END";
      } else if (device.typeName == "HmIPW-WGD-PL") {
        screenOrder = "0,1,2,3,4,5,6,7,8,9,END";
      }
    }

    var arScreenOrder = screenOrder.split(","),
    cssBold = "font-weight: bold";

  // When screenOrder is not set, we use the default which is 1, 2, 3, ...., END
  if (screenOrder != "null") {
    jQuery.each(arScreenOrder, function (index, screen) {
      if (screen != "END") {
        jQuery(arScreenElements[index]).html("<span name='lblScreen' style='"+cssBold+"'>"+ translateKey('lblScreen') + "<br/>" + (parseInt(screen) + 1) + "</span>").attr("value", screen);
      } else {
        cssBold = "";
        //jQuery(arScreenElements[index]).html("<span name='lblScreen' style='"+cssBold+"'>" + screen + "</span>").attr("value", screen);
          jQuery(arScreenElements[index]).html("<span name='lblScreen' style='background-color:red; color:red;"+cssBold+"'>|</span>").attr("value", screen);

      }
    });
  }
  showOnlyActiveChannels(screenOrder);
};

getRelevantCh = function(screen) {
  var activeTiles, result,
    nrOfrelevantCh = (screen < 5) ? 7 : 1,
    screenID = screen + 1,
    indexA = [1,3,7], // Key channels - 3 tile variations = 2, 4 or 8 visible channels.
    indexB = [0,1]; // Climate channels - only 2 tile variations = 1 or 2 visible channels

  activeTiles = parseInt(jQuery("[name='SCREEN_LAYOUT_TILE_LAYOUT_"+screenID+"']").first().val());

  if (screenID <= 5) {
    result = indexA[activeTiles];
  } else {
    result = indexB[activeTiles];
  }

  return parseInt(result);
};

showOnlyActiveChannels = function(screenOrder) {
  var arScreenOrder = screenOrder.split(","),
    profileTableCells = jQuery(".ProfileTbl"),
    screenChannels = (arScreenOrder.length < 10) ? {0:1, 1:9, 2:17, 3:25, 4:33} : {0:1, 1:9, 2:17, 3:25, 4:33, 5:42, 6:44, 7:46, 8: 48, 9:50},
    nrOfrelevantCh,
    nomoreScreens = false,
    loop;

  // Hide the config params of all channels except 0 and 41
  jQuery.each(profileTableCells, function(index,channelParam) {
    if ((index != 0) && (index != 41)) { // Maintenance and Quick Motion always visible
      jQuery(channelParam).parent().parent().hide();
    }
  });

  jQuery.each(arScreenOrder, function(index, screen) {
    if ((screen != "END") && (! nomoreScreens)) {
      screen = parseInt(screen);
      nrOfrelevantCh = getRelevantCh(screen);

      for (loop = screenChannels[screen]; loop <= (screenChannels[screen] + nrOfrelevantCh); loop++) {
        jQuery(profileTableCells[loop]).parent().parent().show();
      }
    } else {nomoreScreens = true;}
  });

};

// Stores the selected position of all screens
storeSelectedScreenOrder = function(devAddress) {
  var device = DeviceList.getDeviceByAddress(devAddress),
    screenOrder = "";

  var arScreenElements = jQuery("[name='sortScreen']");
  jQuery.each(arScreenElements, function (index, elm) {
    screenOrder+=jQuery(elm).attr("value") + ","
  });

  screenOrder = screenOrder.slice(0, -1); // remove the last comma

  // Store the screen order
  var x = homematic("Interface.setMetadata", {"objectId": device.id, "dataId": "screenOrder", "value": screenOrder});
};

createSortable = function(numberOfScreens, devAddress) {

  setInitialScreenValues(devAddress);

  jQuery('#dragScreen').sortable(
    {
     containment: 'parent',
      opacity: 0.5,
      axis: 'x',
      stop: function(event, ui) {
        var arScreenElements = jQuery("[name='sortScreen']"),
          value, scrIndex, arValues = [], numberOfScreens;

        highlightActiveScreens();

        jQuery.each(arScreenElements, function (index, elm) {
          arValues.push(jQuery(elm).attr("value"));
        });
        numberOfScreens = jQuery.inArray("END", arValues);

        jQuery.each(arValues, function (index, val) {
          scrIndex = (val != "END") ? (parseInt(val) + 1) : 99;

          if (scrIndex != 99 && (index < numberOfScreens)) {
            jQuery("[name='SCREEN_LAYOUT_PAGE_NUMBER_" + scrIndex+ "']").first().val(index);
            if (index == 0) {
              jQuery("[name='SCREEN_LAYOUT_LEFT_NEIGHBOUR_" + scrIndex + "']").first().val("15");
            } else {
              jQuery("[name='SCREEN_LAYOUT_LEFT_NEIGHBOUR_" + scrIndex + "']").first().val(arValues[(index - 1)]);
            }
            jQuery("[name='SCREEN_LAYOUT_RIGHT_NEIGHBOUR_" + scrIndex + "']").first().val((arValues[(index + 1)] != "END") ? arValues[(index + 1)] : arValues[index]);

          } else {
            if (scrIndex != 99) {
              jQuery("[name='SCREEN_LAYOUT_PAGE_NUMBER_" + scrIndex + "']").first().val("0");
              jQuery("[name='SCREEN_LAYOUT_LEFT_NEIGHBOUR_" + scrIndex + "']").first().val("0");
              jQuery("[name='SCREEN_LAYOUT_RIGHT_NEIGHBOUR_" + scrIndex + "']").first().val("0");
            }
          }
        });
      }
    }
  );
};

