    vi /etc/sysctl.conf

Dé-commenter la ligne suivante : 

    net.ipv4.ip_forward=1

Quiter vi

    sysctl -p /etc/sysctl.conf
    iptables -t nat -A POSTROUTING -o ens18 -j MASQUERADE
    iptables-save > /etc/iptables_rules.save

Ajouter cette ligne à la fin de la configuration de l'interface ens18

    vi /etc/network/interfaces
    post-up iptables-restore < /etc/iptables_rules.save

Quitter vi

    /etc/init.d/networking restart
