#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce common.tcl
sourceOnce display_commons.tcl
loadOnce tclrega.so


proc get_property {s id var} {
    upvar $var value
    return [regexp -line "^\\s*$id\\s*=(.*)\$" $s dummy value]
}

proc set_property {s_var id value} {
    upvar $s_var s
    if { [regexp -indices -line "^\\s*$id\\s*=(.*)\$" $s dummy range] } {
        set s [string replace $s [lindex $range 0] [lindex $range 1] $value]
        return 1
    } else {
        if { ($s != "") && (![regexp {\n$} $s dummy]) } {
            set s "$s\n"
        }
        set s "$s$id=$value\n"
        return 1
    }
    return 0
}

proc expand_ip { ip } {
    scan $ip "%d.%d.%d.%d" ip_0 ip_1 ip_2 ip_3
    return [format "%03d.%03d.%03d.%03d" $ip_0 $ip_1 $ip_2 $ip_3]
}

proc compress_ip { ip } {
    scan $ip "%d.%d.%d.%d" ip_0 ip_1 ip_2 ip_3
    return [format "%d.%d.%d.%d" $ip_0 $ip_1 $ip_2 $ip_3]
}

proc get_current_config {ip_var mask_var gw_var} {
    upvar $ip_var ip $mask_var mask $gw_var gw
    catch {set ifconfig_result [exec /sbin/ifconfig eth0]}
    if {! [regexp -line {inet addr:([\d.]+).*Mask:([\d.]+)[^\d.]*$} $ifconfig_result dummy ip mask]} {return 0}
    set fd -1
    catch {set fd [open "/proc/net/route" r]}
    if { $fd <0 } { return 0 }
    set routes [read $fd]
    if {! [regexp -line {^eth0\s+0+\s+([\dabcdefABCDEF]+)\s+} $routes dummy gw_hex]} {return 0}
    scan $gw_hex "%02x%02x%02x%02x" gw_ip_3 gw_ip_2 gw_ip_1 gw_ip_0
    set gw "$gw_ip_0.$gw_ip_1.$gw_ip_2.$gw_ip_3"
    
    return 1
}

proc read_config {dhcp_var hostname_var ip_var mask_var gw_var} {
    upvar $dhcp_var dhcp $hostname_var hostname $ip_var ip $mask_var mask $gw_var gw
    set fd -1
    catch {set fd [open "/etc/config/netconfig" r]}
    if { $fd <0 } { return 0 }
    set netconfig [read $fd]
    
    if {! [get_property $netconfig "IP" ip] } {return 0}
    if {! [get_property $netconfig "NETMASK" mask] } {return 0}
    if {! [get_property $netconfig "GATEWAY" gw] } {return 0}
    if {! [get_property $netconfig "HOSTNAME" hostname] } {return 0}
    if {! [get_property $netconfig "MODE" mode] } {return 0}
    set dhcp [expr {"$mode"=="DHCP"}]
    return 1
}

proc write_config {dhcp hostname ip mask gw} {
    set fd -1
    catch {set fd [open "/etc/config/netconfig" r]}
    if { $fd <0 } { return 0 }
    set netconfig [read $fd]
    close $fd
    set fd -1
    
    if { $dhcp != "" } {
        if { $dhcp } {
            set_property netconfig "MODE" "DHCP"
        } else {
            set_property netconfig "MODE" "MANUAL"
        }
    }
    if { $hostname != "" } { set_property netconfig "HOSTNAME" $hostname }
    if { $ip != "" } { set_property netconfig "IP" $ip }
    if { $mask != "" } { set_property netconfig "NETMASK" $mask }
    if { $gw != "" } { set_property netconfig "GATEWAY" $gw }

    catch {set fd [open "/etc/config/netconfig" w]}
    if { $fd <0 } { return 0 }
    
    puts -nonewline $fd $netconfig
    close $fd

    return 1
}

#Display Zeit-/Datumsformat----------------------
read_assignment_file $DISPLAY_FILE DISPLAY_VALUES

set DateFormat "%d%m%y"
catch {set DateFormat $DISPLAY_VALUES(DATEFORMAT)}

set TimeFormat "%H%M"
catch {set TimeFormat $DISPLAY_VALUES(TIMEFORMAT)}
#------------------------------------------------


cgi_eval {
   #cgi_debug -on
    cgi_input

    if { ! [ get_current_config cur_ip cur_mask cur_gw ] } {
      set cur_ip "0.0.0.0"
      set cur_mask "0.0.0.0"
      set cur_gw "0.0.0.0"
    }
    read_config dhcp hostname conf_ip conf_mask conf_gw
    set config_changed 0

    catch {
        cgi_import set_dhcp
        set sDHCP [expr [catch { cgi_import sDHCP }] == 0]
        set dhcp $sDHCP
        set config_changed 1
    }
    
    catch {
        cgi_import sIP
        set conf_ip $sIP
        set dhcp 0
        set config_changed 1
    }
    
    catch {
        cgi_import sSubnet
        set conf_mask $sSubnet
        set dhcp 0
        set config_changed 1
    }
    
    catch {
        cgi_import sGateway
        set conf_gw $sGateway
        set dhcp 0
        set config_changed 1
    }
    
    if { $config_changed } {
        write_config $dhcp $hostname $conf_ip $conf_mask $conf_gw
        catch {exec "/etc/init/network"}
    }
    

   # puts "Content-type: text/html"
   # puts ""
	puts {<hssml pagetype="NETWORK">}
	puts {	<head>}
	
	set sDivname "N1"
    catch {
        cgi_import sDivname
        puts "  <goto div=\"$sDivname\"/>"
    }

	puts "		<date symbols format=\"$DateFormat\"/>"
	puts "		<time symbols format=\"$TimeFormat\"/>"
	puts "		<a href=\"http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_00\" key=\"7\" autoswitch=\"$TIMEOUT\"/>"
	puts {	</head>}
	puts {	<body>}
	puts "		<div name=\"N1\">Network<br/>DHCP [expr {$dhcp?"(On)":"(Off)"} ]<a href=\"#N2\" key=\"4\"/><a href=\"#N14\" key=\"2\"/></div>"
	puts {		<div name="N2">Network<br/>IP Address<a href="#N1" key="1"/><a href="#N3" key="4"/><a href="#N31" key="2"/></div>}
	puts {		<div name="N3">Network<br/>Subnet<    a href="#N2" key="1"/><a href="#N4" key="4"/><a href="#N32" key="2"/></div>}
	puts {		<div name="N4">Network<br/>Gateway<   a href="#N3" key="1"/><a href="#N5" key="4"/><a href="#N33" key="2"/></div>}
	puts {		<div name="N5">Network<br/>Back<      a href="#N4" key="1"/><a href="http://127.0.0.1/config/display/hss_index.cgi?sDivname=M_01" key="2"/></div>}
	puts {		<div name="N14">DHCP<skip/>}
	puts {			<form action="http://127.0.0.1/config/display/network.cgi" method="get" enctype="text/plain">}
	puts {				<input type="hidden" name="sDivname" value="N1"/>}
	puts {				<input type="hidden" name="set_dhcp" value="1"/>}
	puts "				<select name=\"sDHCP\"><option [expr {$dhcp?"":"selected"} ] value=\"\" readout=\"Off\"/><option [expr {$dhcp?"selected":""} ] value=\"DHCP?\" readout=\"On\"/></select>"
	puts {				<input type="decdata" key="1"/>}
	puts {				<input type="submit"  key="2"/>}
	puts {				<input type="incdata" key="4"/>}
	puts {			</form>}
	puts {		</div>}


	if {! $dhcp} then {
		puts {		<div name="N31">IP<skip/>}
		puts {			<form action="http://127.0.0.1/config/display/network.cgi" method="get" enctype="text/plain">}
		puts {				<input type="hidden" name="sDivname" value="N2"/>}
		puts "				<ipinput name=\"sIP\" value=\"[expand_ip $conf_ip]\"/>"
		puts {				<input type="decdata"   key="1"/>}
		puts {				<input type="inccursor" key="2"/>}
		puts {				<input type="incdata"   key="4"/>}
		puts {			</form>}
		puts {		</div>}
		puts {		<div name="N32">Subnet<skip/>}
		puts {			<form action="http://127.0.0.1/config/display/network.cgi" method="get" enctype="text/plain">}
		puts {				<input type="hidden" name="sDivname" value="N3"/>}
		puts "				<ipinput name=\"sSubnet\" value=\"[expand_ip $conf_mask]\"/>"
		puts {				<input type="decdata"   key="1"/>}
		puts {				<input type="inccursor" key="2"/>}
		puts {				<input type="incdata"   key="4"/>}
		puts {			</form>}
		puts {		</div>}
		puts {		<div name="N33">Gatew.<skip/>}
		puts {			<form action="http://127.0.0.1/config/display/network.cgi" method="get" enctype="text/plain">}
		puts {				<input type="hidden" name="sDivname" value="N4"/>}
		puts "				<ipinput name=\"sGateway\" value=\"[expand_ip $conf_gw]\"/>"
		puts {				<input type="decdata"   key="1"/>}
		puts {				<input type="inccursor" key="2"/>}
		puts {				<input type="incdata"   key="4"/>}
		puts {			</form>}
		puts {		</div>}
	} else {
		puts "		<div name=\"N31\">IP<skip count=\"2\"/>[expand_ip $cur_ip][expr {$dhcp?" D":""}]<a href=\"#N2\" key=\"2\"/></div>"
		puts "		<div name=\"N32\">Msk<skip/>[expand_ip $cur_mask][expr {$dhcp?" D":""}]<a href=\"#N3\" key=\"2\"/></div>"
		puts "		<div name=\"N33\">GW<skip count=\"2\"/>[expand_ip $cur_gw][expr {$dhcp?" D":""}]<a href=\"#N4\" key=\"2\"/></div>"
	}
	puts {	</body>}
	puts {</hssml>}
}
