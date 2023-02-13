#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

	mkdir -p /var/www/html

	cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
	mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

	# Add the FTP_USER, change his password and declare him as the owner of wordpress folder and all subfolders
	adduser ${FTP_USER} --disabled-password
	echo "${FTP_USER}:${FTP_PASS}" | /usr/sbin/chpasswd &> /dev/null
	chown -R ${FTP_USER}:${FTP_USER} /var/www/html

	echo ${FTP_USER} | tee -a /etc/vsftpd.userlist &> /dev/null

fi

echo "FTP started on :21"
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
