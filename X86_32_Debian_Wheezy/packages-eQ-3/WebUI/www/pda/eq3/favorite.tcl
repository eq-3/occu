#!/bin/tclsh

proc Favorite_getLists { userId } {
	set    script "var userId = \"_USER$userId\";"
	append script {
		var favs = dom.GetObject(ID_FAVORITES);
		var list = favs.Get(userId);
		string favId;
		foreach(favId, list.EnumIDs())
		{
			var fav = dom.GetObject(favId);
			WriteLine("{ID {" # favId # "} NAME {" # fav.Name() # "}}");
		}
	}
	
	return [rega_exec $script]
}

proc Favorite_getList { listId } {
	set    script "var listId = \"$listId\";"
	append script {
		var list = dom.GetObject(listId);
		string favId;
		if (list)
		{
			WriteLine("NAME {" # list.Name() # "}");
			WriteLine("ITEMS {");
			foreach(favId, list.EnumUsedIDs())
			{
				var fav = dom.GetObject(favId);
				WriteLine("{ID {" # favId # "} NAME {" # fav.Name() # "}}");
			}
			WriteLine("}");
		}
	}
	
	return [rega_exec $script]
}

proc Favorite_get { listId favId } {
	set    script "var favId  = \"$favId\";"
	append script "var listId = \"$listId\";" 
	append script {
		var list = dom.GetObject(listId);
		var fav  = dom.GetObject(favId);
		
		var favType = "UNKNOWN";
		if (fav.IsTypeOf(OT_PROGRAM)) { favType = "PROGRAM"; }
		if (fav.IsTypeOf(OT_DP))      { favType = "SYSVAR";  }
		if (fav.IsTypeOf(OT_CHANNEL)) { favType = "CHANNEL"; }
		
		var canUse = "1";
		string id;
		foreach (id, list.FavControlIDs().EnumIDs())
		{
			if (id == favId) { canUse = "0"; }
		}
		
		WriteLine("NAME {" # fav.Name() # "}");
		WriteLine("ID   {" # fav.ID() # "}");
		WriteLine("TYPE {" # favType # "}");
		WriteLine("CAN_USE {" # canUse # "}");
	}
	
	return [rega_exec $script]
}
