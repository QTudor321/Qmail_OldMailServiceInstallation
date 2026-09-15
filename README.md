# Qmail_OldNetworkServiceInstallation
Qmail is an old and archived Unix mail transfer agent (MTA). Its services have been archived following years of digital evolution and other MTA's. This project purpose is to demonstrate DevOps, system and services administration capabilities by implementing an instant Qmail installation script in Bash from zero on any Ubuntu Linux virtual machine, while also configuring and documenting the archived Qmail service.
The project contains a set of files and directories created to document and illustrate the steps taken to finish the mail service configuration.

<img width="562" height="440" alt="image" src="https://github.com/user-attachments/assets/a40b1b82-e479-4d20-bffc-e3f337b4e154" />

Project content:
- images gallery with every step taken
- qmail service directories (qmail-send and qmail-smtpd) that will be used by qmail tools to function and register logs
- qmail-rc file which is the qmail mail agent control file
- list of all commands used in the Linux terminal
- an injected email example in .eml format used to experiment with the completely installed qmail service
- 3 Bash scripts used for the following:
  - install qmail
  - verify installation files
  - execute qmail operations

Caution for anyone who wants to try these experiments or install old mail services and modify ports like in this repository, unless the individual has a good understanding of whats happening inside his local system/virtual machine system. I am not responsible for any damage caused to the individual's operating system files.
