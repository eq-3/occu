// language = getLang();//"de";

setLanguage = function(lang)
{
  //Funktion wird zur Zeit nicht genutzt

  //Sprache dokumentenübergreifend speichern 
  $('language').value = lang; 
  //  language 0 = de , 1 = en
};

Ajax_failure = function(file, failure)
{
  var msg = '<div style=text-align:center>';
    msg += '<br/><br/>Error while loading the following file:<br/><br/>';
    msg += file + '<br/><br/>';
    msg += '<span style=font-weight:bold>' + failure + '</span></div>'; 

  MessageBox.show('File request failed!', msg, '', 480,120);
};

getPathPNAME = function(actor, language) {
  var result = '/config/easymodes/etc/localization/' + language + '/PNAME.txt';
  if (actor == "ACTOR_SECURITY" || actor == "ACTOR_WINDOW") {
    result = '/config/easymodes/etc/localization/' + language + '/PNAME_TipTronic.txt';
  }
  return result;
};

getLangInfo = function(sender, actor)
{
  var language = getLang();

  var path_1 = '/config/easymodes/' + actor + '/localization/' + language + '/' + sender + '.txt';
  //var path_2 = '/config/easymodes/etc/localization/' + language + '/PNAME.txt';
  var path_2 = getPathPNAME(actor, language);
  var local_generic = '/config/easymodes/' + actor + '/localization/' + language + '/GENERIC.txt';
  var global_generic = '/config/easymodes/etc/localization/' + language + '/GENERIC.txt';

  l_generic = false;

  // die entsprechenden Uebersetzungstabellen der Easymodes einlesen
  new Ajax.Request(path_1,
    {
    method:    'get',
    asynchronous: false,
    onSuccess: function(success) {
            set_description = "[{".concat(success.responseText);
            
          },

    onFailure: function(failure) {
            Ajax_failure(path_1, failure.statusText);
          }
    });
  
  new Ajax.Request(path_2,
    {
    method:    'get',
    asynchronous: false,
    onSuccess: function(success) {
            set_pname = success.responseText;
          },

    onFailure: function(failure) {
            Ajax_failure(path_2, failure.statusText);
          }
    });

  new Ajax.Request(local_generic,
    {
    method:    'get',
    asynchronous: false,
    onSuccess: function(success) {
            l_generic = success.responseText;
          },

    onFailure: function(failure) {
            Ajax_failure(local_generic, failure.statusText);
          }

    });

  new Ajax.Request(global_generic,
    {
    method:    'get',
    asynchronous: false,
    onSuccess: function(success) {
            g_generic = success.responseText;
            if (l_generic != false) {generic = l_generic.concat(g_generic);} else generic = g_generic;
          },

    onFailure: function(failure) {
            Ajax_failure(global_generic, failure.statusText);
          }
    });
    
     var dummy = "\"dummy\" : \"dummy\"}]" ; 
    localized = eval(set_description.concat(set_pname).concat(generic).concat(dummy));
};

getLangInfo_Special = function(file)
{
  var language = getLang();
  var path = '/config/easymodes/etc/localization/' + language + '/' + file;

  localized = (typeof localized === "undefined") ? {} : localized;

  new Ajax.Request(path,
    {
    method:    'get',
    asynchronous: false,
    onSuccess: function(success) {
            set_Special = success.responseText;
          },

    onFailure: function(failure) {
            Ajax_failure(path, failure.statusText);
          
          }
    });

    //localized = eval(set_Special);
    jQuery.extend(true,localized, eval(set_Special));
};



translate_newProfile = function()
{
  var language = getLang();
  var path = '/config/easymodes/etc/localization/' + language + '/NEWPROFILE.txt';

  // die entsprechenden Optionen einlesen
  new Ajax.Request(path,
    {
    method:    'get',
    asynchronous: false,
    onSuccess: function(success) {
            set_newprofile = eval(success.responseText);
          },

    onFailure: function(failure) {
            Ajax_failure(path, failure.statusText);
          }
    });
  
  set_newprofile[0]  = Object.extend(set_newprofile[0], localized[0]);
  
  $('id_header').innerHTML = TrimPath.processDOMTemplate('title_SaveNewProfile', set_newprofile[0]);
  $('id_body').innerHTML = TrimPath.processDOMTemplate('id_body_textarea', set_newprofile[0]);
  $('id_footer').innerHTML = TrimPath.processDOMTemplate('id_footer_textarea', set_newprofile[0]);
};


translate_map = function(div, textarea)
{
  if ( isNaN(localized)) {
    $(div).innerHTML = TrimPath.processDOMTemplate(textarea, localized[0]);
  }
};

translate = function(id, group)
{
  var isUser = id.split('.')[1];
  if (isNaN(localized)) {
    if (isNaN(isUser)) {   // wenn kein Userprofil
      $('param_' + id).id = group + '_param_' + id;
      $('profile_' + id).id = group + '_profile_' + id;
      // hier werden die Platzhalter der EasyModes durch die übersetzten Texte ersetzt.   
      $(group + '_param_' + id).innerHTML = TrimPath.processDOMTemplate(group + '_profile_' + id, localized[0]);
    } else translate_usrprofile(id, group);
  }
};

translate_usrprofile = function(userid, group)
{
  // wenn es sich um ein Userprofil handelt, müssen die IDs angepasst werden.
  // ansonsten kann nicht korrekt uebersetzt werden

  var loop ;
  var x = [];
  var span = document.getElementsByTagName("span");
  var txtarea = document.getElementsByTagName("textarea");
  
  var pruefling = "descrTemplate_" + group + "_" + userid; 
  
  // Anpassung der IDs
  for (loop = 0; loop < span.length; loop++) {
    if ( span[loop].className == pruefling ) {
      span[loop].nextSibling.id = group + "_param_" + userid;
      txtarea[0].id = group + "_profile_" + userid;
      
      // hier werden die Platzhalter durch die übersetzten Texte ersetzt.   
    //  $('param_' + userid).innerHTML = TrimPath.processDOMTemplate('profile_' + userid, localized[0]);
      $(group + '_param_' + userid).innerHTML = TrimPath.processDOMTemplate(group + '_profile_' + userid, localized[0]);
      break;
    }
  }
};
