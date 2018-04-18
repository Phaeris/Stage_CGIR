# Installation d'un serveur OpenVPN sur "gateway" et d'un client sur OTB

Prérequis : Etre root sur le serveur et l'OTB.

## Installation du serveur

On commence par installer OpenVPN à partir des dépôts officiels :

    apt-get update && apt-get install openvpn

On se prépare à installer les certificats

    cp -a /usr/share/easy-rsa /etc/openvpn/
    cd /etc/openvpn/easy-rsa
    ln -s openssl-1.0.0.cnf openssl.cnf
    source vars
    ./clean-all

Création des certificats de l'autorité de certification :

    ./build-ca

On génère la clé Diffie-Hellman qui sert à sécuriser les échanges :

    ./build-dh

On génère les certificats du serveur :

    ./build-key-server gateway

## Création du fichier de configuration pour le serveur

    gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz > /etc/openvpn/server.conf

On configure server.conf

    cp /etc/openvpn/server.conf /etc/openvpn/server.conf.old
    rm /etc/openvpn/server.conf
    vi /etc/openvpn/server.conf

Copier le contenu de ce fichier [`server.conf`](server.conf) dans le fichier de conf du serveur.

Les lignes importantes de ce fichier sont :

    #On limite le nombres de client simultanées
    max-clients 30
    ---
    ;tls-auth ta.key 0 # This file is secret
    ---
    #On active la compression ça permet de gagner de la bande passante et la vitesse pour tout ce qui est binaire.
    #Attention il faut aussi que cette ligne soit dans le fichier de configuration du client openvpn
    comp-lzo
    ---
    ca /etc/openvpn/easy-rsa/keys/ca.crt
    cert /etc/openvpn/easy-rsa/keys/gateway.crt
    key /etc/openvpn/easy-rsa/keys/gateway.key  # This file should be kept secret
    ---
    dh /etc/openvpn/easy-rsa/keys/dh2048.pem
    ---
	
    push "dhcp-option DNS 195.154.228.249"
    push "dhcp-option DNS 62.210.16.9"

## Configuration reseau

Activation de l'ip forwarding pour le NAT :

    echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/NAT.conf

Activez le nouveau jeux de règle :

    sysctl -p /etc/sysctl.d/NAT.conf

Ajouts des règles dans iptables :

    iptables -t filter -P FORWARD ACCEPT
    iptables -t filter -A INPUT -p udp --dport 1194 -j ACCEPT
    iptables -t nat -A POSTROUTING -o ethx(nom de votre interface) -j MASQUERADE
    iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o ethx(nom de votre interface) -j MASQUERADE

Pour rendre ces règles persistantes après un reboot de votre serveur, il faut commencer par créer un script de chargement de règles de Firewall (ou utiliser un script existant) :

    iptables-save > /etc/iptables_rules.save

Ajouter cette ligne dans la config de l'interface :

    post-up iptables-restore < /etc/iptables_rules.save

## Génération des certificats pour le client

Sur le serveur :

    cd /etc/openvpn/easy-rsa/
    source vars
    ./build-key OTB

## Openvpn sur le poste client

    scp root@ip_du_serveur:/etc/openvpn/easy-rsa/keys/ca.crt /tmp/
    scp root@ip_du_serveur:/etc/openvpn/easy-rsa/keys/OTB.key /tmp/
    scp root@ip_du_serveur:/etc/openvpn/easy-rsa/keys/OTB.crt /tmp/

On copie le fichier de configuration et certificats

    cd /etc/openvpn
    mkdir -p keys
    cd keys

Coller dans le dossiers en cours (keys) les fichiers suivants :

    mv /tmp/ca.crt /etc/openvpn/keys/
    mv /tmp/clientCert.key /etc/openvpn/keys/
    mv /tmp/clientCert.crt /etc/openvpn/keys/

## Création du fichier de configuration sur le client

Copier le contenu du fichier [`client.conf`](client.conf) dans le fichier `/etc/openvpn/client.conf`

## Test de connection

    openvpn /etc/openvpn/client.conf

## Démarrer openvpn

    service openvpn start
