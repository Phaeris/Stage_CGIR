# Installation de 2 maitres Salt

Prérequis : 
- Avoir deux serveurs avec des adresses Ip fixe sur le même réseau.
- Avoir configuré keepalived sur ces deux serveurs.
- Avoir un poste sur le réseau.

## Installation des maitres.

Sur les deux serveurs, installer le paquet salt-master.

    apt-get update && apt-get install salt-master

Stoper le service sur les deux serveurs

    service salt-master stop

Générer une clé ssh sur le serveur principal puis l'exporter sur le serveur secondaire

    ssh-keygen 
    ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.0.251

Copier les clés `master.pem` et `master.pub` situé dans `/etc/salt/pki/master/` vers le serveur secondaire dans le même répertoire

    scp /etc/salt/pki/master/master.pem root@192.168.0.251:/etc/salt/pki/master/
    scp /etc/salt/pki/master/master.pub root@192.168.0.251:/etc/salt/pki/master/

Maintenant, il faut synchroniser les clés des minions sur les deux serveurs, pour faire ça nous allons ajouter un crontab

    crontab -e

Ajouter cette ligne à la fin du fichier

    */2 * * * * root rsync --exclude="/etc/salt/pki/master/master.pem" --exclude="/etc/salt/pki/master/master.pub" -e ssh -avz /etc/salt/pki/master/ root@192.168.0.251:/etc/salt/pki/master/

Démarrer le service salt-master

    service salt-master start

## Installation d'un minion

Sur le poste, installer le paquet salt-minion

    apt-get update && apt-get install salt-minion

Editer `/etc/salt/minion`

Dé-commenter la ligne `master : salt`

Modifier `salt` par l'adresse IP virtuelle des deux serveurs maitres configurés avec keepalived

    master: 192.168.0.250

Fermer le fichier

Redémarer le service salt-minion

    service salt-minion restart

## Valider la clé d'un minion

Sur le serveur principal taper la commande :

    salt-key

L'ID du minion est affiché dans la section `Unaccepted Keys:`

    Unaccepted Keys:
    myminion: a8:1f:b0:c2:ab:9d:27:13:60:c9:81:b1:11:a3:68:e1

Pour valider la clé, taper la commande suivante avec l'ID de votre minion

    salt-key -a myminion
