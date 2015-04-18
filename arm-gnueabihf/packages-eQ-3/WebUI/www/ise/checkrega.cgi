#!/bin/tclsh

if { [catch { 
  load tclrega.so
  
  array set result [rega_script {Write("OK");}]

  puts "Content-Type: text/plain"
  puts ""
  puts -nonewline $result(STDOUT)
  
} errorMessage] } then {
  puts "Content-Type: text/plain"
  puts ""
  puts -nonewline $errorMessage
}
