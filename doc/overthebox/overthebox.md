# OverTheBox

Sources :
- https://docs.ovh.com/fr/overthebox/comment-fonctionne-overthebox/

## Fonctionnement

Le principe est simple, tous les éléments du réseau sont reliés physiquement entre eux par le biais des ports Ethernet de l’un des modems (qui sera donc le Modem Principal ). Cela inclut :

* Le deuxième modem
* L’ OverTheBox
* Un Ordinateurs/Téléphones etc. ( port libre sur le modem principal)

C’est donc ce Modem Principal qui permet la liaison physique de tous ces éléments.

Lorsque un ordinateur, branché sur le Modem Principal , effectue une requête sur Internet, celle-ci transite d’abord par l’ OverTheBox qui va ensuite router les paquets intelligemment vers les 2 connexions Internet grâce aux ports Ethernet du Modem Principal . Comme le montre l’illustration suivante :

![Fonctionnement](doc/overthebox/fonctionnement.gif "Fonctionnement")
