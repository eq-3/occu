setLinkWSMOutputBehaviour2Send = function (prn, pref) {
  var val2SendElm = jQuery("#separate_receiver_" + prn + "_" + pref ),
   ltrElm = jQuery("#wsmLtr_" + prn + "_" + pref),
   unitElm = jQuery("#wsmUnit_" + prn + "_" + pref),
   valLtr = parseInt(ltrElm.val()),
   valUnit = parseInt(unitElm.val());

  if (valLtr > 31) {
    ltrElm.val(31);
    valLtr = 31;
  } else if (isNaN(valLtr)) {
    ltrElm.val(0);
    valLtr = 0;
  }
  val2SendElm.val(valLtr + valUnit);
}

setLinkWSMOutputBehaviourElms = function (outputBehaviourVal, prn,pref) {
  var litersVal = 0, litersUnit = 0, bit = 0,
    ltrElm = jQuery("#wsmLtr_" + prn + "_" + pref),
    unitElm = jQuery("#wsmUnit_" + prn + "_" + pref);

  for (bit = 0; bit <= 5; bit++) {
    if ((bit == 0) && (isBitSet(outputBehaviourVal, bit))) {
      litersVal += 1;
    }
    if ((bit == 1) && (isBitSet(outputBehaviourVal, bit))) {
      litersVal += 2;
    }
    if ((bit >= 2) && (isBitSet(outputBehaviourVal, bit))) {
      litersVal += Math.pow(2, bit);
    }
  }

  for (bit = 6; bit <= 7; bit++) {
    if (isBitSet(outputBehaviourVal, bit)) {
      litersUnit += Math.pow(2, bit);
    }
  }
  ltrElm.val(litersVal);
  unitElm.val(litersUnit);
}