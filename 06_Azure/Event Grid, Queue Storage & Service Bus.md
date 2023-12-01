# Event Grid, Queue Storage & Service Bus

Event Grid, Queue Storage, and Service Bus are all Azure services that address different messaging and event-driven scenarios.

Problems they solve:
--
Event Grid:

Problem: Efficiently manage and react to events in a scalable and decoupled manner.

Use Cases: Event-driven architectures, reacting to changes in Azure resources, handling custom events.

Queue Storage:

Problem: Provide reliable message queuing between applications.

Use Cases: Decouple components in a distributed application, handle bursts of incoming messages, ensure message delivery.

Service Bus:

Problem: Enable communication between applications or services, providing features like message queuing and publish/subscribe.
        
Use Cases: Decouple applications, implement message patterns like pub/sub, enable reliable communication between components.

---

Key terms:

Event Grid: Events, Event Publishers, Event Subscribers, Event Handlers.

Queue Storage: Queues, Messages, Visibility Timeout, Poison Message Queue.

Service Bus: Queues, Topics, Subscriptions, Messages, Relays.

---

How they fit in an on-premises setting:

        These services are primarily designed for cloud-based solutions. However, you can use Azure Hybrid Connections to connect on-premises systems to Azure Service Bus. This allows on-premises systems to communicate with Azure services securely.

Combining with other services:

        These services can be combined with various Azure services for comprehensive solutions. For example, you can combine Event Grid with Azure Functions for serverless event processing, integrate Queue Storage with Azure Functions for message-based processing, or use Service Bus with Azure Logic Apps for workflow automation.

Difference from similar services:

        Event Grid vs. Event Hubs: Event Grid is for event-driven scenarios with a focus on simplicity and ease of use, while Event Hubs is designed for high-throughput, real-time event streaming.

        Queue Storage vs. Azure Storage Queues: Queue Storage is a separate service for handling queues and messages, whereas Azure Storage Queues are part of Azure Storage and provide basic message queuing capabilities.

        Service Bus vs. Event Hub: Service Bus provides more advanced messaging features, including publish/subscribe patterns and advanced queuing, while Event Hub is optimized for large-scale event ingestion.

## Opdracht
### Gebruikte bronnen

* __Azure Service Bus__ (https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)
* __Azure Event Grid__ (https://learn.microsoft.com/en-us/azure/event-grid/overview)
* __Azure Queue Storage__ (https://learn.microsoft.com/en-us/azure/storage/queues/storage-queues-introduction)


### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
