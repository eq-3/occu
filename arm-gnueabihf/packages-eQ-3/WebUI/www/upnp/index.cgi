#!/bin/tclsh
source ../cgi.tcl

proc get_ip_address {} {
    set ifconfig_result [exec /sbin/ifconfig eth0]
    if {! [regexp -line {inet addr:([\d.]+).*Mask:} $ifconfig_result dummy ip]} {return ""}
    return $ip
}

cgi_eval {
    cgi_debug -off
    html {
        head {
            cgi_javascript "language=\"javascript\"" {
                puts "  window.location.href=\"http://[get_ip_address]\";"
            }
            title "HomeMatic"            
        }
        body {
            h1 "HomeMatic"
        }
    }
}

