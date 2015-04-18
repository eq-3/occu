# tmpl_parser.tcl
#
#  Tcl embeddedd script parser(a template engine)
#
#  This module comverts Tcl embedded scripts into a Tcl normal script(parser),
#  after you just have to do eval command for the generated parser.
#
# Copyright (c) 2007 by Kanryu KATO<k.kanryu@gmail.com>
# licensed on Tcl License.
#
# Modified by F. Werner (eQ-3 Entwicklung GmbH):
#   - require Tcl 8.2 instead of 8.3
#

package require Tcl 8.2
package provide tmpl_parser 0.1

namespace eval ::tmpl_parser {
    namespace export tmpl_parser
}
 
proc ::tmpl_parser::tmpl_parser {tmpl} {
    # Tcl enbedded tags
    # [[outer <%...inner...%> outer]] <-$tmpl
    #  [        =         ]           <-$token
    #        cd ef        hi j        <-indexes
    set parser { {set _o {}} }
    while {[set i [string first %> $tmpl]] != -1} {
        set h [expr {$i-1}]
        set j [expr {$i+2}]
        set token [string range $tmpl 0 $h]
        set d [string first <% $token]
        set c [expr {$d-1}]
        set e [expr {$d+2}]
        set f [expr {$d+3}]
        
        # outer
        lappend parser [escaped_parse [string range $token 0 $c]]
        switch [string index $token $e] {
            "=" {
                # normal expression (e.g., Thanks <%=$count%> accesses!)
                lappend parser [normal_parse [string range $token $f end]]
            }
            ":" {
                # numeric expression (e.g., <%:$i+2000%>)
                lappend parser [numeric_parse [string range $token $f end]]
            }
            default {
                # embedded Tcl command is passed through listing
                lappend parser [string range $token $e end]
            }
        }
        # after "%>"
        set tmpl [string range $tmpl $j end]
    }
    #last outer
    lappend parser [escaped_parse $tmpl]
    lappend parser {join $_o ""}
    
    return [join $parser "\n"]
}
 
proc ::tmpl_parser::escaped_parse {str} {
    set str [string map {\" \\\" \{ \\\{ \} \\\} \\ \\\\} $str]
    return "lappend _o \"$str\""
}

proc ::tmpl_parser::normal_parse {str} {
    return "lappend _o $str"
}
 
proc ::tmpl_parser::numeric_parse {str} {
    return "lappend _o [expr $str]"
}
