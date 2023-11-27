# Azure Files, App Service, CDN, DNS, SQL
[Geef een korte beschrijving van het onderwerp]

## Key-terms

API = Application Programming Interface

    Azure Files is een dienst van Microsoft Azure die bedrijven en individuen helpt bij het beheren van bestandsopslag in de cloud. Hier zijn antwoorden op je vragen:

    Welk probleem lost Azure Files op?
        Azure Files biedt een oplossing voor het beheren van gedeelde bestandsopslag in de cloud. Het stelt gebruikers in staat om bestandsshares te maken die toegankelijk zijn vanaf meerdere virtuele machines (VM's) in de cloud of zelfs on-premises. Dit is handig voor scenario's waarbij meerdere VM's toegang moeten hebben tot dezelfde bestanden, zoals bij gedeelde configuratiebestanden of gegevensopslag.

    Welke key termen horen bij Azure Files?
        Enkele belangrijke termen gerelateerd aan Azure Files zijn:
            Storage Account: De basisopslageenheid in Azure, waar Azure Files worden gehost.
            File Share: Een specifieke deelbare map in Azure Files, vergelijkbaar met een netwerkshare in een traditioneel besturingssysteem.
            SMB-protocol: Het Server Message Block-protocol wordt gebruikt voor het delen van bestanden, en Azure Files ondersteunt versies 2.1, 3.0 en 3.02.
            Azure Active Directory (AAD): Hiermee kunnen gebruikers en groepen worden beheerd voor toegangscontrole tot Azure Files.
            REST API: Hiermee kunnen ontwikkelaars interactie hebben met Azure Files via HTTP-verzoeken.

    Hoe past Azure Files in een on-premises setting?
        Azure Files kan worden geïntegreerd met on-premises omgevingen via het gebruik van Azure File Sync. Azure File Sync stelt organisaties in staat om een on-premises bestandsserver te synchroniseren met een Azure-bestandsshare. Hierdoor kunnen bedrijven profiteren van zowel lokale toegang als de voordelen van cloudopslag.

    Hoe kan ik Azure Files combineren met andere diensten?
        Azure Files kan worden gecombineerd met andere Azure-diensten zoals:
            Azure Active Directory (AAD): Om toegangscontrole op bestandsniveau te beheren.
            Azure Virtual Machines (VMs): Voor het monteren van Azure File Shares als netwerkschijven.
            Azure File Sync: Voor het synchroniseren van on-premises bestandsservers met Azure Files.
            Azure Backup: Voor het maken van back-ups van bestandssharen.

    Wat is het verschil tussen Azure Files en andere gelijksoortige diensten?
        Het belangrijkste verschil tussen Azure Files en andere gelijksoortige diensten ligt in de integratie met het bredere Azure-ecosysteem. Azure Files kan eenvoudig worden geïntegreerd met andere Azure-services, zoals VM's, AAD, en Azure Backup, waardoor het een naadloze oplossing wordt voor verschillende use-cases. Daarnaast biedt Azure File Sync de mogelijkheid om on-premises en cloudopslag te combineren voor een hybride benadering. Andere cloudproviders hebben vergelijkbare diensten, maar de specifieke implementatie en integratiemogelijkheden kunnen verschillen.

    SQL Databases in Azure bieden verschillende oplossingen en voordelen voor organisaties. Laten we jouw vragen stap voor stap bekijken:

    Welk probleem lost SQL Databases in Azure op?
        Schaalbaarheid: Azure SQL Databases bieden schaalbaarheid op basis van de behoeften van jouw applicatie. Je kunt eenvoudig resources toevoegen of verminderen afhankelijk van de vraag, wat resulteert in optimale prestaties.
        Beheer eenvoud: Azure beheert de infrastructuur, zodat jij je kunt richten op het ontwikkelen van applicaties in plaats van je zorgen te maken over onderliggende hardware en software.
        Beschikbaarheid en herstel: Azure SQL Databases bieden ingebouwde functies voor back-ups, herstel en hoge beschikbaarheid, waardoor de gegevens van jouw organisatie beschermd zijn tegen verlies.

    Welke key termen horen bij SQL Databases in Azure?
        Azure SQL Database: De gehoste relationele database-service in Azure.
        Elastisch schalen: Mogelijkheid om snel resources toe te voegen of te verwijderen om aan de vraag te voldoen.
        Azure SQL Data Warehouse: Een specifieke service voor het analyseren van grote hoeveelheden gegevens.

    Hoe past SQL Databases in Azure in een on-premises setting?
        Hybride omgevingen: Azure ondersteunt hybride scenario's, waarbij je een combinatie hebt van on-premises infrastructuur en cloudresources. Dit maakt het mogelijk om gegevens en workloads naadloos te verplaatsen tussen lokale servers en de cloud.

    Hoe kan ik SQL Databases in Azure combineren met andere diensten?
        Azure Logic Apps: Automatiseert workflows en integratie met andere Azure-services.
        Azure Functions: Serverloze compute voor het uitvoeren van code in reactie op gebeurtenissen.
        Azure App Service: Hiermee kun je web-applicaties bouwen en hosten.

    Wat is het verschil tussen SQL Databases in Azure en andere gelijksoortige diensten?
        Azure SQL Database vs. Azure SQL Data Warehouse: SQL Database is ontworpen voor transactieverwerking, terwijl SQL Data Warehouse is geoptimaliseerd voor analytische verwerking van grote datasets.
        Azure Cosmos DB: Een multimodel, gedistribueerde database voor wereldwijde schaal en meerdere datamodellen.

SQL Databases in Azure bieden flexibiliteit en integratie met verschillende services, waardoor ze geschikt zijn voor diverse scenario's in vergelijking met andere diensten. Het uiteindelijke verschil kan afhangen van specifieke vereisten en gebruiksscenario's binnen jouw organisatie.

    Azure App Service is een platform-as-a-service (PaaS) van Microsoft Azure dat is ontworpen om het bouwen, hosten en schalen van web-applicaties en API's te vergemakkelijken. Laten we elk van je vragen afzonderlijk behandelen:

    Welk probleem lost Azure App Service op?
        Snelheid van ontwikkeling: Azure App Service stelt ontwikkelaars in staat om snel web-apps en API's te bouwen zonder zorgen over de onderliggende infrastructuur.
        Schaalbaarheid: Het biedt automatische schaalbaarheid om te voldoen aan de eisen van gebruikers en verkeer.
        Onderhoudsarm: Het neemt veel van de infrastructuurbeheertaken over, waardoor ontwikkelaars zich kunnen concentreren op de code in plaats van op de infrastructuur.

    Welke key termen horen bij Azure App Service?
        Web Apps: Hiermee kunt u webtoepassingen maken en hosten in de programmeertaal van uw keuze zonder beheer van de infrastructuur.
        API Apps: Hiermee kunnen ontwikkelaars API's bouwen, hosten en delen op een veilige en schaalbare manier.
        Mobile Apps: Voor het bouwen van mobiele apps met functies zoals pushmeldingen, authenticatie en offline data-synchronisatie.
        Logic Apps: Een service waarmee u workflows kunt maken die integreren met verschillende systemen en services.

    Hoe vervangt Azure App Service in een on-premises setting?
        In een on-premises setting zou de organisatie verantwoordelijk zijn voor het beheren van de infrastructuur, inclusief servers, netwerken, enz. Met Azure App Service verplaatst deze verantwoordelijkheid zich naar Microsoft Azure. Ontwikkelaars kunnen zich richten op het bouwen van toepassingen zonder zich zorgen te maken over de onderliggende hardware.

    Hoe kan ik Azure App Service combineren met andere diensten?
        Azure App Service kan worden gecombineerd met andere Azure-diensten zoals Azure SQL Database voor databaseopslag, Azure Storage voor het opslaan van bestanden, Azure Active Directory voor authenticatie en autorisatie, en Azure Functions voor serverloze compute.

    Wat is het verschil tussen Azure App Service en andere gelijksoortige diensten?
        Azure App Service is specifiek gericht op het hosten van web-apps, API's en mobiele apps, terwijl andere diensten zoals Azure Virtual Machines meer algemene IaaS-oplossingen bieden. Het voordeel van App Service ligt in de eenvoud en snelheid van ontwikkeling, evenals de automatische schaalbaarheid. Azure Functions biedt een serverloze compute-optie, waarbij code wordt uitgevoerd in reactie op gebeurtenissen zonder dat er permanente infrastructuur nodig is. Het kiezen tussen deze diensten hangt af van de specifieke behoeften van een project.




Doe theoretische kennis op van:

        Welk probleem lost Azure CDN op?
    Azure Content Delivery Network (CDN) lost het probleem op van trage laadtijden en prestatieproblemen bij het leveren van webinhoud aan gebruikers over de hele wereld. Het versnelt de levering van statische inhoud, zoals afbeeldingen, scripts en stijlbladen, door deze op te slaan op servers die zich dichter bij de eindgebruiker bevinden. Dit vermindert de latentie en verbetert de algehele gebruikerservaring.

    Welke key termen horen bij Azure CDN?
    Enkele belangrijke termen geassocieerd met Azure CDN zijn:
        Endpoint: Het eindpunt waar de gecachte inhoud wordt gehost.
        Origin: De oorspronkelijke server waar de CDN de inhoud ophaalt als het niet in de cache staat.
        Edge-locaties: Fysieke datacenters verspreid over de wereld waar de gecachte inhoud wordt opgeslagen voor snellere toegang.
        PoP (Point of Presence): Een locatie waar het netwerk van een CDN-provider verbinding maakt met het internet om de distributie van inhoud te verbeteren.

    Hoe past Azure CDN / vervangt Azure CDN in een on-premises setting?
    In een on-premises setting kan Azure CDN worden gebruikt om de prestaties van de levering van statische inhoud te verbeteren door deze dichter bij de eindgebruiker te brengen. In plaats van alle inhoud rechtstreeks vanaf de on-premises servers te halen, kunnen bedrijven Azure CDN gebruiken om de statische inhoud te cachen op edge-locaties over de hele wereld. Dit vermindert de belasting van on-premises servers en verbetert de algehele prestaties en schaalbaarheid.

    Hoe kan ik Azure CDN combineren met andere diensten?
    Azure CDN kan worden gecombineerd met andere diensten binnen het Azure-ecosysteem, zoals:
        Azure Blob Storage: CDN kan worden geconfigureerd om inhoud direct vanuit Azure Blob Storage te halen.
        Azure App Service: CDN kan worden geïntegreerd met Azure App Service om de prestaties van web-apps te verbeteren.
        Azure Front Door: Azure CDN kan worden gecombineerd met Azure Front Door voor geavanceerdere routing en beheer van het verkeer.

    Wat is het verschil tussen Azure CDN en andere gelijksoortige diensten?
    Het verschil tussen Azure CDN en andere vergelijkbare diensten kan variëren afhankelijk van de specifieke aanbieder. In vergelijking met sommige andere CDN-diensten biedt Azure CDN een naadloze integratie met andere Azure-services. Bovendien heeft Azure CDN een wereldwijd netwerk van edge-locaties voor optimale prestaties. Het kan verschillen in prijsmodellen, functies, prestaties en beschikbaarheid, dus het is belangrijk om de specifieke vereisten van een project te overwegen bij het kiezen tussen CDN-diensten.

    Azure DNS is een cloudgebaseerde DNS (Domain Name System) service aangeboden door Microsoft Azure. Het lost verschillende problemen op en biedt functionaliteiten die nuttig zijn voor het beheren van DNS in een cloudomgeving. Hier zijn enkele aspecten van Azure DNS die antwoord geven op je vragen:

    Probleemoplossing door Azure DNS:
        Schaalbaarheid: Azure DNS maakt schaalbaar beheer van DNS-middelen mogelijk om te voldoen aan de behoeften van groeiende applicaties en services.
        Betrouwbaarheid: Het biedt hoge beschikbaarheid en redundantie, wat resulteert in betrouwbare DNS-prestaties.

    Key termen bij Azure DNS:
        Zones: Een DNS-zone is een verzameling van DNS-records voor een specifiek domein. In Azure DNS kun je verschillende soorten zones maken, zoals openbare en private zones.
        Records: DNS-records bevatten informatie over hoe het verkeer moet worden omgeleid. Voorbeelden zijn A-records (IPv4-adressen), CNAME-records (canonical names), MX-records (mail exchange), etc.

    Azure DNS in een on-premises setting:
        Azure DNS kan worden geïntegreerd met on-premises omgevingen door middel van hybride netwerkconfiguraties.
        Het kan DNS-zones hosten voor zowel on-premises als cloudtoepassingen.

    Combineren met andere diensten:
        Azure Traffic Manager: Hiermee kun je verkeer routeren over verschillende endpoints op basis van specifieke criteria, wat handig is voor het implementeren van load balancing en failover.
        Azure CDN (Content Delivery Network): Door Azure DNS te integreren met Azure CDN, kunnen snellere en efficiëntere levering van content aan gebruikers wereldwijd worden bereikt.

    Verschillen met andere diensten:
        Azure DNS vs. on-premises DNS: Azure DNS biedt de schaalbaarheid en flexibiliteit van cloud computing, terwijl on-premises DNS beperkt is tot de capaciteit van lokale servers.
        Azure DNS vs. andere cloud DNS-services: Verschillen kunnen bestaan in functies, integratie met andere cloudservices en prijsmodellen.

In het algemeen biedt Azure DNS een geïntegreerde en schaalbare oplossing voor het beheren van DNS in de Azure-cloud, met mogelijkheden voor integratie met andere Azure-services. Het vervangt traditionele on-premises DNS in de zin dat het een cloudgebaseerde oplossing is die kan samenwerken met lokale DNS-configuraties. Het combineren van Azure DNS met andere Azure-diensten maakt het mogelijk om een uitgebreide en schaalbare infrastructuur voor het hosten van applicaties en services te creëren.
    

## Opdracht
### Gebruikte bronnen

* __Azure DNS__ (https://learn.microsoft.com/en-us/azure/dns/dns-overview)
* __Azure CDN__ (https://learn.microsoft.com/en-us/azure/cdn/cdn-overview)

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
