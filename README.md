# Drupal Automation Scripts
Collection of shell scripts to perform various functions to automate Drupal things.

## Requirements
You must have drush available as well as composer in order to use these scripts.

# Environment Variable Install
List of variables to set to use `drush-site-install-environment-vars.sh`. This file must be placed at the root directory of the Drupal 8 installation as it is downloaded from Drupal.org. You can either set the DB password or pass a file such as a Docker secret. Same applies to the site admin password. The environment install script as well as others will delete all of the text files that come with Drupal and rename the license file for the purpose of preventing easy "finger printing" of the site. Doing this is a very easy security precaution for any public website.
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
```