# Detection, Response & Analysis

Detection, Response, and Analysis are key components of a comprehensive cybersecurity strategy, often associated with incident response and threat detection. These elements are essential for identifying, mitigating, and analyzing security incidents and breaches.

Detection involves the proactive monitoring of an organization's network, systems, and applications to identify unusual or potentially malicious activities. The goal is to detect security incidents and threats as early as possible, ideally in real-time or near real-time. 

Incident Response is the process of reacting to and mitigating security incidents once they are detected. It involves a series of coordinated actions to contain and remediate the incident, minimize damage, and restore normal operations.

Analysis plays a vital role in understanding the nature of security incidents, their root causes, and the impact on the organization. It includes forensic analysis of systems and data affected by the incident, as well as the analysis of the incident's timeline and tactics used by the attackers.

## Key-terms

* __Recovery Time Objective:__ (RTO) is the maximum acceptable amount of time a system or service can be down or unavailable after a disaster or disruption before it starts to have a significant impact on the organization. In other words, it defines the time it takes to restore a system or service to its normal operational state. The RTO is typically expressed in hours, minutes, or seconds.

For example, if a company has an RTO of 4 hours for its critical e-commerce website, it means that the website must be fully operational again within 4 hours of a disruption; otherwise, it could result in significant financial losses or other adverse consequences.

* __Recovery Point Objective:__ (RPO) is the maximum acceptable amount of data loss that an organization can tolerate after a disaster or disruption. It represents the point in time to which an organization is willing to recover its data. RPO is typically expressed in terms of a time period, such as hours or minutes.

For example, if a company has an RPO of 1 hour for its customer database, it means that they can tolerate losing no more than 1 hour of data in the event of a disaster. This implies that data backups or replication mechanisms need to be in place to ensure that data is recoverable up to the last saved point within that 1-hour window.

* __Intrusion Detection System (IDS)__ is an automated system that detects unauthorized access to a network information system. Unauthorized access provides information about the confidentiality, integrity or information of information. This can range from hits by specialized hackers to script kiddies that are automated - and not used. 

This in combination with an Intrusion Prevention System (IPS) is an Intrusion Detection Prevention System (IDP).

* __Intrusion Prevention System (IPS)__ is a security device that can monitor network and/or system activities for undesirable behaviour. An Intrusion Prevention system can react to this in real-time by blocking or preventing such activities. Network-based IPS systems operate 'in-line' so that all network traffic can be monitored for malicious codes and attacks. If an attack is detected, the IPS can stop (suspect) the "suspicious" packets, while the remaining network traffic can continue.

__Hack Response Strategies:__ Preparation – Planning in advance how to handle and prevent security incidents
Detection and analysis – Encompasses everything from monitoring potential attack vectors to looking for signs of an incident, to prioritization
Containment, eradication, and recovery – Developing a containment strategy, identifying the hosts and systems under attack, mitigating the effects, and having a plan for recovery
Post-incident activity – Reviewing lessons learned and having a plan for evidence retention

__Systems Hardening:__ Systems hardening is a collection of tools, techniques, and best practices to reduce vulnerability in technology applications, systems, infrastructure, firmware, and other areas. The goal of systems hardening is to reduce security risk by eliminating potential attack vectors and condensing the system’s attack surface. By removing superfluous programs, accounts functions, applications, ports, permissions, access, etc. attackers and malware have fewer opportunities to gain a foothold within your IT ecosystem.

__Disaster Recovery Options:__ Disaster recovery (DR) services and solutions allow organizations to maintain business continuity when disasters occur. They help restore data and critical systems in the event of a software or hardware failure, natural disaster, accidental data loss, ransomware attack, or other unexpected event.
 
## Opdracht
### Gebruikte bronnen
* __RTO & RPO__ (https://www.rubrik.com/insights/rto-rpo-whats-the-difference)
* __IDS & IPS__ (https://www.nomios.nl/en/resources/intrusion-detection-prevention-idp-and-ips/)
* __Cyber Incident Response__ (https://www.msp360.com/resources/blog/how-to-respond-to-cyberattacks/)
* __Systems Hardening__ (https://www.beyondtrust.com/resources/glossary/systems-hardening)
* __Disaster Recovery__ (https://cloudian.com/guides/disaster-recovery/disaster-recovery-solutions-top-5-types-and-how-to-choose/#types-of-disaster-recovery-solutions)

### Resultaat

__A Company makes daily backups of their database. The database is automatically recovered when a failure happens using the most recent available backup. The recovery happens on a different physical machine than the original database, and the entire process takes about 15 minutes. What is the RPO of the database?__

In this case, since the company makes daily backups and the recovery process takes about 15 minutes, the RPO would be one day.

__An automatic failover to a backup web server has been configured for a website. Because the backup has to be powered on first and has to pull the newest version of the website from GitHub, the process takes about 8 minutes. What is the RTO of the website?__

If the process, including powering on the backup server and pulling the newest version of the website from GitHub, takes about 8 minutes, then the RTO for the website would be 8 minutes. This means that in the event of a failure, the website should be fully functional on the backup server within 8 minutes to meet the defined RTO.

