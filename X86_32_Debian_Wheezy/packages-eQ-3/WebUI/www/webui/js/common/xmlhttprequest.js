/*******************************************************************************
 * xmlhttprequest.js
 * Browserunabhängiger Zugriff auf das XMLHttpRequest-Objekt.
 *
 * Autor      : Falk Werner
 * Erstellt am: 04.06.2008
 ******************************************************************************/

/*############################################################################*/
/*# Funktionen                                                               #*/
/*############################################################################*/
 
/*******************************************************************************
 * XMLHttpRequest_create ()
 * Erstellt browserunabhängig ein neuen XMLHttpRequest-Objekt.
 *
 * Dieser Code wurde inspiriert von folgendem Buch:
 * Titel : Ajax - schnell und kompakt
 * Autor : Christian Wenz
 * Verlag: entwickler.press (Software & Support verlag GmbH)
 * ISBN  : 978-3-939084-81-5
 ******************************************************************************/
XMLHttpRequest_create = function ()
{
  var xmlHttp = null;
  
  if ( window.XMLHttpRequest )
  {
    xmlHttp = new XMLHttpRequest();
  }
  else if ( window.ActiveXObject )
  {
    try
    {
      xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (ex)
    {
      try 
      {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch (ex)
      {
        // leer
      }
    }
  }
  
  return xmlHttp;
};

/*******************************************************************************
 * XMLHttpRequest_supported ()
 * Prüft, ob das XMLHttpRequest-Objekt verfügbar ist.
 *
 * Rückgabe:
 *  true  - Das XMLHttpRequest-Objekt ist verfügbar.
 *  false - Das XMLHttpRequest-Objekt ist NICHT verfügbar.
 ******************************************************************************/
XMLHttpRequest_supported = function ()
{
  var request = XMLHttpRequest_create();
  
  if (null !== xmlHttpRequest) { return true;  }
  else                        { return false; }
};
