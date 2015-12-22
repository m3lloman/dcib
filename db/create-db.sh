#!/bin/bash

. ../config.local

echo "create the database..."
mysql --password="${DBPASS}" --user=${DBUSER} << EOF
CREATE DATABASE IF NOT EXISTS ${DBNAME};
EOF
echo "Database created"

echo ""

echo "create database user (${DCIBUSER}) for selects only.  This user is for the automated update scripts..."
mysql --password="${DBPASS}" --user=${DBUSER} << EOF
create user ${DCIBUSER}@localhost identified by '${DCIBUSERPASS}';
grant select on ${DBNAME}.* to ${DCIBUSER}@localhost;
EOF
echo "done"

echo ""

echo "create admin user (${DCIBADM}) that has full rights to the database..."
mysql --password="${DBPASS}" --user=${DBUSER} << EOF
create user ${DCIBADM}@localhost identified by '${DCIBADMPASS}';
grant all on ${DBNAME}.* to ${DCIBADM}@localhost;
EOF
echo "done"

echo ""

echo "Flush privs..."
mysqladmin --password="${DBPASS}" --user=${DBUSER} flush-privileges
echo "done"

echo ""
mysql --password="${DBPASS}" --user=${DBUSER} --database=${DBNAME} < db-schema.sql
