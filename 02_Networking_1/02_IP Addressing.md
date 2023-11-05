# IP Addressing
Een IPv4 adres heeft 32 bits (4 bytes). en is meestal geschreven in decimalen (bijvoorbeeld: 132.88.142.5) waar iedere blok voor, na, en tussen de punten, 1 byte is. 1 byte is 8 bits ook wel octet genoemd. Een bit wordt binair uitgedrukt, 1 of 0. Twee mogelijkheden dus. Tussen de punten staan 8 bits. Dus 2^8 = 256 Dit betekent dat één blok tussen punten een waarde kan hebben van .0 t/m .255. 

Public/Prive: Dit systeem is ontworpen om IP-adresruimte te besparen en de veiligheid van privénetwerken te behouden. Het is een fundamenteel concept in netwerken en internetcommunicatie.    

IPv4 (Internet Protocol versie 4) is de standaardadresindeling aan de hand waarvan alle systemen op internet met elkaar kunnen communiceren. IPv4 wordt geschreven als een 32-bits reeks cijfers en een IPv4-adres bestaat uit vier cijfers tussen 0 en 255, van elkaar gescheiden door punten.

Internet Protocol versie 6 (IPv6) is een bijgewerkte standaard voor de identificatie van computers op internet. Net als bij IPv4 wordt met dit protocol aan elk apparaat een uniek id toegewezen, met de nodige aanpassingen in verband met het toenemende aantal computers dat vandaag de dag met internet verbonden is.

IPv6 verhoogt het aantal mogelijke IP-adressen van die 4 miljard bij IPv4 tot 340 sextiljoen (een getal van 39 cijfers). IPv6 wordt geschreven als een 128-bits hexadecimale cijferreeks en een typisch IPv6-adres ziet er ongeveer zo uit:

__Ontdek wat je publieke IP adres is van je laptop en mobiel op wifi. Zijn de adressen hetzelfde of niet? Leg uit waarom.__

https://www.ip-adres.nl/ 
 Ja.
Network Address Translation (NAT). NAT is een techniek die wordt gebruikt om meerdere apparaten binnen een privénetwerk te delen met één enkel publiek IP-adres.

Router: Het netwerk wordt aangesloten op een router, die meestal verbinding maakt met je internetprovider en een publiek IP-adres toegewezen krijgt.

Network Address Translation (NAT):
De router gebruikt NAT om alle verkeer van apparaten in het privénetwerk om te zetten naar het enkele publieke IP-adres van de router wanneer het verkeer het privénetwerk verlaat. Wanneer een apparaat binnen het netwerk een verzoek doet aan een server op internet, wijzigt de router het bron-IP-adres van dat verzoek naar het publieke IP-adres van de router. Hierdoor lijkt het alsof al het uitgaande verkeer afkomstig is van hetzelfde publieke IP-adres, dat van de router. Dit is een manier om het schaarse aantal beschikbare publieke IPv4-adressen te besparen.

__Ontdek wat je privé IP adres is van je laptop en mobiel op wifi. Zijn de adressen hetzelfde of niet? Leg uit waarom.__

Nee.

Om onderscheid te maken tussen de verschillende apparaten in het netwerk, houdt de router bij welk intern privé-IP-adres elk apparaat heeft en naar welk poortnummer het verkeer moet worden doorgestuurd wanneer het vanaf internet terugkomt. Dit wordt Port Address Translation (PAT) genoemd.

__Verander het privé IP adres van je mobiel naar dat van je laptop. Wat gebeurt er dan?__

Ingelogd op router. DHCP uitschakelen en op handmatig zetten. IP ingevoerd van laptop. Geen verbinding meer. Op beide apparaten.

__Probeer het privé IP adres van je mobiel te veranderen naar een adres buiten je netwerk. Wat gebeurt er dan?__

In instellingen via verbindingen. DHCP uitschakelen en op handmatig zetten. Heb ik geen toestemming voor.

## Opdracht
### Gebruikte bronnen
* __Static and Dynamic IP__ (https://www.geeksforgeeks.org/difference-between-static-and-dynamic-ip-address/)
* __NAT__ (https://www.ipxo.com/blog/what-is-nat/)
* __Public vs Private__ (https://www.ipxo.com/blog/private-vs-public-ip-address/)
* __IP4 vs IP6__ (https://kinsta.com/blog/ipv4-vs-ipv6/)