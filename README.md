# Drupal Automation Scripts
Collection of shell scripts to perform various functions to automate Drupal things.

# Environment Variable Install
List of variables to set to use `drush-site-install-environment-vars.sh`. You can either set the DB password or pass a file such as a Docker secret. Same applies to the site admin password.
- `DBHOST` Database host
- `DBUSER` Database user
- `DBNAME` Database name
- `DBPASS` Database password
- `DBPASS_FILE` Database password file
- `DNAME` Drupal site admin username
- `DPASS` Drupal site admin password
- `DPASS_FILE` Drupal site admin password file
- `DSITENAME` Drupal site name
- `DSITEEMAIL` Drupal site email adddress
- Optional: `DELETESETTING=yes` to delete the settings file on init

For easy copying:
```
DBHOST 
DBUSER
DBNAME
DBPASS
DBPASS_FILE
DNAME
DPASS
DPASS_FILE
DSITENAME
DSITEEMAIL
DELETESETTING=yes
```