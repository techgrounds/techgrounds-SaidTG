# Azure Disk Storage
Twee VMs aangemaakt. Een Management Disk gemaakt en ''enable shared disk''.
In de Portal van de VMs bij ''disks'', ''attach existing disks'' gekozen en shareddisk gekozen.


## Key-terms

The best command to use is lsblk -f. It will list all the devices and partitions, how they are mounted (if at all) and the tree structure of the devices in the case of using LVM, crypto_LUKS, or multiple volume groups on the same drive.


sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100% = partition disk ''sdc''.

## Opdracht
### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]

