# mc_server

Hier vind je de code van een bash file voor een minecraft server te runnen GRATIS :)

Het maakt gebruik van Github codespaces (server hardware) en ngrok (endpoint enabelar).
Andere nodige software is java en tmux. (het bash script regelt dit voor jou)

### Gebruik van script:

RUN DIT SCRIPT MAAR 1 KEER PER MACHINE

(zie video die je bij deze link kreeg) [link](https://youtu.be/xV8rDcUkTLc) of
1. Copy en paste de code in een Github codespace.
2. chmod +x nameOfScript.sh
3. ./nameOfScript.sh "ngrok authentification token" # dit is gratis te verkrijgen via ngrok

wacht een 3 tal min (lees het IP van je server af in de rechter pane)

### Gebruik van server:

De bedoeling van het script is om je server aan te maken.
de server wordt bijgehouden ook na het sluiten ervan.
zoek zelf op hoe je deze opnieuw start ik geloof in je je bent slim genoeg :) # TODO maak een script hiervoor

in github codespaces heb je toegang tot 2 machines:
1. De 2-core en 8 GB RAM
2. De 4-core en 16 GB RAM

je ziet dus duidelijk dat de 2de machine meer gewenst is maar het nadeel is dat je hier maar 30 gratis uren van hebt per maand :(
De oplossing hiervoor bestaat echter :) <br> # TODO maak een backend die via de Github API gebruik maakt van meerdere email adressen en een FTP variant om zo deze uren restricties te omzeilen. <br> # TODO aan deze backend voeg je een eenvoudige frontend toe die aan de hand van containers het opstarten van de mc_server vereenvoudigt.

# *DISCLAIMER*
De code is mogelijks tegen de TOS van github gelieve de kennis en deze pagina dus voor jezelf te houden. Verdere versprijding kan mij en de versprijders in problemen brengen. DUS NIET DOEN (bedankt)
