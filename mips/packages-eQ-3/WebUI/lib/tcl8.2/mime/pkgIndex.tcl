if {![package vsatisfies [package provide Tcl] 8.2]} {return}
package ifneeded mime 1.4 [list source [file join $dir mime.tcl]]
package ifneeded smtp 1.4 [list source [file join $dir smtp.tcl]]
