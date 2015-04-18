self.SenEP_activateEnterPulse = function(selectelem)
{
	//1
	
	var special_input_id = selectelem ;
	var pnr = "_1"; 

	var selectedvalue = document.getElementById("separate_" + special_input_id + pnr ).value; //2 
	
	var PulseTbl = document.getElementById("PulseTbl_" + special_input_id);
	
	if (selectedvalue == "99999996" )
	{	 
		PulseTbl.style.display = "inline";
	
	} else { 
		
		PulseTbl.style.display = "none";
	}
};


self.SenEP_activateEnterFreePulse = function(id, min)
{
	//1 
	
	//2 

	var	nr_tmp = id.split("_");
	var nr = parseInt(nr_tmp[2]);
	//3
	if (document.getElementById("separate_" + id + "_temp").selectedIndex == 1 || 
		document.getElementById("separate_" + id + "_temp").selectedIndex == 0 && $F("separate_" + id + "_temp").split(" ")[0] > 0.000) 
	{
		
		//4 
		if (document.getElementById("separate_" + id + "_temp").selectedIndex == 1)
		{
			document.getElementById("vis_free_" + id).style.display = "inline";
		} 
		else
		document.getElementById("vis_free_" + id).style.display = "none";

		document.getElementById("free_" + id).style.display = "inline";		
		document.getElementById("free_" + id).value = min ;
	

		//5 
		if (nr < 6)
		{
			var x = id.split("_");
			x[2] = nr + 1; 
			id_next = x[0] + "_" + x[1] + "_" + x[2];
			document.getElementById("separate_" + id_next + "_temp").disabled = false ;	
		}
	} 
	else 
	{
		document.getElementById("free_" + id).style.display = "none";
	}

	if ($("separate_" + id + "_temp").name != "SEQUENCE_TOLERANCE") 
	{
		//6 
		if ($("separate_" + id + "_temp").options[2].selected == true || $F("separate_" + id + "_temp") == "0.000")
		{	
			//7 
			document.getElementById("free_" + id).value = 0;
			document.getElementById("vis_free_" + id).style.display = "none";

			var x = id.split("_");
		
			for (loop = nr + 1; loop <= 5; loop++)
			{
				x[2] = loop;
				id_tmp = x[0] + "_" + x[1] + "_" + x[2] ;
				opt_id = "separate_" + id_tmp + "_temp";
			//8
				document.getElementById(opt_id).options[2].text = translateKey("stringTableNotUsed");
				document.getElementById(opt_id).options[2].selected = true;
				document.getElementById(opt_id).disabled = true;	
				document.getElementById("free_" + id_tmp).value = 0 ;
				document.getElementById("vis_free_" + id_tmp).style.display = "none";
			}
		} 
	}
	
	if ($("separate_" + id + "_temp").options[0].selected == true)
	document.getElementById("free_" + id).value = $("separate_" + id + "_temp").options[0].text;
};

self.SenEP_setPulseActorValue = function(id, values )
{
	//1
	var val = values.split(" ");
		
	//2 
	for (loop = 0; loop <= 5; loop++)
	{
		document.getElementById("separate_" + id + "_" + (loop + 1) +  "_temp").value = val[loop];
	}

	//3 
	for (loop = 1; loop <= 5; loop ++ ) 
	{	
		if (document.getElementById("separate_" + id + "_" + loop + "_temp").options[0].text == "0.000" )
		{
			document.getElementById("separate_" + id + "_"  + loop + "_temp").selectedIndex = 2 ;
			document.getElementById("free_" + id + "_" + loop).value = 0;
		}
		else 
		{
			document.getElementById("free_" + id + "_" + loop).value = document.getElementById("separate_" + id + "_" + loop + "_temp").options[0].text;
			document.getElementById("separate_" + id + "_"  + loop + "_temp").selectedIndex = 0 ;
		}	
	}
			
	document.getElementById("free_" + id + "_6").value = document.getElementById("separate_" + id + "_6_temp").options[0].text;
	document.getElementById("separate_" + id + "_6" + "_temp").selectedIndex = 0 ;
	
			
	//4 
	for (loopx = 1; loopx <= 4; loopx++)
	{
		if (document.getElementById("separate_" + id + "_"  + loopx + "_temp").selectedIndex == 2) 
		{
			for (loopy = loopx + 1 ; loopy <= 5; loopy++ )
			{
				document.getElementById("separate_" + id + "_"  + loopy + "_temp").disabled = true ;
			}
		} 
		else 
		{ 
			document.getElementById("separate_" + id  + "_"  + (loopx +1) + "_temp").disabled = false ;	
		}
	}
};
