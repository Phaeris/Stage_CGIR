# Liste de règles appliquées sur le pare-feu

    ufw disable
    ufw default deny incoming
    ufw default deny outgoing
    ufw allow out 22/tcp
    ufw allow in 22/tcp
    ufw allow out 80/tcp
    ufw allow out 53/udp
    ufw allow out 443/tcp
    ufw allow out 20/tcp
    ufw allow out 21/tcp
    ufw allow proto udp from any to 192.168.0.0/24 port 53
    ufw route allow in on en19 out on ens18 to any from any
    ufw route allow in on en18 out on ens19 to any from any
    ufw enable
