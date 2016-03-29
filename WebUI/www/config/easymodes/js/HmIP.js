
// This isn't in use and only for testing
// sTime e. g. '00:45:00'
HmIpTest = function(sTime) {
  if (sTime == undefined) {
    sTime = '00:45:00'; // for testing only
  }
  /* HmIP Zeitbasis 1h, 10m, 5m, 1m, 10s, 5s, 1s, 0.1s */
  //var arTimeBase = [3600,600,300,60,10,5,1,0.1];

  var arTimeBase = [0.1,1,5,10,60,300,600,3600];
  var timeInSeconds = convertTime2Seconds(sTime);

  jQuery.each(arTimeBase, function(index,val) {
    var tmpVal = timeInSeconds / val,
      result = parseInt(tmpVal),
      remainder = (tmpVal * 100) % 100; // Nachkommastellen

    //console.log("val: " + val + " - result: " + result + " - remainder: " + remainder);

  });
};

convertTime2Seconds = function(sTime) {
  var arTime = sTime.split(":");
  return (parseInt(arTime[0]) * 3600) + (parseInt(arTime[1]) * 60) + parseInt(arTime[2]);
};
