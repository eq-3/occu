##
# template.tcl
# Vereinfacht den Zugriff auf tmpl_parser.tcl.
#
# (c) 2009
# eQ-3 Entwicklung GmbH
# Falk Werner
##

package require tmpl_parser

##
# template_parse
# Parst ein Template aus einer Zeichenkette.
##
proc template_parse {template_string} {
  return [::tmpl_parser::tmpl_parser $template_string]
}

##
# template
# Parst ein Template aus einer Datei.
##
proc template_parseFile {filename} {
  set fd [open $filename r]
  set template_string [read $fd]
  close $fd
  
  return [template_parse $template_string]
}

##
# include
# Server-Side-Include: bindet eine Datei ein
##
proc include { filename } {
	set fd [open $filename r]
	set content [read $fd]
	close $fd
	
	return $content
}