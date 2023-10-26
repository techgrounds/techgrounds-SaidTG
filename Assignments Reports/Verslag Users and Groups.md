# [Onderwerp]
Heb een nieuwe gebruiker in de VM aangemaakt. Met sudo access en een wachtwoord. Daarnaast een command gebruikt om de lijst met gebruikers, wachtwoorden en groepn te tonen.

## Key-terms
Sudo su - = runt als root access

Sudo = runt zoals als root, maar elke gebruiker kan het gebruiken die sudo access heeft

sudo passwd username: verandert wachtwoord voor die gebruiker

sudo adduser username: maakt niewe gebruiker aan, voeg standaard wachtwoord toe

sudo adduser username sudo: voegt gebruiker toe aan groep admin(sudo)

id username: daarmee zie je ter verificatie de aangemaakte gebruiker

cat /etc/passwd: laat alle users, versleutelde wachtwoorden, en groepen zien

sudo -l -U username: om te zien of user sudo heeft. 

compgen - g = groepen of -u = users: laat alle users zien

cat /etc/shadow om gebruikers en hash wachtwoorden te zien

getent passwd username 

## Opdracht
### Gebruikte bronnen
* Root gebruiker worden (https://nl.godaddy.com/help/een-linux-gebruiker-verwijderen-19158)
* Gebruiker en wachtwoord aanmaken (https://support.stackpath.com/hc/en-us/articles/360025308732-Add-Users-to-a-Virtual-Machine)
* Gebruiker sudo geven (https://www.cyberciti.biz/faq/how-to-create-a-sudo-user-on-ubuntu-linux-server/)
* Heeft gebruiker sudo? (https://unix.stackexchange.com/questions/50785/how-do-i-find-out-if-i-am-sudoer)
* Toon gebruikers/groepen (https://askubuntu.com/questions/515103/how-can-i-display-all-users-and-groups-with-a-command)
* Toon gebruikers, ja/ nee ww, en of onderdeel van groep (https://itsfoss.com/linux-list-users/)
* Laat versleuteld ww, en gebruikers zien (https://www.cyberciti.biz/faq/where-are-the-passwords-of-the-users-located-in-linux/)

### Ervaren problemen


### Resultaat

![Alt text](usersandgroupsscreenshot-1.jpg)