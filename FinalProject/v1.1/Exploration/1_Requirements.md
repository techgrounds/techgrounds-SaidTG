
# Requirements

__Epic: Exploratie__

__User Story 1__

Als team willen wij duidelijk hebben wat de eisen zijn van de applicatie.

__Beschrijving__
	
Je hebt al heel wat informatie gekregen. Er staan al wat eisen in dit document genoemd, maar deze lijst is mogelijk incompleet of onduidelijk. Het is belangrijk om alle onduidelijkheden uitgezocht te hebben voordat je groot werk gaat verzetten.

__Deliverable__
	
Een puntsgewijze omschrijving van alle eisen.

---

__List of Requirements:__

De volgende eisen zijn aangegeven als noodzakelijk:

0.	Webserver is Linux, Admin Server is Windows.
1.	Alle VM disks moeten encrypted zijn. Gebruik industriestandaard, zo goedkoop mogelijke encryptie.  
Hoeft weinig data op, zoals Java bestandjes. Dus OS disk van 4GB is wel genoeg, Managed Disk wss niet nodig.
2.	De webserver moet dagelijks gebackupt worden. De backups moeten 7 dagen behouden worden.
3.	De webserver moet op een geautomatiseerde manier geïnstalleerd worden.
4.	De admin/management server moet bereikbaar zijn met een publiek IP.
5.	De admin/management server moet alleen bereikbaar zijn van vertrouwde locaties (office/admin’s thuis)
6.	De volgende IP ranges worden gebruikt: 10.10.10.0/24 & 10.20.20.0/24
7.	Alle subnets moeten beschermd worden door een firewall op subnet niveau.
8.	SSH of RDP verbindingen met de webserver mogen alleen tot stand komen vanuit de admin server.
9.	Bezoekers en gebruikers komen uit Nederland: Kies West-Europa region of goedkoper zodien mogelijk. Balans tussen latency en kostenbesparing.
10. Aparte Admin server moet Windows Server zijn . Één iemand is Admin.
11.	Webserver moet een Database hebben. Database moet Scalable zijn. Niet te groot wegens kosten.
12.	Gebruik simpele placeholder content om op de webserver te plaatsen. Ik ga niet over de daadwerkelijke inhoud. Dat is voor de web developers.
13. Klanten hoeven niet in te kunnen loggen op website, werknemers mogelijk wel op webserver??
14.	Aparte subnetten hebben één functie/doel: 1. website, 2. admin, 3. workstations
15.	Voor alleen de webserver of ook de admin server???: Recovery Point Objective 24 uur, Recovery Time Objective: 1 uur
16. Goedkoopste storage gebruiken. Disk locally redudant gebruiken want goedkoper
17.	Netwerk moet genoeg subnets hebben met genoeg hosts om toekomstige uitbreiding aan te kunnen wegens aansluiten workstations.
18.	Alleen de webserver heeft Storage account nodig.
19.	Vrij in taalkeuze.
20.	Geen support plan.
21.	Of er ook een backup voor de Admin server moet komen is iets waar ik zelf goed moet overnadenken. Waarschijnlijk wel verstandig.
22.	Opslag voor Scripts moet goedkoop zijn. Sowieso tijdens Development fase.
23. Microsoft Entra ID / Identity and Access Management (IAM)
24. De webserver moet niet meer “naakt” op het internet te benaderen zijn. Het liefst ziet de klant dat er een proxy tussen komt.  
Ook zal de server geen publiek IP adres meer moeten hebben.
25. Mocht een gebruiker via HTTP verbinding maken met de load balancer dan zou deze verbinding automatisch geüpgraded moeten worden naar HTTPS.  
Hierbij moet de verbinding beveiligd zijn met minimaal TLS 1.2 of hoger.
26. De webserver moet met enige regelmaat een ‘health check’ ondergaan.  
Mocht de webserver deze health check falen dan zou de server automatisch hersteld moeten worden.
27. Mocht de webserver onder aanhoudende belasting komen te staan, dan zou er een tijdelijke extra server opgestart moeten worden.  
De klant denkt dat er nooit meer dan 3 servers totaal nodig zijn gezien de gebruikersaantallen in het verleden.

Note: Omdat we niet voor iedereen een domeinnaam willen aanschaffen, is het lastig om op de juiste manier een HTTPS-verbinding tot stand te brengen. Je mag hiervoor een self-signed certificate gebruiken. Je krijgt dan wel een waarschuwing in je browser, maar de verbinding wordt wel versleuteld.


*   Wie is admin thuis ip? Ben ik zelf thuis.
*   Parameter file? wel handig!
*	Diagram is van hoe de Cloud eruit moet komen te zien.
*	Projectbudget: Development <10,- in Azure tot Eindpresentatie. Live 150,- per maand / is fictief
*	Wees niet bang om verbeteringen in de architectuur voor te stellen of te implementeren, maar maak wel harde keuzes, zodat je de deadline kan halen.
*	Gebruik Bicep in Azure
*	Fictief scenario: Van on-premise naar cloud. Workstations overzetten naar Cloud.


