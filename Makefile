# Copyright benoit.gregoire@savoirfairelinux.com, GPL v3 licence
# Allows managing deployement of a drupal site efficiently

# Project name
project_name := artdoeuvre
# Databases names
db_names := artdoeuvre_website

# Databases user
db_user_var := "art_doeuvre"
db_password_var := "DoKah2Ah"
keep_num_days_of_backup := 3
date_var := "$(shell date --rfc-3339=seconds)"

## You should not have to modify anything below this line!

# Variables declaration
dump_filename = sql/dumps/$(date_var)_$${db_name}_database_dump.sql

db_git_filename = sql/$${db_name}_database_git.sql

db_backup_filename = sql/$(date_var)_$${db_name}_database_backup.sql

# Directory where to save databases backups
backup_dir := ../backups

backup_filename_nodir = $(date_var)_$(project_name)_full_backup.tar.gz

backup_filename = $(backup_dir)/$(backup_filename_nodir)

latest_backup_symlink = $(backup_dir)/$(project_name)_latest_backup.tar.gz

default:
	@echo "Lire le makefile pour les targets"

.PHONY: setup
setup: initial_setup update_db

fix_permissions:
	#chown -R www-data public_html/sites/default
	#chmod g+rw -R public_html/sites/default

initial_setup:
	echo "Setting up initial db and environment:"
	-mysql -u root -p --execute="CREATE USER '$(db_user_var)'@'localhost' IDENTIFIED BY '$(db_password_var)';"
	for db_name in $(db_names); do \
	  mysql -u root -p --execute="CREATE DATABASE $${db_name} CHARACTER SET 'utf8';" ; \
	  mysql -u root -p --execute="GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES ON $${db_name}.* TO '$(db_user_var)'@'localhost';" ; \
	done ;

dump: cleanup
	mkdir -p sql/dumps
	#set -x ; \
	for db_name in $(db_names); do \
	  mysqldump -u $(db_user_var) -p$(db_password_var) $${db_name} > $(dump_filename) ; \
	done ;

update_db: dump fix_permissions
	@echo "Updating db from git:"
	#set -x ; \
	for db_name in $(db_names); do \
	  mysql -u $(db_user_var) -p$(db_password_var) $${db_name} < $(db_git_filename) ; \
	done ;

commit_db: dump fix_permissions
	@echo "Creating new snapshot for git:"
	#set -x ; \
	for db_name in $(db_names); do \
	  mv $(dump_filename) $(db_git_filename) ; \
	done ;
	git commit sql/*.sql -m "Commited new database snapshot"

cleanup:
	find ./sql/dumps/ -name '*.sql' -mtime +$(keep_num_days_of_backup) -exec rm {} \;
	find $(backup_dir) -name '*.tar.gz' -mtime +$(keep_num_days_of_backup) -exec rm {} \;

.PHONY: backup
backup: dump fix_permissions
	git repack -d
	mkdir -p $(backup_dir)
	#set -x ; \
	for db_name in $(db_names); do \
	  cp $(dump_filename) $(db_backup_filename) ; \
	done ;
	tar --exclude-from=backup_exclude_file.txt -zcf $(backup_filename) ./ ; \
	ln -sf $(backup_filename_nodir) $(latest_backup_symlink) ; \
	#set -x ; \
	for db_name in $(db_names); do \
	  rm $(db_backup_filename) ; \
	done ;
