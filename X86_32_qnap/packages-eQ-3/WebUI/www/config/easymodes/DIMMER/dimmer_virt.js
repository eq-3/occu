/*   */
setMinDelayVisibility = function(ch, currentValue) {
  var el = "separate_CHANNEL_" + ch,
  option = document.getElementById(el + "_3"),
  freeValue = document.getElementById(el + "_4"),
  randomInput = document.getElementById("stateInfoRandom_" + ch);

  if (option.selectedIndex == 0) {
    freeValue.value = "0";
    freeValue.style.display = "none";
    randomInput.style.display = "none";
  } else {
    freeValue.style.display = "inline";
    freeValue.value = currentValue;
    randomInput.style.display = "table-row";
  }
};
