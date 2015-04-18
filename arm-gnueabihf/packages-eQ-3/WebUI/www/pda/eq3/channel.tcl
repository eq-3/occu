#!/bin/tclsh

proc Channel_getDataPoints { channelId } {
	set script    "var channelId = \"$channelId\";"
	append script {
		var channel = dom.GetObject(channelId);
		string dpId;
		foreach(dpId, channel.DPs().EnumEnabledVisibleIDs())
		{
			var dp = dom.GetObject(dpId);
			var name   = dp.Name();
			var id     = dp.ID();
			var control = "";
			
			if (dp.IsTypeOf(OT_HSSDP))
			{
				name = dp.HSSID();
				control = dp.MetaData("CONTROL");
				if (!control) { control = "GENERIC"; }
			}
			
			if (dp.IsTypeOf(OT_VARDP))
			{
				name = dp.Name();
				control = "SYSVAR";
			}
			
			Write("{");
			Write("NAME {" # name # "}");
			Write(" ID {" # id # "}");
			Write(" CONTROL {" # control # "}");
			WriteLine("}");
		}
	}

	return [rega_exec $script]
}