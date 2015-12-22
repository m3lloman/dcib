#!/bin/bash

. ../config.local

service mysqld stop
rm -rf /var/lib/mysql
service mysqld start

mysql -u ${DBUSER}  << EOF
UPDATE mysql.user SET Password = PASSWORD('${DBPASS}') WHERE User = '${DBUSER}';
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
EOF
