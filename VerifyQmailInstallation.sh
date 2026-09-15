#!/bin/bash
# Verification script for qmail installation - made by QTudor333
# Verifying operating system Ubuntu version, firewall status rules and daemontools package libraries
lsb_release -a
ufw status
dpkg -l | grep -E 'daemontools|djbdns'
# List the installed packages
echo "Installed packages:"
ls /usr/bin
# List qmail source tar gz file
cd ~
echo "Qmail source file"
ls /usr/local/src/netqmail-1.06
# List the directories with installed software
tree /home/george
tree /home/alice
tree /home/Jacob
tree /var/qmail
tree /service
tree /var/log/qmail
# Display control me and locals files from qmail control directory
cat /var/qmail/control/me
cat /var/qmail/control/locals
# Display the 4 run scripts from service directory and launch qmail rc file
cat /service/qmail-send/run
cat /service/qmail-send/log/run
cat /service/qmail-smtpd/run
cat /service/qmail-smtpd/log/run
cat /var/qmail/rc
# Display tcp server rule configuration file
cat /etc/tcp.smtp
# Display the added operating system users
grep -E 'george|alice|jacob' /etc/passwd
# Display the qmail system users
cat /etc/passwd | grep 'qmail'
# Ensuring permissions for files are set
chmod +x /service/qmail-smtpd/run
chmod +x /service/qmail-smtpd/log/run
chmod +x /service/qmail-send/run
chmod +x /service/qmail-send/log/run
chmod 644 /etc/tcp.smtp
chmod 644 /etc/tcp.smtp.cdb
# Start, terminate qmail service and check the localhost connection on port 25 and every qmail launched process
echo -e "\e[36mServices that listen on port 25: \e[0m"
ss -tuln | grep :25
echo -e "\e[31mQmail Processes: \e[0m"
ps aux | grep [q]mail
echo -e "\e[93mLaunching qmail service...\e[0m"
sleep 3
svscan /service &
sleep 5
echo "Checking status of send and smtpd services..."
svstat /service/qmail-send
sleep 3
svstat /service/qmail-smtpd
sleep 3
echo "Services that listen on port 25: "
ss -tuln | grep :25
echo "Qmail Processes: "
ps aux | grep [q]mail
echo "Killing qmail processes and the tcp server"
sleep 3
killall qmail-send qmail-smtpd qmail-lspawn qmail-rspawn qmail-clean tcpserver svscan runs multilog supervise qmail-start qmail-remote 2>/dev/null
sleep 3
echo "Qmail processes and the tcp server successfully terminated!"
echo "Services that listen on port 25: "
ss -tuln | grep :25
echo "Qmail Processes: "
ps aux | grep [q]mail