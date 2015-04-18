incCounter = function() {
  $('counter').value++ ;
};

decCounter = function() {
  $('counter').value-- ;
};

addCounter = function(val) {
  var counter = $('counter');
  counter.value = parseInt(counter.value) + parseInt(val);
};

getMaxAllowedEntries = function() {
  return 36;
};

getCounter = function() {
  return $('counter').value ;
};

getAttentionText = function() {
  var maxEntries = getMaxAllowedEntries();
  var attentionTxt = translateKey("maxEntriesReached_a") + maxEntries + translateKey("maxEntriesReached_b") +
    translateKey("maxEntriesReached_c") + maxEntries + translateKey("maxEntriesReached_d");
  return attentionTxt;
};



/** 
* Set all checkboxes whose links contains the same sender and receiver
* and set by setValues() the values of the parameters
*/
setAppropriateCheckBoxes = function(elm, state, senderRF, receiverRF) {
  //var allCheckBoxes = document.getElementsByName(elm.name);
  var allCheckBoxes = document.getElementsByClassName(elm.name);
  var storeContainer;
  
  for (var loop = 0; loop < allCheckBoxes.length; loop++) {
    allCheckBoxes[loop].checked = state;
    if (!state) {
      resetBroadCast(elm);
    }
  } 
  storeContainer = allCheckBoxes[0].parentNode.nextSibling.nextSibling.childNodes;
  setValues(storeContainer, senderRF, receiverRF);  
};

/**
* Set the values of the corresponding parameter 
*/ 
setValues = function(storeContainer, senderRF, receiverRF) {
  var senderBYTES = convertAddress(senderRF),
  receiverBYTES = convertAddress(receiverRF);
  // To store the values in this manner is necessary thereby the 'isDirty' mechanism works properly
  // The following example doesn`t work
  // storeContainer[0].setAttribute("value", senderBYTES.HIGH);

  storeContainer[0].value = senderBYTES.HIGH; 
  storeContainer[1].value = senderBYTES.MID; 
  storeContainer[2].value = senderBYTES.LOW; 
  storeContainer[3].value = receiverBYTES.HIGH; 
  storeContainer[4].value = receiverBYTES.MID; 
  storeContainer[5].value = receiverBYTES.LOW; 
};

/**
* First the address will be converted from a RF-number like 912980 to "0DEAD0"
* Then this hex-value will be splitted in "0D" "EA" "D0"
* Then the 3 single values will converted back to decimal and assigned to the appropriate properties of the val object.
*/
convertAddress = function(address) {
  var val = {};
  if (address) {  
    var hAddress = parseInt(address).toString(16);
  
    // Fill up with leading zeros so we will get a hex value with 6 digits
    while (hAddress.length < 6) {
      hAddress = "0" + hAddress;
    }
    
    val.LOW = parseInt(hAddress.substring(4), 16).toString(); 
    val.LOW = (isNaN(val.LOW)) ? "0" : val.LOW.toString();
    val.MID = parseInt(hAddress.substring(2,4), 16).toString();
    val.MID = (isNaN(val.MID)) ? "0" : val.MID;
    val.HIGH = parseInt(hAddress.substring(0,2), 16);
    val.HIGH = (isNaN(val.HIGH)) ? "0" : val.HIGH.toString();
  } else {
    val.LOW = "0";
    val.MID = "0";
    val.HIGH = "0";
  }
  return val;
};

/**
* Returns the relevant storage container of a broadcast-only-device
*/
isRelevantStoreContainer = function(container, oValue) {
  var valueNodes = container.childNodes;
  
  if ((valueNodes[0].value == parseInt(oValue.HIGH)) && (valueNodes[1].value == oValue.MID) && (valueNodes[2].value == oValue.LOW)) {
    return true;
  }        
  return false;
};

/**
* Resets all broadcast values and broadcast checkboxes of the relevant links
* The parameter 'elm' has to be the repeater checkbox, not the broadcast checkbox
*/

resetBroadCast = function(elm) {
  var broadCastCheckBoxName = document.getElementsByName(elm.parentNode.nextSibling.childNodes[0].name)[0].name,
  allBroadCastCheckBoxes = document.getElementsByName(broadCastCheckBoxName),
  storeContainer = allBroadCastCheckBoxes[0].parentNode.nextSibling.childNodes;
  
  for (var loop = 0; loop < allBroadCastCheckBoxes.length; loop++) {
    allBroadCastCheckBoxes[loop].checked = false;
    storeContainer[6].value = "0";
  }
};

/**
* Sets the checkbox of a broadcast-only-device active / nonactive  
*/
setBroadcastOnlyCheckboxes = function() {
  var broadcastOnlyTbl = document.getElementById("broadcastOnlyTbl"), 
  //allStoreContainers = document.getElementsByName("broadcastOnlyContainer"),
  allStoreContainers = document.getElementsByClassName("j_broadcastOnlyContainer"),
  highAddress, midAddress, lowAddress, hexAddress, rfAddress = [];

  for (var loop = 0; loop < allStoreContainers.length; loop++) {
    highAddress = parseInt(allStoreContainers[loop].childNodes[0].value).toString(16);
    midAddress =  parseInt(allStoreContainers[loop].childNodes[1].value).toString(16);
    lowAddress =  parseInt(allStoreContainers[loop].childNodes[2].value).toString(16);
    
    hexAddress = highAddress + midAddress + lowAddress;
    rfAddress[loop] = parseInt("0x" + hexAddress);
  }
  
  var node = broadcastOnlyTbl.nextSibling;
  while (node != null) {
    var address = node.getAttribute("id");  
    
    for (var loop = 0; loop < rfAddress.length; loop++) {
      if (address == rfAddress[loop]) {
        node.childNodes[4].firstChild.checked = true;       
      }
    } 
    node = node.nextSibling;
  }
};

getDevicePeers = function(container) {
  var deviceIDs, senderID, receiverID,
  deviceIDs = container.parentNode.id.split("-");
    
  return {"senderID": deviceIDs[0], "receiverID": deviceIDs[1]};
};

setCheckBox = function(ps, type) {
  var allStoreContainers = [],
  repeatMode = {},
  devicePeers = {},
  container,
  containerClassName = "",
  inputElems = [],
  linkCheckBoxes = [],
  checkBox,
  senderBYTES, receiverBYTES;
   
  switch (type) {
    case "linksOnly": 
      containerClassName = "j_linkContainer";
      break;
    case "broadcastOnly":
      containerClassName = "j_broadcastOnlyContainer";
      break;
    case "deviceOnly":
      containerClassName = "j_deviceSystemContainer";
      break;
    default: alert("Repeater.js - Error 1: " + type + " not defined");
  }

  allStoreContainers = document.getElementsByClassName(containerClassName);
    
  for (var loop = 0; loop < allStoreContainers.length; loop++) {
    
    devicePeers = getDevicePeers(allStoreContainers[loop]);
    senderBYTES = convertAddress(devicePeers.senderID);
    receiverBYTES = convertAddress(devicePeers.receiverID);
     
    repeatMode = checkRepeatMode(ps, senderBYTES, receiverBYTES);
     
    switch (type) {
      case "linksOnly":
        linkCheckBoxes = document.getElementsByClassName('link-'+devicePeers.senderID + "_" + devicePeers.receiverID);
        break;
      case "broadcastOnly":
        checkBox = $("broadcast-" + devicePeers.senderID); // corresponding checkbox 
        break;
      case "deviceOnly": 
        checkBox = $('devSystem-'+devicePeers.senderID + "_" + devicePeers.receiverID); 
        break;
      default: alert("Repeater.js - Error 2: " + type + " not defined");
    }
    
    if (linkCheckBoxes.length > 0) {
      for (var loopx = 0; loopx < linkCheckBoxes.length; loopx++) {
        linkCheckBoxes[loopx].checked = repeatMode["mode"];
      }
    } else {
      checkBox.checked = repeatMode["mode"];
    }
    if (repeatMode["mode"]) {
      container= getFreeContainer(containerClassName);
      inputElems = container.childNodes;
      inputElems[0].value = senderBYTES.HIGH; 
      inputElems[1].value = senderBYTES.MID; 
      inputElems[2].value = senderBYTES.LOW;
      inputElems[3].value = receiverBYTES.HIGH;
      inputElems[4].value = receiverBYTES.MID;
      inputElems[5].value = receiverBYTES.LOW;
      
      if (type == "broadcastOnly") {
        inputElems[6].value = "1";
      }
      if (type == "linksOnly") {
        inputElems[6].value = repeatMode["broadcast"];
        var broadCastElements = document.getElementsByClassName(linkCheckBoxes[0].parentNode.nextSibling.firstChild.className);
        for (var loopx = 0; loopx < broadCastElements.length; loopx++) {
          broadCastElements[loopx].checked = repeatMode["broadcast"];   
        }
      }
      if (type == "deviceOnly") {
        inputElems[6].value = repeatMode["broadcast"];
        checkBox.parentNode.nextSibling.firstChild.checked = repeatMode["broadcast"];
      }

      incCounter();
    }
  }
};

/*
* Calculates the original RF-Address of the sender - receiver pair 
*/
restoreRFAddresses = function(oVal) {
 
  var hexSenderAddress = "000000";
  var hexReceiverAddress = "000000";

  var hSenderAddressHIGH = parseInt(oVal.senderHIGH).toString(16);
  hSenderAddressHIGH = (hSenderAddressHIGH.length == 1) ? "0" +  hSenderAddressHIGH : hSenderAddressHIGH;

  var hSenderAddressMID = parseInt(oVal.senderMID).toString(16); 
  hSenderAddressMID = (hSenderAddressMID.length == 1) ? "0" +  hSenderAddressMID : hSenderAddressMID;
  
  var hSenderAddressLOW = parseInt(oVal.senderLOW).toString(16); 
  hSenderAddressLOW = (hSenderAddressLOW.length == 1) ? "0" +  hSenderAddressHIGH : hSenderAddressLOW;

  hexSenderAddress = hSenderAddressHIGH + hSenderAddressMID + hSenderAddressLOW;
  
  var hReceiverAddressHIGH = parseInt(oVal.receiverHIGH).toString(16);
  hReceiverAddressHIGH = (hReceiverAddressHIGH.length == 1) ? "0" +  hReceiverAddressHIGH : hReceiverAddressHIGH;
 
  var hReceiverAddressMID = parseInt(oVal.receiverMID).toString(16);
  hReceiverAddressMID = (hReceiverAddressMID.length == 1) ? "0" +  hReceiverAddressMID : hReceiverAddressMID;
  
  var hReceiverAddressLOW = parseInt(oVal.receiverLOW).toString(16);
  hReceiverAddressLOW = (hReceiverAddressLOW.length == 1) ? "0" +  hReceiverAddressLOW : hReceiverAddressLOW;
  
  hexReceiverAddress = hReceiverAddressHIGH + hReceiverAddressMID + hReceiverAddressLOW;
   
  return {
    senderRF: parseInt(hexSenderAddress, 16),
    receiverRF: parseInt(hexReceiverAddress, 16)
  };

};

/**
* Sets all values of a given container to "0"
*/
resetStoreContainer = function(container) {
  for (var loop = 0; loop < container.length - 1; loop++) {
    container[loop].value = "0";
  }
  container[loop].value = "1";
};

// Gibt den nÃ¤chsten freien Container innerhalb des Ã¼bergebenen "StoreContainers" zurÃ¼ck
getFreeContainer = function(storeContainerName) {
  var allStoreContainers = document.getElementsByClassName(storeContainerName),
  inputElems,
  value;
  // Laufe durch jeden Container
  for (var loop = 0; loop < allStoreContainers.length; loop++) {
    value = 0;
    // alle Input Elemente
    inputElems = allStoreContainers[loop].getElementsByTagName('input');
    
    // Laufe durch alle Input Elemente und addiere deren Werte
    for (var loopy = 0; loopy < inputElems.length - 1; loopy++) {
      value += parseInt(inputElems[loopy].value);
    }
    // Wenn der Wert aller Input-Felder 0 ergibt, dann ist der Container frei
    // und kann genutzt werden.
    if (value == 0) {
      return allStoreContainers[loop];
    }
  }
};

// Gibt den ensprechenden Container der ab-selektierten Checkbox zurÃ¼ck
getAppropriateContainer = function(storeContainerName, senderRF, receiverRF) {
  var oSender = convertAddress(senderRF),
  oReceiver = convertAddress(receiverRF),
  aValues = [],
  inputElems,
  match,
  allStoreContainers = document.getElementsByClassName(storeContainerName);
  
  aValues[0] = parseInt(oSender.HIGH);
  aValues[1] = parseInt(oSender.MID);
  aValues[2] = parseInt(oSender.LOW);
  aValues[3] = parseInt(oReceiver.HIGH);
  aValues[4] = parseInt(oReceiver.MID);
  aValues[5] = parseInt(oReceiver.LOW);
   
  for (var loop = 0; loop < allStoreContainers.length; loop++) {
    match = false;
    // Alle Input- Elemente
    inputElems = allStoreContainers[loop].getElementsByTagName('input');
    
    // Laufe durch alle Input-Elemente
    for (var loopy = 0; loopy < (inputElems.length - 2); loopy++) {
      // PrÃ¼fe, ob die Input-Elemente mit den Sender- u. Receiveraddressen Ã¼bereinstimmen
      // Sollte ein Wert nicht passen, sofort weiter zum nÃ¤chsten Wert.
      if (parseInt(inputElems[loopy].value) == aValues[loopy]) {
        match = true;
      } else {
        match = false;
        break;
      }
    }
    if (match) { 
     // Alle Werte passten, daÃŸ dÃ¼rfte der passende Container mit den Input-Elementen sein.
     return allStoreContainers[loop]; 
    }
  }
  if (console) {
    console.log("Repeater.js - Error: this should never be called!");
  }
};

checkRepeatMode = function(ps, senderBYTES, receiverBYTES) {
  var mode = false,
  broadcast = false;
  loop = 1;

  for (val in ps) {
    //console.log(val + " - " + ps[val]);
    
    mode = ( parseInt(ps["ADDRESS_SENDER"+loop+"_HIGH_BYTE"]) == parseInt(senderBYTES.HIGH) ) ? true : false;
    if (mode) mode = ( parseInt(ps["ADDRESS_SENDER"+loop+"_MID_BYTE"]) == parseInt(senderBYTES.MID) ) ? true : false;
    if (mode) mode = ( parseInt(ps["ADDRESS_SENDER"+loop+"_LOW_BYTE"]) == parseInt(senderBYTES.LOW) ) ? true : false;
    if (mode) mode = ( parseInt(ps["ADDRESS_RECEIVER"+loop+"_HIGH_BYTE"]) == parseInt(receiverBYTES.HIGH) ) ? true : false;
    if (mode) mode = ( parseInt(ps["ADDRESS_RECEIVER"+loop+"_MID_BYTE"]) == parseInt(receiverBYTES.MID) ) ? true : false;
    if (mode) mode = ( parseInt(ps["ADDRESS_RECEIVER"+loop+"_LOW_BYTE"]) == parseInt(receiverBYTES.LOW) ) ? true : false;
    if (mode) {
      broadcast = ps["BROADCAST_BEHAVIOR"+loop];
      break;
    }
    loop++;
  }
  return {"mode":mode, "broadcast":broadcast};
};


initLinkCheckBoxes = function(ps, ccuRF) {
  setCheckBox(ps, "linksOnly");
};

initBroadcastOnlyCheckBoxes = function(ps) {
  setCheckBox(ps, "broadcastOnly");
};

initDeviceCCUCheckBoxes = function(ps) {
  setCheckBox(ps, "deviceOnly");
};

setRefreshedContainerNames = function(inputElems, counter) {
  inputElems[0].name = "ADDRESS_SENDER" + counter + "_HIGH_BYTE";
  inputElems[1].name = "ADDRESS_SENDER" + counter + "_MID_BYTE";
  inputElems[2].name = "ADDRESS_SENDER" + counter + "_LOW_BYTE";
  inputElems[3].name = "ADDRESS_RECEIVER" + counter + "_HIGH_BYTE";
  inputElems[4].name = "ADDRESS_RECEIVER" + counter + "_MID_BYTE";
  inputElems[5].name = "ADDRESS_RECEIVER" + counter + "_LOW_BYTE";
  inputElems[6].name = "BROADCAST_BEHAVIOR" + counter;
};

refreshAllNameTags = function() {
  var allStoreContainer = document.getElementsByClassName("j_storeContainer"),
  inputElems = [],
  tmpVal = 0,
  counter = 1;

  // Go through all containers and set the name of the used ones
  for (var loop = 0; loop < allStoreContainer.length; loop++) {
    tmpVal = 0;
    inputElems = allStoreContainer[loop].childNodes;
    
    for (var loopx = 0; loopx <= 5 ; loopx++) {
      tmpVal += parseInt(inputElems[loopx].value);
    }
    // Container is in use
    if (tmpVal > 0) {
      setRefreshedContainerNames(inputElems, counter);
      counter++;
    }
  }

  // Go through all containers and set the name of the unused ones
  for (var loop = 0; loop < allStoreContainer.length; loop++) {
    tmpVal = 0;
    inputElems = allStoreContainer[loop].childNodes;
    
    for (var loopx = 0; loopx <= 5 ; loopx++) {
      tmpVal += parseInt(inputElems[loopx].value);
    }
    // Container isnÂ´t in use
    if (tmpVal == 0) {
      setRefreshedContainerNames(inputElems, counter);
      counter++;
    }
  }
};

storeValues = function(elm, senderRF, receiverRF) {
  var container,
  storeContainerName = "",
  broadcastValue = "0",
  inputElems = [],
  elmType;

  elmType = elm.id.split("-")[0];

  if (!elmType) {
    elmType = elm.className.split("-")[0];
  }
  switch (elmType) {
    case "link": 
      storeContainerName = "j_linkContainer";
      break;     
    case "linkBroadcast": 
      if (elm.checked) {
        storeContainerName = "j_linkContainer";
        broadcastValue = "1";
        elm = elm.parentNode.previousSibling.firstChild;
        elm.checked = true;
      } else {
        storeContainerName = "j_linkContainer";
        broadcastValue="0";
        elm = elm.parentNode.previousSibling.firstChild;
      }
      break;    
    case "broadcast": 
      storeContainerName = "j_broadcastOnlyContainer";
      broadcastValue = "1"; 
      break;
    case "devSystem":
      storeContainerName = "j_deviceSystemContainer";
      broadcastValue = "0"; //  Links with  device - CCU: broadcast is always zero 
      break;
    case "ccuBroadcast": 
      if (elm.checked) {
        storeContainerName = "j_deviceSystemContainer";
        broadcastValue = "1";
        elm = elm.parentNode.previousSibling.firstChild;
        elm.checked = true;
      } else {
        storeContainerName = "j_deviceSystemContainer";
        broadcastValue="0";
        elm = elm.parentNode.previousSibling.firstChild;
      }
      break;
    default: alert("Repeater.js - Error 3: " + elmType + " not defined");
  }

  if (elm.checked) {
       container = getFreeContainer(storeContainerName);
       inputElems = container.childNodes; 
       if (getCounter() < getMaxAllowedEntries()) {    
        inputElems[6].value = broadcastValue;
        inputElems[7].value = "0"; // necessary for isDirty algo

        setValues(inputElems, senderRF, receiverRF);
        incCounter();
      } else {
        elm.checked = false;
        MessageBox.show(translateKey('maxEntriesReachedTitle'),getAttentionText(),'',250,125);
      }
  } else {
    container = getAppropriateContainer(storeContainerName, senderRF, receiverRF);
    inputElems = container.childNodes;
    resetStoreContainer(inputElems); 
    decCounter();
  }
  refreshAllNameTags();
};

/**
* Sets the broadcast element of either a normal link or a ccu link 
*/
setBroadcast = function (elm, senderRF, receiverRF, type) {
  var checkBoxes = document.getElementsByClassName(elm.className),
  parentCheckBox = elm.parentNode.previousSibling.firstChild,
  checked = elm.checked,
  container;
  
  
  if (!parentCheckBox.checked && checked) {
    storeValues(elm, senderRF, receiverRF); 
  } else {
    container = getAppropriateContainer(type, senderRF, receiverRF),
    inputElems = container.childNodes;
    inputElems[6].value = "0";      
    if (checked) {
      inputElems[6].value = "1";      
    }
  }

  //Set corresponding checkboxes 
  for (var loop = 0; loop < checkBoxes.length; loop++) {
    checkBoxes[loop].checked = checked;
    if (!checked) {
      checkBoxes[loop].parentNode.nextSibling.firstChild.checked = checked;
    }
  }
};

/**
* Click handler for the broadcast checkbox of a link
*/
self.setLinkBroadcast = function(elm, senderRF, receiverRF) {
  setBroadcast(elm, senderRF, receiverRF, "j_linkContainer");
};

/**
* Click handler for the ccu checkbox of a link
*/
self.setCCUBroadcast = function(elm, senderRF, receiverRF) {
  setBroadcast(elm, senderRF, receiverRF, "j_deviceSystemContainer");
};


/**
* Click handler for the checkbox of a link
*/
self.setLinksOnly = function(elm, senderRF, receiverRF) {
  var checkBoxes = document.getElementsByClassName(elm.className),
  checked = elm.checked;

  storeValues(elm, senderRF, receiverRF); 
 
  //Set corresponding checkboxes 
  for (var loop = 0; loop < checkBoxes.length; loop++) {
    checkBoxes[loop].checked = checked;
    // If the element is deselected, the appropriate broadcast checkbox has to be deselected as well
    if (!checked) {
      checkBoxes[loop].parentNode.nextSibling.firstChild.checked = checked;
    }
  }
};

/**
* Click handler for the broadcast checkbox of a device which has broadcasts only (e. g. weather sensor)
*/
self.setBroadcastOnly = function(elm, senderRF, receiverRF) {
  storeValues(elm, senderRF, receiverRF); 
};

/**
* Click handler for the device - ccu checkbox
*/
self.setDeviceCCU = function (elm, senderRF, receiverRF) {
  var  checked = elm.checked;
  storeValues(elm, senderRF, receiverRF); 
  // If the element is deselected, the appropriate broadcast checkbox has to be deselected as well
  if (!checked) {
    elm.parentNode.nextSibling.firstChild.checked = checked;
  }
};

self.initAllCheckBoxes = function(ps, ccuRF) {
  initLinkCheckBoxes(ps, ccuRF);
  initBroadcastOnlyCheckBoxes(ps);
  initDeviceCCUCheckBoxes(ps);
  refreshAllNameTags();
};

