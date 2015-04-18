var x = "";

self.SWITCH_subset_descr = function(id, subset)
{
	//1
	
	var sender = $F('dev_descr_sender_tmp').split("-")[0];
	var replacement = []; // nimmt die Texte des gewählten Subsets auf.

	var actor = 'der Schalter'; 

	switch (id.split("_")[2]) {
		
		case "desc1":
			switch (sender) {

				case "ROTARY_HANDLE_SENSOR":
					replacement[0] = "Beim %D6ffnen des Fensters wird " + actor + " f%FCr die gew%E4hlte Zeit eingeschaltet.";
					replacement[1] = "Beim Schlie%DFen des Fensters wird " + actor + " f%FCr die gew%E4hlte Zeit eingeschaltet.";
					break;	
				
				case "SHUTTER_CONTACT":
					replacement[0] = "Beim %D6ffnen des Schaltkontaktes wird " + actor + " f%FCr die gew%E4hlte Zeit eingeschaltet.";
					replacement[1] = "Beim Schlie%DFen des Schaltkontaktes wird " + actor + " f%FCr die gew%E4hlte Zeit eingeschaltet.";
					replacement[2] = "Bei Erkennung des gew%E4hlten %C4nderungssignals wird " + actor + " f%FCr die gew%E4hlte Zeit eingeschaltet.";
					break;	
				
				case "TILT_SENSOR":
					replacement[0] = "Beim %D6ffnen des Garagentores wird " + actor + " f%FCr die gew%E4hlte Zeit eingeschaltet.";
					replacement[1] = "Beim Schlie%DFen des Garagentores wird " + actor + " f%FCr die gew%E4hlte Zeit eingeschaltet.";
					break;	
				
			}
			break; // end text 1
		
		case "desc2":
			switch (sender) {
				
				case "ROTARY_HANDLE_SENSOR":
					replacement[0] = "Beim Schlie%DFen wird er wieder ausgeschaltet.";
					replacement[1] = "Beim %D6ffnen wird er wieder ausgeschaltet. ";
				
				case "SHUTTER_CONTACT":
					replacement[0] = "Beim Schlie%DFen wird er wieder ausgeschaltet.";
					replacement[1] = "Beim %D6ffnen wird er wieder ausgeschaltet.";
					replacement[2] = "Bei einer erneuten %C4nderung schaltet er in den entgegengesetzten Zustand.";
					break;

				case "TILT_SENSOR":
					replacement[0] = "Beim Schlie%DFen wird er wieder ausgeschaltet.";
					replacement[1] = "Beim %D6ffnen wird er wieder ausgeschaltet. ";
			
			}
			break; // end text 2
	}

	$(id).firstChild.data = unescape(replacement[$(subset).selectedIndex]);
}
