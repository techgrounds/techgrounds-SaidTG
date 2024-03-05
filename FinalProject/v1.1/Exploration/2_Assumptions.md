
# Assumptions

__Epic: Exploratie__

__User Story 2__

Als team willen wij een duidelijk overzicht van de aannames die wij gemaakt hebben.

__Beschrijving__

Je hebt al heel wat informatie gekregen. Mogelijk zijn er vragen die geen van de stakeholders heeft kunnen beantwoorden. Je team moet een overzicht kunnen produceren van de aannames die je daardoor maakt.

__Deliverable__

Een puntsgewijs overzicht van alle aannames.

---

__List of Assumptions__

1. Welke OS versie van Linux en Windows moeten er gebruikt worden.
2. Welke disks zijn nodig voor VMs, hoe groot? Moeten dat managed disks zijn? En hebben beide VMs er een nodig?
3. Moet van zowel de web- als adminserver een backup worden gemaakt? Waar moet deze dan worden opgeslagen, waar binnen de architectuur? En wat voor soort opslag.
4. Met welk publiek IP moet de adminserver bereikbaar zijn? En is dit dan enkel de publieke IP van de administrator aangezien die de enige is die toegang mag hebben?
5. Hebben deze vertrouwde locaties dan een publieke IP?
6. Als er twee IP ranges zijn, betekent dit dan een aparte IP range voor elke server (web en admin)?
7. Wat voor firewall? Een NSG?
8. Betekent dit dat enkel de Admin op de Webserver mag? Of puur als het gaat om SSH en RDP? Mogen andere werknemer wel op de webserv via andere manier?  
Heeft webserv een publiek IP dat bereikbaar is via internet zodat placeholder content te zien is?
9. Bij het bepalen van de region dient wel rekening te worden gehouden met het feit dat niet elke region alle benodige services heeft.
10. Wie wordt Admin? Hoe logt deze in op adminserv
11. Wat voor Database? SQL, noSQL etc.? Voor alleen webserver of adminserv ook?
12. Welke webserver software? Apache, aangezien Linux OS? Is het HTTP of HTTPS?
13. Wie moet inloggen op webserver? 
14. Gebruikt elke server dan een aparte IP range, die weer moet worden opgedeeld in subnetten? Alvast extra subnet aanleggen voor mogelijke migratie workstations?  
Bij welke IP Range hoort die dan?
15. Hebben bij server een RPO en RTO nodig? Zoja dan moeten bij een backup hebben? Moet dit dan in een aparte backup storage buiten de vNets, of binnen maar wel in apart subnet? 
16. Wat voor storage account voor PostDeploymentScripts? Is blob goed?
17. 
18. Dit kan dan zelfde storage account zijn als 16.?
19. 
20. 
21. Wat staat er precies op de adminserv? Wat staat er op dat belangrijk is?
22. 
23. 

