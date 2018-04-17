# Installation et configuration de keepalive

Source : https://raymii.org/s/tutorials/Keepalived-Simple-IP-failover-on-Ubuntu.html

Prérequis : Avoir deux serveurs avec des adresses Ip fixe sur le même réseau.

## Installation

    apt-get install keepalived -y

## Configuration

### Serveur principal

Créer un fichier de configuration sur le serveur principal

    vi /etc/keepalived/keepalived.conf

Copier coller la configuration suivante en adaptant le nom de l'interface (l.3), le mot de passe (l.9) et l'adresse Ip virtuelle (l.12) : [`keepalived.conf`](keepalived-principal.conf).

### Serveur secondaire

Créer un fichier de configuration sur le serveur secondaire.

    vi /etc/keepalived/keepalived.conf

Copier coller la configuration suivante en adaptant le nom de l'interface (l.3), le mot de passe (l.9) et l'adresse Ip virtuelle (l.12) : [`keepalived.conf`](keepalived-secondaire.conf).


## sysctl

Afin de pouvoir lier sur une adresse IP qui n'est pas encore définie sur le système, nous devons activer la liaison non locale au niveau du noyau.

Ajouter la ligne suivante à `/etc/sysctl.conf` :

    net.ipv4.ip_nonlocal_bind=1

Activer avec :

    sysctl -p

## Demarrage

    service keepalived restart
