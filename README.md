# Procedimento Para Executar o Teste de bypass de Firewall com nmap

## Baixar o Repositório no Kali Linux

```
$ git clone https://github.com/thiagosmith/regras_de_firewall.git
```

## Acessar e Listar os Arquivos

```
$ cd regras_de_firewall/
$ ls
limpa_regra.sh  REAMDE.md  regra_firewall.sh
```

## Enviar os Arquivos do Kali Linux para o Metasploitable

```
$ scp -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa limpa_regra.sh msfadmin@192.168.80.129:/home/msfadmin/
$ scp -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa regra_firewall.sh msfadmin@192.168.80.129:/home/msfadmin/
```

## Acessar o Metasploitable

```
$ ssh -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa msfadmin@192.168.80.129
```

## Listar os Arquivos no Metasploitable

```
$ ls
limpa_regra.sh  regra_firewall.sh
```

## Atribuir Permissão de Execução(X) aos Arquivos no Metasploitable

```
msfadmin@metasploitable:~$ chmod +x limpa_regra.sh
msfadmin@metasploitable:~$ chmod +x regra_firewall.sh
```

## Login Com o Usuário root Para Executar os Scripts
```
msfadmin@metasploitable:~$ sudo su
```

# Executando os Scripts
```
root@metasploitable:/home/msfadmin# ./limpa_regra.sh
net.ipv4.ip_forward = 0
root@metasploitable:/home/msfadmin# ./regra_firewall.sh
net.ipv4.ip_forward = 1
```

# Executando Scan com o Firewall Bloqueando as Demais Portas, sendo exibida apenas as portas 22 e 80

```
$ nmap 192.168.80.129
Starting Nmap 7.98 ( https://nmap.org ) at 2026-01-20 19:44 -0500
Nmap scan report for alvo.local (192.168.80.129)
Host is up (0.00086s latency).
Not shown: 998 filtered tcp ports (no-response)
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
MAC Address: 00:0C:29:50:66:05 (VMware)
```

# Executando Scan Passando a porta de origem como sendo a 53

```
$ nmap 192.168.80.129 -g53
Starting Nmap 7.98 ( https://nmap.org ) at 2026-01-20 19:46 -0500
Nmap scan report for alvo.local (192.168.80.129)
Host is up (0.0031s latency).
Not shown: 835 closed tcp ports (reset), 152 filtered tcp ports (no-response)
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
1099/tcp open  rmiregistry
1524/tcp open  ingreslock
2049/tcp open  nfs
2121/tcp open  ccproxy-ftp
3306/tcp open  mysql
5432/tcp open  postgresql
5900/tcp open  vnc
6000/tcp open  X11
6667/tcp open  irc
8009/tcp open  ajp13
8180/tcp open  unknown
MAC Address: 00:0C:29:50:66:05 (VMware)

Nmap done: 1 IP address (1 host up) scanned in 1.97 seconds
```

# Limpando as Regras
```
root@metasploitable:/home/msfadmin# ./limpa_regra.sh
net.ipv4.ip_forward = 0
```

# Executando Scan Normal Agora

```
$ nmap 192.168.80.129
Starting Nmap 7.98 ( https://nmap.org ) at 2026-01-20 19:47 -0500
Nmap scan report for alvo.local (192.168.80.129)
Host is up (0.0029s latency).
Not shown: 977 closed tcp ports (reset)
PORT     STATE SERVICE
21/tcp   open  ftp
22/tcp   open  ssh
23/tcp   open  telnet
25/tcp   open  smtp
53/tcp   open  domain
80/tcp   open  http
111/tcp  open  rpcbind
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
512/tcp  open  exec
513/tcp  open  login
514/tcp  open  shell
1099/tcp open  rmiregistry
1524/tcp open  ingreslock
2049/tcp open  nfs
2121/tcp open  ccproxy-ftp
3306/tcp open  mysql
5432/tcp open  postgresql
5900/tcp open  vnc
6000/tcp open  X11
6667/tcp open  irc
8009/tcp open  ajp13
8180/tcp open  unknown
MAC Address: 00:0C:29:50:66:05 (VMware)

Nmap done: 1 IP address (1 host up) scanned in 0.45 seconds
```
