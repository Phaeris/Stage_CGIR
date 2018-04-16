# Tutoriel pour la mise en place du netboot

Télécharger le nécessaire à l’installation réseau grâce à la commande suivante :

    wget http://ftp.fr.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/netboot.tar.gz

Installer tftpd-hpa.

    apt-get update && apt-get install tftpd-hpa

Configurer tftpd-hpa (fichier de configuration dans [`tftpd-hpa`](doc/tftp)).

    vi /etc/default/tftpd-hpa

Redémarrer le service tftp.

    service tftpd-hpa restart

Décompresser le fichier `netboot.tar.gz` à la racine servie par le serveur tftp.

    tar -xzvf netboot.tar.gz /var/lib/tftpboot/

Ajouter ces deux lignes à dhcpd.conf dans la décalration du réseau (fichier de configuration dans [`dhcpd.conf`](doc/dhcp)).

    filename "pxelinux.0";
    next-server 192.168.0.253;

Redémarrer le service dhcp.

    service isc-dhcp-restart restart
