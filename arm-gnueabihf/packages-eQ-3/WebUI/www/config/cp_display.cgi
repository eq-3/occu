#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce session.tcl

proc action_put_page {} {
    global env
    set brightness 15
    set contrast 7
    set bl_unit 1
    set bl_number 60
    set date_format "%d%m%y"
    set time_format "%H%M"
    get_display_config brightness contrast bl_number bl_unit time_format date_format
    
    set DATE_FORMATS {
        "TT.MM.JJ" "%d%m%y"
        "JJ.MM.TT" "%y%m%d"
    }

    set TIME_FORMATS {
        "24h" "%H%M"
        "12h" "%I%M"
    }

    division {class="popupTitle j_translate"} {
        #puts "Display-Einstellungen"
        puts "\${dialogSettingsCentralDisplayTitle}"
    }
    division {class="CLASS21600"} {
        table {class="popupTable"} {border="1"} {
            table_row {class="CLASS21602"} {
                table_data {width="50%"} {align="left"} {class="CLASS21603"} {
                    table {class="CLASS21604"} {width="100%"} {
                        table_row {
                            table_data {align="left"} {
                                #puts "Helligkeit:"
                                puts "\${dialogSettingsCentralDisplayLblBrightness}"
                            }
                            table_data {align="left"} {
                                cgi_select brightness= {id="select_brightness"} {
                                    for {set i 0} {$i < 16} {incr i} {
                                        set selected [expr {$i==$brightness?"selected":""}]
                                        cgi_option $i value=$i $selected
                                    }
                                }
                            }
                        }
                        table_row {
                            table_data {align="left"} {
                                #puts "Kontrast:"
                                puts "\${dialogSettingsCentralDisplayLblBrightness}"
                            }
                            table_data {align="left"} {
                                cgi_select contrast= {id="select_contrast"} {
                                    for {set i 0} {$i < 16} {incr i} {
                                        set selected [expr {$i==$contrast?"selected":""}]
                                        cgi_option $i value=$i $selected
                                    }
                                }
                            }
                        }
                        table_row {
                            table_data {align="left"} {
                                #puts "Hintergrund-Beleuchtungsdauer:"
                                puts "\${dialogSettingsCentralDisplayLblIlluminationLength}"
                            }
                            table_data {align="left"} {
                                cgi_text backlight=$bl_number {size="2"} {id="text_bl_number"} [expr {$bl_unit <= 0?"disabled":""}]
                                cgi_select bl_unit= {id="select_bl_unit"} {onchange="on_change_unit();"} {
                                    cgi_option "\${dialogSettingsCentralDisplayLblOptionOff}" value=0 [expr {$bl_unit==0?"selected":""}]
                                    cgi_option "\${dialogSettingsCentralDisplayLblOptionSeconds}" value=1 [expr {$bl_unit==1?"selected":""}]
                                    cgi_option "\${dialogSettingsCentralDisplayLblOptionMinutes}" value=60 [expr {$bl_unit==60?"selected":""}]
                                    cgi_option "\${dialogSettingsCentralDisplayLblOptionHours}" value=3600 [expr {$bl_unit==3600?"selected":""}]
                                    cgi_option "\${dialogSettingsCentralDisplayLblOptionAlways}" value=-1 [expr {$bl_unit==-1?"selected":""}]
                                }
                            }
                        }
                        table_row {
                            table_data {align="left"} {
                                #puts "Datumsformat:"
                                puts "\${dialogSettingsCentralDisplayLblFormatDate}"
                            }
                            table_data {align="left"} {
                                cgi_select date_format= {id="select_date_format"} {
                                    for {set i 0} {$i < [llength $DATE_FORMATS]} {incr i} {
                                        set user_format [lindex $DATE_FORMATS $i]
                                        set machine_format [lindex $DATE_FORMATS [incr i]]
                                        cgi_option $user_format "value=$machine_format" [expr {"$date_format"=="$machine_format"?"selected":""}]
                                    }
                                }
                            }
                        }
                        table_row {
                            table_data {align="left"} {
                                #puts "Zeitformat:"
                                puts "\${dialogSettingsCentralDisplayLblFormatTime}:"
                            }
                            table_data {align="left"} {
                                cgi_select time_format= {id="select_time_format"} {
                                    for {set i 0} {$i < [llength $TIME_FORMATS]} {incr i} {
                                        set user_format [lindex $TIME_FORMATS $i]
                                        set machine_format [lindex $TIME_FORMATS [incr i]]
                                        cgi_option $user_format "value=$machine_format" [expr {"$date_format"=="$machine_format"?"selected":""}]
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    division {class="popupControls"} {
        table {
            table_row {
                table_data {class="CLASS21605"} {
                    division {class="CLASS21606"} {onClick="PopupClose()"} {
                        #puts "Abbrechen"
                        puts "\${btnCancel}"
                    }
                }
                table_data {class="CLASS21605"} {
                    division {class="CLASS21606"} {onClick="OnApply(true)"} {
                        #puts "OK"
                        puts "\${btnOk}"
                    }
                }
                table_data {class="CLASS21605"} {
                    division {class="CLASS21606"} {onClick="OnApply(false)"} {
                        #puts "&Uuml;bernehmen"
                        puts "\${btnAdoptSettings}"
                    }
                }
                table_data {class="CLASS21607"} {}
            }
        }
    }
    puts ""
    cgi_javascript {
        puts "var url = \"$env(SCRIPT_NAME)?sid=\" + SessionId;"
        puts {
            dlgResult = 0;
            OnApply = function(popup_close) {
                var pb = "action=apply";
                pb += "&brightness="+document.getElementById("select_brightness").value;
                pb += "&contrast="+document.getElementById("select_contrast").value;
                pb += "&bl_number="+document.getElementById("text_bl_number").value;
                pb += "&bl_unit="+document.getElementById("select_bl_unit").value;
                pb += "&time_format="+document.getElementById("select_time_format").value;
                pb += "&date_format="+document.getElementById("select_date_format").value;
                
                var opts = {
                    postBody: pb,
                    sendXML: false,
                    onSuccess: function(transport) {
                        if (transport.responseText.match(/^Success/g)){
                            if(popup_close)PopupClose();
                        }else{
                            alert("Display-Einstellungen konnten nicht gespeichert werden:\n"+transport.responseText);
                        }
                    }
                };
                new Ajax.Request(url, opts);
            };
            on_change_unit = function() {
                    document.getElementById("text_bl_number").disabled=(document.getElementById("select_bl_unit").value <= 0);
            };
        }
        puts "translatePage('#messagebox');"
    }
}

proc get_display_config {var_brightness var_contrast var_bl_number var_bl_unit var_time_format var_date_format} {
    upvar $var_brightness brightness $var_contrast contrast $var_bl_number bl_number $var_bl_unit bl_unit $var_time_format time_format $var_date_format date_format
    set fd -1
    catch {set fd [open "/etc/config/hss_lcd.conf" r]}
    if { $fd <0 } { return 0 }
    set config [read $fd]
    regexp -line {^\s*BRIGHTNESS\s*=\s*'?([^']*)'?\s*$} $config dummy brightness
    regexp -line {^\s*CONTRAST\s*=\s*'?([^']*)'?\s*$} $config dummy contrast
    regexp -line {^\s*TIMEFORMAT\s*=\s*'?([^']*)'?\s*$} $config dummy time_format
    regexp -line {^\s*DATEFORMAT\s*=\s*'?([^']*)'?\s*$} $config dummy date_format
    if {![regexp -line {^\s*BACKLIGHT\s*=\s*'?([^']*)'?\s*$} $config dummy backlight]} {return 0}
    if {![regexp -line {^\s*BACKLIGHT_UNIT\s*=\s*'?([^']*)'?\s*$} $config dummy bl_unit]} {
        if { $backlight <= 0 } {
            set bl_unit $backlight
        } elseif { $backlight <= 120 } {
            set bl_unit 1
        } elseif { $backlight <= (120 * 60) } {
            set bl_unit 60
        } else {
            set bl_unit 3600
        }
    }
    if { $bl_unit > 0 } {
        set bl_number [expr $backlight / $bl_unit]
    } else {
        set bl_number 0
    }
    return 1
}

proc set_display_config {brightness contrast bl_number bl_unit time_format date_format} {
    global TIMEZONES
    set fd -1
    catch {set fd [open "/etc/config/hss_lcd.conf" w]}
    if { $fd <0 } { return 0 }

    if { $bl_unit > 0 } {
        set backlight [expr $bl_unit * $bl_number]
    } else {
        set backlight $bl_unit
    }
    puts $fd "BRIGHTNESS=$brightness"
    puts $fd "CONTRAST=$contrast"
    puts $fd "BACKLIGHT=$backlight"
    puts $fd "BACKLIGHT_UNIT=$bl_unit"
    puts $fd "TIMEFORMAT=$time_format"
    puts $fd "DATEFORMAT=$date_format"
    close $fd
    
    #trigger hss_lcd to re-read the config
    catch {exec killall -SIGUSR1 hss_lcd}
    return 1
}

proc action_apply {} {
    import bl_unit
    import bl_number
    import brightness
    import contrast
    import time_format
    import date_format
    if {[set_display_config $brightness $contrast $bl_number $bl_unit $time_format $date_format]} {
        puts "Success"
    } else {
        puts "Failure"
    }
}

cgi_eval {
    #cgi_debug -on
    cgi_input
    catch {
        import debug
        cgi_debug -on
    }

    set action "put_page"
    http_head
    catch { import action }
    if {[session_requestisvalid 8] > 0} then action_$action
}

