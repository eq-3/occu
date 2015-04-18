#!/bin/tclsh

proc Program_getStatus { progId } {
	set    script "var progId = \"$progId\";"
	append script {
		var prog = dom.GetObject(progId);
		var lastExecTime    = prog.ProgramLastExecuteTime();
		var lastExecSeconds = prog.ProgramLastExecuteTimeSeconds();
		
		if (0 != lastExecSeconds)
		{
			lastExecTime = lastExecTime.Format("%d.%m.%Y %H:%M:%S");
		}
		else
		{
			lastExecTime = "unbekannt";
		}
		
		WriteLine("IS_ACTIVE {" # prog.Active() # "}");
		WriteLine("LAST_EXEC_TIME {" # lastExecTime # "}");
		
	}
	
	return [rega_exec $script]
}

proc Program_execute { progId } {
	set    script "var progId = \"$progId\";"
	append script {
		var prog = dom.GetObject(progId);
		prog.ProgramExecute();
	}
	
	rega_exec $script
}