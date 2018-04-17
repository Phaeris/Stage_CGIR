# Auto validation de la clé d'un minion

Source : https://docs.saltstack.com/en/latest/topics/tutorials/preseed_key.html

Générez les clés sur le maître:

    salt-key --gen-keys=[key_name]

Ajoutez la clé publique au dossier Minion accepté:

    cp key_name.pub /etc/salt/pki/master/minions/[minion_id]


Distribuez les clés du minion.

Preseed le minion avec les clés
Vous devez placer les clés du minion avant de démarrer le démon salt-minion:

    /etc/salt/pki/minion/minion.pem
    /etc/salt/pki/minion/minion.pub

Une fois en place, vous devriez être en mesure de démarrer salt-minion et d'exécuter salt-call state.apply
