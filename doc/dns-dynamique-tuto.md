# Mise à jour automatique de DNS

Prérequis :
- Avoir installé et configurer correctement isc-dhcp-server et bind9.
- Être root.

## RNDC

S’assurer que le serveur dns a les droits d’accès en écriture aux fichiers de descriptions de zone. Pour cela, exécutez les commandes :

    chown root.bind /var/bind -R
    chmod g+r+w /var/bind -R

Cette séquence de commande suppose que vos fichiers de zone se trouvent dans le répertoire /var/bind

Générer une clé privée à l'aide de cette commande :

    rndc-confgen

Copier les lignes du premier bloc dans le fichier `/etc/bind/rndc.conf`
Exemple :

    # Start of rndc.conf
    key "rndc-key" {
	    algorithm hmac-md5;
	    secret "b5ossiLnXJslcle6eiDCfw==";
    };

    options {
	    default-key "rndc-key";
	    default-server 127.0.0.1;
	    default-port 953;
    };
    # End of rndc.conf

Copier les lignes du deuxième bloc dans le fichier `/etc/bind/named.conf`
Exemple :

    # Use with the following in named.conf, adjusting the allow list as needed:
    key "rndc-key" {
	    algorithm hmac-md5;
	    secret "b5ossiLnXJslcle6eiDCfw==";
    };

    controls {
	    inet 127.0.0.1 port 953
	    	allow { 127.0.0.1; } keys { "rndc-key"; };
    };
    # End of named.conf

## DHCP
Re-générer une clé privée à l'aide de cette commande :

    rndc-confgen

Copier les lignes du premier bloc sans la partie "options" dans le fichier `/etc/dhcp/dhcpd.conf` avant la déclaration du subnet, et renommer la clé en "dhcp-update-key".
Exemple :

    key "dhcp-update-key" {
    	algorithm hmac-md5;
    	secret "yg6lWRRXN3A+Q49SlbeVVw==";
    };

Toujours dans le fichier `/etc/dhcp/dhcpd.conf`, décommenter la ligne suivante : 

    #authoritative

Modifier la ligne 'ddns-update-style none;' en 'ddns-update-style interim;'

Ajouter cette ligne en l'adaptant avec l'adresse ip du serveur DHCP :

    server-identifier 192.168.0.253;

Ajouter la déclarion des zones DNS après la clé mais avant la déclaration du subnet.

    zone test.lan. {
	    primary 192.168.0.253;
	    key dhcp-update-key;
    }

    zone 0.168.192.in-addr.arpa. {
	    primary 192.168.0.253;
	    key dhcp-update-key;
    }

Fermer le fichier. Un exemple complet est disponible ici : [`dhcpd.conf`](doc/dhcp/dhcpd.conf)

Redemmarer le service dhcp

    service isc-dhcp-server restart

## BIND

Copier les lignes du deuxième bloc sans le bloc 'control' dans le fichier `/etc/bind/named.conf`
Exemple :

    key "dhcp-update-key" {
    	algorithm hmac-md5;
    	secret "yg6lWRRXN3A+Q49SlbeVVw==";
    };

Copier les 2 lignes du bloc 'controls' dans le ce meme bloc mais dans le fichier `/etc/bind/named.conf` en le modifiant comme ceci :

	inet 192.168.0.253 port 953
		allow { 192.168.0.253; } keys { "dhcp-update-key"; };

Fermer le fichier.

Ajouter dans la déclaration de chaque zone DNS dans le fichier `/etc/bind/named.conf.local` cette ligne :

    allow-update { key dhcp-update-key; };

Fermer le fichier. Un exemple complet est disponible ici : [`named.conf`](doc/dns/named.conf) [`named.conf.local`](doc/dns/named.conf.local)


Redemarrer le service DNS

    service bind9 restart

## Procedure de teste :

Sur le serveur DNS/DHCP, entrer la commande suivante :

    tail -f /var/log/daemon.log /var/log/syslog &

Démarrez une machine.

Ces lignes devrait apparaitre sur le serveur DNS/DHCP

    dhcpd: DHCPDISCOVER from 00:19:d2:4d:9b:bb via ens18
    dhcpd: DHCPOFFER on aaa.bbb.ccc.10 to 00:19:d2:4d:9b:bb (poste1) via ens18
    dhcpd: Added new forward map from poste1.test.lan to aaa.bbb.ccc.10
    dhcpd: added reverse map from 10.119.168.192.in-addr.arpa. to poste1.test.lan
    dhcpd: DHCPREQUEST for aaa.bbb.ccc.110 (aaa.bbb.ccc.131) from 00:19:d2:4d:9b:bb (poste1) via ens18
    dhcpd: DHCPACK on aaa.bbb.ccc.110 to 00:19:d2:4d:9b:bb (poste1) via ens18
