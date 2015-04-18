//======================================================================
//Defines
//======================================================================
GD_TYPE = new Array();
GD_TYPE["UNDEFINED"] = 0;
GD_TYPE["CIRCLE"]    = 1;
GD_TYPE["RECTANGLE"] = 2;
GD_TYPE["STRING"]    = 3;
GD_TYPE["ELLIPSE"]   = 4;
GD_TYPE["FORMSET"]   = 5;
GD_TYPE["LINE"]      = 6;
GD_TYPE["OFFSET"]    = 7;

//Bedeutung einer Position im Array DEV_HIGHLIGHT
//Typangabe
gd_type = 0;

//circle, point
gd_xx = 1;
gd_yy = 2;
gd_rr = 3;

//rectangle, line, ellipse
gd_dx = 3;
gd_dy = 4;

//String
gd_string     = 3;
gd_fontsize   = 4;
gd_fontfamily = 5;
gd_fontstyle  = 6;

//Line
gd_x1     = 1;
gd_y1     = 2;
gd_x2     = 3;
gd_y2     = 4;
gd_stroke = 5;

//Offset
gd_nameoff = 1;
gd_xoff    = 2;
gd_yoff    = 3;
//======================================================================

DEV_TypeExists = function(type)
{
	return DEV_LIST.indexOf(type) >= 0;
};

DEV_getDescription = function(type)
{
	//if (DEV_TypeExists(type)) descr = DEV_DESCRIPTION[type];

	var descr;
	
	try {
		descr = DEV_DESCRIPTION[type];
	} catch (e) { }

	if (!descr) descr = type;

	return descr;
};

DEV_getImagePath = function(type, size)
{
	//if (DEV_TypeExists(type)) path = DEV_PATHS[type][size];
	var path;
	
	try {
		path = DEV_PATHS[type][size];
	} catch (e) { }

	if (! path) path = "#";
	
	return path;
};

DEV_getImageHighlight = function(type, form)
{
	var form;
	
	try {
		form = DEV_HIGHLIGHT[type][form];
	} catch (e) { }

	if (! form) form = null;

	return form;
};
//<.
