/**
 * Created by WebStorm.
 * User: grobelnik - eQ3
 * Date: 07.12.2016
 * Time: 13:59
 */

setDiagram = function() {
  delete hm_lc_dw_diagram;
  var imgElm = jQuery("[name='imgDualWhiteController']");
  var config = jQuery("[name='CHARACTERISTIC_BASETYPE']").first().val()
  + jQuery("[name='CHARACTERISTIC_LINSQUARETYPE']").first().val()
  + jQuery("[name='CHARACTERISTIC_LEVELLIMIT']").first().val()
  + jQuery("[name='CHARACTERISTIC_COLOURASSIGNMENT']").first().val();

  getDualWhiteControllerDiagramURLs();
  imgElm.attr("src", dualWhiteControllerDiagramURL[config]);


  var srcDiagram = dualWhiteControllerDiagramURL[config];
  var tooltip = "<img src="+srcDiagram+" width=450; height=330 />";
  imgElm.data('powertip', tooltip);
  imgElm.powerTip({smartPlacement: true, followMouse: false});

};

