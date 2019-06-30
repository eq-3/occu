/**
 * If a wall mounted thermostat is available within the group show 3 weekly programs, otherwise show only one - the active - program.
 */
checkWallMountedThermostat = function(groupSN) {
  conInfo("checkWallMountedThermostat");
  //conInfo("groupSN: " + groupSN);
  var url = "/pages/jpages/group/assignedGroupMembers?sid="+SessionId;
  var request = jQuery.ajax({
    url: url,
    type:  "POST",
    async: true,
    cache: false,
    data: JSON.stringify({groupSN: groupSN}),
    dataType: "json"
  });

  request.done(function( result ) {
    var programSel = "[name='wallMountedTherm']",
      allowedTypes = ["HM-TC-IT-WM-W-EU"],
      showAllPrograms = false;

    jQuery.each(result, function(index, device){
      conInfo("Type: " + device.type);
      jQuery.each(allowedTypes, function(index, val) {
        if (device.type == val) {
          showAllPrograms = true;
          return false; // leave jQuery.each...
        }
      });
      if (showAllPrograms) {
        jQuery(programSel).show();
        return false; // leave jQuery.each...
      }
    });
  });

  request.fail(function( jqXHR, textStatus ) {
    conInfo(url + ".failed: " + jqXHR.statusText);
    //callback(textStatus);
  });
};
