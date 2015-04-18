
set UI_URLBASE  "/pda"
set UI_DIRBASE  "/www/pda"

set UI_LARGE_CSS "style/large.css"
set UI_SMALL_CSS "style/small.css"

proc getUIStyle { } {
	global uiStyle env
	
	if { "large" != $uiStyle && "small" != $uiStyle } {
		set userAgent {}
		catch { set userAgent $env(HTTP_USER_AGENT) }
		
		if { [regexp {(iPhone)|(iPod)} $userAgent dummy] } then {
			set uiStyle large
		} else {
			set uiStyle small
		}
	}
	
	return $uiStyle
}

proc includeStyle { } {
	global UI_LARGE_CSS UI_SMALL_CSS
	
	switch -exact -- [getUIStyle] {
		large   { set cssFile $UI_LARGE_CSS }
		small   { set cssFile $UI_SMALL_CSS }
		default { set cssFile $UI_SMALL_CSS }
	}
	
	set fd [open $cssFile r]
	set content [read $fd]
	close $fd
	
	return $content
}

proc status_separator { } {
	return {<tr><td class="status_separator">&nbsp;</td></tr>}

}

proc button {label url} {
	set    result "<tr><td class=\"button\" onclick=\"gotoUrl('$url');\">"
	append result "<a href=\"$url\">$label</a>"
	append result "</td></tr>"
	
	return $result
}

proc systemButton {label url} {
	set    result "<tr><td class=\"system_button\" onclick=\"gotoUrl('$url');\">"
	append result "<a href=\"$url\">$label</a>"
	append result "</td></tr>"
	
	return $result
}

proc changeViewButton { url } {
	if { "large" == [getUIStyle] } then {
		return [systemButton "Anzeige verkleinern" [addUrlParam $url uiStyle small]]
	} else {
		return [systemButton "Anzeige vergr&ouml;&szlig;ern" [addUrlParam $url uiStyle large]]
	}
}

proc addUrlParam {url name value} {
	if { 0 < [string first "?" $url] } then {
		return "$url&$name=$value"
	} else {
		return "$url?$name=$value"
	}
}