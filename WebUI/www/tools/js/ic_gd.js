/**
 * ic_gd.js
 **/

//Defines
BORDER_COLOR = "#5C7287";//Border
HL_COLOR = "#CC6600"; //Highlight
BG_COLOR = "#FFFFFF";//Background
HL_STROKE = 4;//Background
//-----

InitGD = function(jg, size)
{
  //alert(jg);
  
  ClearCanvas(jg, size);
    jg.setColor(HL_COLOR);
    jg.setStroke(parseInt(HL_STROKE));
};

ClearCanvas = function(jg, size)
{
  jg.clear();
    jg.setColor(BG_COLOR);
  jg.fillRect(parseInt(0), parseInt(0), parseInt(size), parseInt(size));
  jg.paint();
    jg.setColor(HL_COLOR);
};

Draw = function(jg, devtype, size, formname)
{
  //if (! DEV_TypeExists(devtype)) return;
  var path = DEV_getImagePath (devtype, size);

  if (path == "#") return;

  jg.drawImage2(path, 0, 0, size, size);
  if (formname && formname != "-1") DrawForm(jg, formname, devtype, size);
  jg.paint();
};

DrawForm = function(jg, formname, devtype, size, x_offset, y_offset)
{
  var form = DEV_getImageHighlight(devtype, formname);
  
  if (!form) return;

  if (!x_offset) x_offset = 0;
  if (!y_offset) y_offset = 0;

  switch (form[gd_type])
  {
    case GD_TYPE["CIRCLE"]:
      jg.fillArc(Math.round( (form[gd_xx]+x_offset) * size), Math.round((form[gd_yy]+y_offset)*size), Math.round(form[gd_rr]*2*size), Math.round(form[gd_rr]*2*size), parseInt(0.0), parseInt(360.0));
      break;
    case GD_TYPE["RECTANGLE"]:
      jg.fillRect(Math.round((form[gd_xx]+x_offset)*size), Math.round((form[gd_yy]+y_offset)*size), Math.round(form[gd_dx]*size), Math.round(form[gd_dy]*size));
      break;
    case GD_TYPE["STRING"]:
      jg.setFont(form[gd_fontfamily], Math.round(form[gd_fontsize]*size)+"px", form[gd_fontstyle]);
      jg.drawString(form[gd_string], Math.round((form[gd_xx]+x_offset)*size), Math.round((form[gd_yy]+y_offset)*size));
      break;
    case GD_TYPE["ELLIPSE"]:
      jg.fillArc(Math.round((form[gd_xx]+x_offset)*size), Math.round((form[gd_yy]+y_offset)*size), Math.round(form[gd_dx]*size), Math.round(form[gd_dy]*size), parseInt(0.0), parseInt(360.0));
      break;
    case GD_TYPE["LINE"]:
      jg.setStroke(Math.round(form[gd_stroke]*size));
      jg.drawLine(Math.round((form[gd_x1]+x_offset)*size), Math.round((form[gd_y1]+y_offset)*size), Math.round((form[gd_x2]+x_offset)*size), Math.round((form[gd_y2]+y_offset)*size));
      jg.setStroke(parseInt(HL_STROKE));
      break;
    case GD_TYPE["FORMSET"]:
      for (var i=gd_type+1; i<form.length; i++)
      {
        DrawForm(jg, form[i], devtype, size, x_offset, y_offset);
      }
      break;
    case GD_TYPE["OFFSET"]:
      DrawForm(jg, form[gd_nameoff], devtype, size, form[gd_xoff]+x_offset, form[gd_yoff]+y_offset);
      break;
    default:
      break;
  }
};

 /*
========================================================================
=====Positionierung und Anzeige des Detailbildes auf dem Bildschirm=====
========================================================================
 */

DrawBorder = function(jg, size)
{
  jg.setColor(BORDER_COLOR);
  jg.drawRect(parseInt(0), parseInt(0), parseInt(size), parseInt(size));
  jg.paint();
  jg.setColor(HL_COLOR);
};
 
picDivShow = function(jg, devtype, size, formname, divelem)
{
  if (! jg) return;

  if (! DEV_TypeExists(devtype)) return; //kein Bild anzeigen, wenn das Gerät unbekannt ist.
  
  var dim_div = Element.getDimensions(divelem);
  var dim     = getInnerDimensions();
  var off     = getPageOffsets();
  var winoy   = off.yOffset;
  var winuy   = off.yOffset + dim.height;

  //Mouse-Position (circa)-----
  var pagePosition = Position.page(divelem);//Returns the X/Y coordinates of element relative to the viewport
    
  //Draw Image and Highlight-----
  ClearCanvas(jg, size);
  Draw(jg, devtype, size, formname);
  DrawBorder(jg, size);
  //-----

  //y-Position----
  y       = pagePosition[1] +dim_div.height/2 - size/2; //mittig anordnen
  y_unten = y + size;

  if (y        < winoy+10) y = winoy + 10;
  if (y_unten  > winuy-30) y = winuy - 30 - size;

  $('picDiv').style.top  = y + "px";
  //-----
    
  //x-Position-----
  winrx    = dim.width + off.xOffset;
  x        = pagePosition[0] + dim_div.width + 30; //etwas rechts
  x_rechts = x + size;
    
  if (x_rechts > winrx) x = pagePosition[0] - size - 30;

  $('picDiv').style.left = x + "px";
  //-----

  ShowElement('picDiv');
  if (typeof previewPicTimer == "undefined") {
    previewPicTimer = window.setTimeout(function () {
      HideElement('picDiv');
      delete previewPicTimer;
    }, 10000);
  }
};

picDivHide = function(jg)
{
  if (typeof previewPicTimer != "undefined") {
    window.clearTimeout(previewPicTimer);
    delete previewPicTimer;
  }

  if (! jg) return;

  HideElement('picDiv');
  jg.drawImage("/ise/img/loading.gif", 0, 0, 250, 250);
};
