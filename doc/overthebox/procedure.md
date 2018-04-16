# Procédure de configuration

Sources :
- https://docs.ovh.com/fr/overthebox/installation-manuelle-otb-intel/
- https://docs.ovh.com/fr/overthebox/integration-dune-clef-3g-4g/

Téléchargez l'image d'OverTheBox pour RaspberryPi 3 sur http://downloads.overthebox.net/ovh/overthebox-feeds/rpi3/targets/brcm2708/bcm2710/latest.img.gz

Installez l'image sur la microSD

Branchez la RaspberryPi 3

Sur votre poste, mettre une adresse ip sur 192.168.100.0/24 sauf 192.168.100.1 et configurez la route par defaut sur 192.168.100.1

Dans un navigateur, allez sur http://overthebox.ovh (192.168.100.1) depuis votre ordinateur connecté au modem principal.

Cliquez sur “Register”.

Identifiez vous sur l’espace client.

Cliquez sur le service OverTheBox que vous souhaitez associer à votre boitier.

Faites au préalable un copier/coller du nouveau Device ID sur l’interface OverTheBox.

Modifiez l’ Identifiant du périphérique, il faut alors indiquer le “Device ID”.

Validez.

L’enregistrement est terminé, patientez quelques minutes avant de passer à l’étape suivante.

Retournez sur http://overthebox.ovh (192.168.100.1) depuis votre ordinateur connecté au modem principal.

Cliquez sur le bouton “Activate”.

Quitter l'assitant de configuration

Insérer votre clef 3G/4G contenant votre carte sim sur n’importe quel port USB de votre boitier OverTheBox.

Cliquez sur “Status”

Cliquez sur “Kernel Log”

Descendez tout en bas pour afficher les derniers logs et notez le nom de l’interface Ethernet associée à votre clef.

Cliquez sur “Network”

Cliquez sur “Interface”

Cliquez sur “Add New Interface”

Cochez la case correspondant à l’interface de la clef.

Cliquez sur “Submit”

Cliquez sur “Save & Apply”

Cliquez sur “Network”

Cliquez sur “Interface”

Clique sur le bouton "Edit" correspondant à votre interface principale.

Cliquez sur l'onglet "Advanced Settings"

Sur la ligne Multipath TCP, séléctionnez "enabled"

En bas de la page dans la section DHCP Server, cochez la case "Disable DHCP for this interface."

Cliquez sur “Network”

Cliquez sur “Interface”

Clique sur le bouton "Edit" correspondant à votre interface secondaire.

Cliquez sur l'onglet "Advanced Settings"

Sur la ligne Multipath TCP, séléctionnez "enabled"

En bas de la page dans la section DHCP Server, cochez la case "Disable DHCP for this interface."

