#!/bin/bash

# Ativar forward
sysctl -w net.ipv4.ip_forward=1

# Acertar as políticas
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Permintir entrada de tráfego nas portas 22 e 80, tendo como porta de origem apenas a porta 53
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT 
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT 
iptables -A INPUT -p tcp -m tcp --sport 53 --dport 1024:65535 -j ACCEPT 
iptables -A OUTPUT -p tcp -m tcp --sport 1024:65535 --dport 53 -j ACCEPT
