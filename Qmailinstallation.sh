#!/bin/bash
# Installation script for qmail - made by QTudor333
# Configure the operating system for qmail service download
cd ~
apt update
apt install -y build-essential daemontools daemontools-run ucspi-tcp groff wget tar tree
cd /usr/local/src
# Download qmail source and extract
wget http://netqmail.org/netqmail-1.06.tar.gz
tar xzf netqmail-1.06.tar.gz
cd netqmail-1.06
# Compile qmail service
make setup check
cd ~
# Create qmail service system users and groups for qmail security
groupadd nofiles
useradd -m -g nofiles -d /var/qmail/alias alias
useradd -g nofiles -d /var/qmail qmaild
useradd -g nofiles -d /var/qmail qmaill
useradd -g nofiles -d /var/qmail qmailp
groupadd qmail
useradd -g qmail -d /var/qmail qmailq
useradd -g qmail -d /var/qmail qmailr
useradd -g qmail -d /var/qmail qmails
# Set me and locals inside qmail control service directory to setup mailing addresses on the operating system
hostname -f > /var/qmail/control/me
echo "localhost" > /var/qmail/control/locals
hostname -f >> /var/qmail/control/locals
echo "localhost.$(hostname)" >> /var/qmail/control/locals
# Add Linux users using useradd and chown system command and maildirmake qmail tool
useradd -m george
/var/qmail/bin/maildirmake /home/george/Maildir
chown -R george:george /home/george/Maildir
chown -R george:george /home/george
useradd -m alice
/var/qmail/bin/maildirmake /home/alice/Maildir
chown -R alice:alice /home/alice/Maildir
chown -R alice:alice /home/alice
useradd -m jacob
/var/qmail/bin/maildirmake /home/jacob/Maildir
chown -R jacob:jacob /home/jacob/Maildir
chown -R jacob:jacob /home/jacob
# Create service directory that will be used by qmail tools to function and register logs
mkdir /service
cd service
mkdir qmail-send/log
mkdir qmail-smtpd/log
# Copy the run files that execute the qmail tools for routing, logging and configuring the mailing system for the operating system
cp /home/$(SUDO_USER)/Documents/qmail-send/run /service/qmail-send
cp /home/$(SUDO_USER)/Documents/qmail-send/log/run /service/qmail-send/log
cp /home/$(SUDO_USER)/Documents/qmail-smtpd/run /service/qmail-smtpd
cp /home/$(SUDO_USER)/Documents/qmail-smtpd/log/run /service/qmail-smtpd/log
cd ~
# Setup the execution permissions so that qmail service can execute the run files
chmod +x /service/qmail-send/run
chmod +x /service/qmail-send/log/run
chmod +x /service/qmail-smtpd/run
chmod +x /service/qmail-smtpd/log/run
# Configure the tcp server that will allow the relay of mails through qmail-smtpd from any local connection
echo "127.0.0.1:allow,RELAYCLIENT=\"\"" > /etc/tcp.smtp
tcprules /etc/tcp.smtp.cdb /etc/tcp.smtp.tmp < /etc/tcp.smtp
chmod 644 /etc/tcp.smtp
chmod 644 /etc/tcp.smtp.cdb
cat /etc/tcp.smtp
# Make the log directory for qmail services
mkdir -p /var/log/qmail/{send,smtpd}
chown -R qmaill:nofiles /var/log/qmail
chmod 750 /var/log/qmail /var/log/qmail/*
# Copy qmail rc file inside qmail installation directory, that starts 4 qmail related tools, launching qmail services
cp /home/$(SUDO_USER)/Documents/qmail-rc/rc /var/qmail
echo "Installation of Qmail succeded!"