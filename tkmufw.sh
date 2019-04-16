#!/bin/bash

#Author:Tyler Monroe
#Date:4/16/2019
#Purpose:My personal ufw like program
#notes:This could be much fancier but I just needed a toggle switch so to speak.


#enable tkmufw
en(){

#ask user what they need
echo "do you want to enable or disable iptables?"
read ans

if [ "$ans" == "disable" ] ; then

	#detect sudo
	root_pro=`whereis sudo |awk '{ print $2 }'`

	#disable and reset iptables to default state
	$root_pro iptables -F
	$root_pro iptables -t nat -F
	$root_pro iptables -X
	$root_pro iptables -Z
	$root_pro iptables -P INPUT ACCEPT
	$root_pro iptables -P FORWARD ACCEPT
	$root_pro iptables -P OUTPUT ACCEPT

else

#detect sudo
root_pro=`whereis sudo |awk '{ print $2 }'`

#enable basic client firewall in iptables

#reset iptables to default state
$root_pro iptables -F 
$root_pro iptables -t nat -F
$root_pro iptables -X
$root_pro iptables -Z

#Polices
$root_pro iptables -P INPUT ACCEPT
$root_pro iptables -P FORWARD ACCEPT
$root_pro iptables -P OUTPUT ACCEPT

#enable basic client ruleset
$root_pro iptables -P INPUT DROP
$root_pro iptables -P FORWARD DROP
$root_pro iptables -P OUTPUT ACCEPT

$root_pro iptables -A INPUT -i lo -j ACCEPT
$root_pro iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

fi

}

en
