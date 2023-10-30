# Cron Jobs
Cron Jobs zijn scripts die je regelmatig kan laten uitvoeren door te automatiseren.

## Key-terms
timedatectl = huidige tijd en datum

cat > TimeDate.sh = sudo timedatectl >> TimeDate.txt

chmod +x TimeDate.sh

crontab -e = * * * * * /home/said_/TimeDate.sh

cat > diskweekly.sh = sudo df -h --total >> diskweekly.log

chmod +x diskweekly.sh

./diskweekly.sh

sudo mv diskweekly.sh /var/log

sudo mv diskweekly.log /var/log

crontab -e = 0 0 * * 0 /var/log/diskweekly.sh

## Opdracht
### Gebruikte bronnen
* cron schedule editor (https://crontab.guru/)
* adding .sh to crontab (https://www.baeldung.com/linux/create-crontab-script)
* check disk space (https://askubuntu.com/questions/73160/how-do-i-find-the-amount-of-free-space-on-my-hard-drive)
* current date/time (https://www.cyberciti.biz/faq/linux-display-date-and-time/)
* set timezone (https://askubuntu.com/questions/679988/how-to-change-ubuntus-server-date-and-time-via-command-line)
### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
