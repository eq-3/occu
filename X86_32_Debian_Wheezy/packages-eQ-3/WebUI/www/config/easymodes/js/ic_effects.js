var new_slider = new Array();

self.Proof_Slider_Value = function(id, min, max)
{
	var input = document.getElementById(id);
	var ausdr_float = /\d+.\d+/; 
	var ausdr_int	= /\d+/;
	if (ausdr_float.test(input.value)) {var wert_float = ausdr_float.exec(input.value); wert_float = wert_float[0];}
	if (ausdr_int.test(input.value)) {var wert_int = ausdr_int.exec(input.value); wert_int = wert_int[0];}
	var wert 		= min;
	var pref 		= id.split("_")[3];

	if (! wert_int) {wert = min;} //1 
	if (! isNaN(wert_int)) {wert = wert_int;}
	if (! isNaN(wert_float)) {wert = wert_float;} 


	if (wert < min) {wert = min;}
	if (wert > max) {wert = max;}
	input.value = wert;
	new_slider[pref].setValue(input.value);
};


self.Set_Slider_Value = function(slider, element) 
{
	for (loop = 0; loop <= document.getElementsByTagName('p').length - 1; loop++)
	{
		var knoten = document.getElementsByTagName('p')[loop];
		if (knoten.hasChildNodes())
		{
			if (knoten.id == slider.id)
			{
				element.value = knoten.firstChild.data;
			}
		}
	}
	
};

self.uSlider = function(handle, track, elem, min, max, step)
{
	var prn = elem.split("_")[1];
	var pref = elem.split("_")[2];
	
	var element = $('separate_' + elem);	
	var slider = $('slider_' + prn + '_' + pref);

	var valid_values = new Array();

	//1
	var fix = 0;
	if (String(step).split(".")[1]) fix = String(step).split(".")[1].length;
	
	//2
	for (var loop = min; loop <= max;loop = parseFloat((loop += step).toFixed(fix)))
	{	
		if (fix != 0) valid_values.push(loop.toFixed(fix));
		else valid_values.push(loop);
	}	

		new_slider[pref] = new Control.Slider(handle, track, {
		
		range: $R(min, max),
		values: valid_values,
		sliderValue: element.value, 
		onSlide: 	function(value) {
						
						slider.style.display = "none";
						slider.update(value);
						Set_Slider_Value(slider, element);
					},
		onChange: 	function(value) {
						
						slider.update(value); 
						Set_Slider_Value(slider, element);
						slider.style.display = "none";
					}
	});
	new_slider[pref].setValue(element.value);
};

