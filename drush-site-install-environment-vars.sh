#!/bin/bash

# Makes script exit immediately when an exit code > 0 is hit.
set -e
# Read environment variables into script variables.

# Database host.
if [ -n "$DBHOST" ]; then
  db_host=$DBHOST
else
  echo "ERROR: DB host environment variable must be set"
  exit 1
fi

# Database User.
if [ -n "$DBUSER" ]; then
  db_user=$DBUSER
else
  echo "ERROR: DB user environment variable must be set"
  exit 1
fi

# Database name.
if [ -n "$DBNAME" ]; then
  db_name=$DBNAME
else
  echo "ERROR: DB name environment variable must be set"
  exit 1
fi

# Database password.
if [ -n "$DBPASS" ]; then
  db_password=$DBPASS
fi

if [ -n "$DBPASS_FILE" ]; then
  db_password=`cat $DBPASS_FILE`
fi

if [ -z "$db_password" ]; then
  echo "ERROR: DB password must be set"
  exit 1
fi

# Site admin name.
if [ -n "$DNAME" ]; then
  d_name=$DNAME
else
  echo "ERROR: Drupal site admin name environment variable must be set"
  exit 1
fi

# Site admin password.
if [ -n "$DPASS" ]; then
  d_password=$DPASS
fi

if [ -n "$DPASS_FILE" ]; then
  d_password=`cat $DPASS_FILE`
fi

if [ -z "$d_password" ]; then
  echo "ERROR: Drupal site admin password must be set"
  exit 1
fi

# Drupal site name.
if [ -n "$DSITENAME" ]; then
  d_sitename=$DSITENAME
else
  echo "ERROR: Druplal site name environment variable must be set"
  exit 1
fi

# Drupal site email.
if [ -n "$DSITEEMAIL" ]; then
  d_siteemail=$DSITEEMAIL
else
  echo "ERROR: Drupal site email environment variable must be set"
  exit 1
fi

# This determines the location of this script.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -z "${DELETESETTING// }" ]]; then
  DELETESETTING="no"
fi

if [[ "$DELETESETTING" = "yes" ]] ; then
  chmod -R 777 ${DIR}/web/sites/default/
  rm ${DIR}/web/sites/default/settings.php
fi

# Composer install is run as this will load what is in the composer.lock.

composer install --no-dev

drush site-install standard -y \
--site-name=$d_sitename \
--site-mail=$d_siteemail \
--account-name=$d_name \
--account-pass=$d_password \
--account-mail=$d_siteemail \
--db-url=mysql://$db_user:$db_password@$db_host/$db_name ;

# Cleanup and delete text files to prevent easy "finger printing" of the site.
rm ${DIR}/web/INSTALL.txt
rm ${DIR}/web/README.txt
rm ${DIR}/web/core/CHANGELOG.txt
rm ${DIR}/web/core/COPYRIGHT.txt
rm ${DIR}/web/core/INSTALL.mysql.txt
rm ${DIR}/web/core/INSTALL.pgsql.txt
rm ${DIR}/web/core/INSTALL.sqlite.txt
rm ${DIR}/web/core/INSTALL.txt
rm ${DIR}/web/core/MAINTAINERS.txt
rm ${DIR}/web/core/UPDATE.txt

# Rename the License file to stay compliant but not easily found.
mv ${DIR}/web/core/LICENSE.txt ${DIR}/web/core/license-file.txt

echo "Optimize Composer Autoloader"
cd ${DIR}
composer dump-autoload --optimize
echo "Cleaning all caches."
# Last minute cleanse.
drush cr
