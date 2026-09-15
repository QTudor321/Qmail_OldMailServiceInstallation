#!/bin/bash
# Operations script for qmail - made by QTudor333
# Start the scan on services directory through daemontools package libraries to launch qmail and the tcp server
svscan /service &
sleep 3
svstat /service/qmail-send
sleep 2
svstat /service/qmail-smtpd
sleep 2
# Inject, send and read a mail through qmail tools: sendmail, qmail-inject, qmail-qread
echo "Hello George from Qmail!" | /var/qmail/bin/sendmail george@localhost
ls /home/george/Maildir/new
cat /home/george/Maildir/new/*
# Read root qmail destination
/var/qmail/bin/qmail-qread
# Inject mail message
sleep 3
echo "Message for George from Qmail using injection!" | /var/qmail/bin/qmail-inject george@localhost
echo "George received the injected message."
# Inject mail file
sleep 3
/var/qmail/bin/qmail-inject -f root@$(hostname) george@localhost < /home/$(hostname)/Documents/Injectedmail.eml
echo "Injection of mail successful!"
sleep 3
# Terminate qmail services
killall qmail-send qmail-smtpd qmail-lspawn qmail-rspawn qmail-clean tcpserver svscan runs multilog supervise qmail-start qmail-remote 2>/dev/null