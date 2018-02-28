self.SFA_subset_descr = function(id, subset, channel)
{
  //1

  var sender = $F('dev_descr_sender_tmp').split("-")[0];
  var replacement = []; // nimmt die Beschreibungstexte der jeweiligen Subsets auf.

//  var actor = ['', die Sirene', 'das Blitzlicht']; 
  var actor = ['', localized[0]['actor_1'], localized[0]['actor_2'] ]; 
//  var article = ['', 'sie', 'es'];
  var article = ['', localized[0]['article_1'], localized[0]['article_2']];

  switch (sender) {

    case "ROTARY_HANDLE_SENSOR":
      //Profil 1 (Profil 2 wird nicht behandelt) 

      //subset_1
      replacement[0] =  localized[0]['description_0a_s'] + actor[channel] + localized[0]['description_0a_e'];
      replacement[0] += localized[0]['description_0b_s'] + article[channel] + localized[0]['description_0b_e'];
      
      //subset_1
      replacement[1] =  localized[0]['description_1a_s'] + actor[channel] + localized[0]['description_1a_e'];
      replacement[1] += localized[0]['description_1b_s'] + article[channel] + localized[0]['description_1b_e'];

      $(id).className = "translated";
      break;  
        
    case "SHUTTER_CONTACT":
    case "SENSOR_WINDOW":
      switch (id.split('_')[1]) {
        //Profil 1 
        case "1":
            //subset_1
            replacement[0] =  localized[0]['description_0a_s'] + actor[channel] + localized[0]['description_0a_e'];
            replacement[0] += localized[0]['description_0b_s'] + article[channel] + localized[0]['description_0b_e'];
            
            //subset_2
            replacement[1] =  localized[0]['description_1a_s'] + actor[channel] + localized[0]['description_1a_e'];
            replacement[1] += localized[0]['description_1b_s'] + article[channel] + localized[0]['description_1b_e'];
            
            //subset_3
            replacement[2] =  localized[0]['description_2a_s'] + actor[channel] + localized[0]['description_2a_e'];
            replacement[2] += localized[0]['description_2b_s'] + article[channel] + localized[0]['description_2b_e'];
            break;
        //Profil 2
        case "2":
            //subset_1
            replacement[0] =  localized[0]['description_0a_s'] + actor[channel] + localized[0]['description_0a_e'];
            //subset_2
            replacement[1] =  localized[0]['description_1a_s'] + actor[channel] + localized[0]['description_1a_e'];
            //subset_3
            replacement[2] =  localized[0]['description_2a_s'] + actor[channel] + localized[0]['description_2a_e'];
            break;
      };
      $(id).className = "translated";
      break;
        
    case "TILT_SENSOR":
      //Profil 1 (Profil 2 wird nicht behandelt) 
            
      //subset_1
      replacement[0] =  localized[0]['description_0a_s'] + actor[channel] + localized[0]['description_0a_e'];
      replacement[0] += localized[0]['description_0b_s'] + article[channel] + localized[0]['description_0b_e'];
            
      //subset_1
      replacement[1] =  localized[0]['description_1a_s'] + actor[channel] + localized[0]['description_1a_e'];
      replacement[1] += localized[0]['description_1b_s'] + article[channel] + localized[0]['description_1b_e'];

      $(id).className = "translated";

      break;  
  }

  $(id).firstChild.data = unescape(replacement[$(subset).selectedIndex]);
};
