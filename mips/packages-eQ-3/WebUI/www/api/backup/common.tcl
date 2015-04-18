load tclrega.so
load tclrpc.so

source /www/tcl/eq3/session.tcl
source /www/tcl/eq3/rega.tcl

set IPC_INTERFACES_FILE "/etc/config/InterfacesList.xml"

array set _query_args_ {}

proc getInterfaceUrl { interfaceName } {
	global IPC_INTERFACES_FILE
	
	set content [loadFile $IPC_INTERFACES_FILE]
	
	set node_start [string first "<ipc"  $content]
	set node_end	 [string first "</ipc" $content $node_start]
	while { (0 < $node_start) && (0 < $node_end) } {
		set node [string range $content $node_start $node_end]
		if {
				[regexp {<name[^>]*>(.+)</name[^>]*>} $node dummy name] &&
				[regexp {<url[^>]*>(.+)</url[^>]*>}   $node dummy url] &&
				[regexp {<info[^>]*>(.+)</info[^>]*>} $node dummy info]
		} {
			set interfaces($name) $url
		}
		set node_start [string first "<ipc" $content $node_end]
		set node_end   [string first "</ipc" $content $node_start]
	}

	if {[info exists interfaces($interfaceName)]} {
		return $interfaces($interfaceName)
	} else {
		error UNKNOWN_INTERFACE
	}
}

proc getQueryArg { name } {
	global _query_args_
	
	if { [info exists _query_args_($name)] } {
		return $_query_args_($name)
	} else {
		return {}
	}
}

proc parseQueryString { } { 
	global _query_args_ env
	
	if { [info exists env(QUERY_STRING)] } {
		foreach item [split $env(QUERY_STRING) &] {
			if { [regexp {([^=]+)=(.+)} $item dummy key value] } {
				set key   [decodeUrl $key]
				set value [decodeUrl $value]
				
				set _query_args_($key) $value
			}
		}
	}
}

proc getPostData { } {
	global env
	
	if { [info exists env(CONTENT_LENGTH)] } {
		set contentLength $env(CONTENT_LENGTH)
		set script [read stdin $contentLength]
	}

}

proc decodeUrl { url } {
	set url [string map -nocase [list + { } "\\" "\\\\" %0d%0a \n] $url]
	regsub -all -nocase {%([a-f0-9][a-f0-9])} $url {\\u00\1} url
	set url [encoding convertfrom [subst -novar -nocommand $url]]
	
	return $url
}

proc loadFile { name } {
	if [catch {
		set fd [open $name r]
		set content [read $fd]
		close $fd
	}] {
		set content ""
	}
	
	return $content
}

proc put_error { errorMsg } {
	puts "HTTP/1.0 400 Bad Request"
	puts "Content-Type: text/plain"
	puts ""
	puts -nonewline "$errorMsg"
}

proc startup { } {	
	if [catch {	
		parseQueryString
		main 
	} errorMsg] {
		put_error $errorMsg
	}
}