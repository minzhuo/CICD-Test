#!/bin/bash

# basic setting 
# Exit immediately if a command exits with a non-zero status: set -e
# Exit immediately if any part of the pipeline fails: set -o pipefail
set -eo pipefail

### function ###
function clean_old_config() {
	if [[ -d "/etc/nginx/sites-available/upstream" ]]; then	
		rm -rf /etc/nginx/sites-available/upstream
	fi

	if [[ -d "/etc/nginx/sites-available/location" ]]; then	
		rm -rf /etc/nginx/sites-available/location
	fi
}

function backup() {
	if [[ -d "/home/nginx_backup" ]]; then	
		rm -rf /home/nginx_backup
	fi

	mkdir /home/nginx_backup

	if [[ -d "/etc/nginx/sites-available/upstream" ]]; then	
		cp -rf /etc/nginx/sites-available/upstream /home/nginx_backup/upstream
		echo "nginx backup is located in /home/nginx_backup"
	else
		echo "Can not find upstream folder, skip backup upstream"
	fi

	if [[ -d "/etc/nginx/sites-available/location" ]]; then	
		cp -rf /etc/nginx/sites-available/location /home/nginx_backup/location
		echo "nginx backup is located in /home/nginx_backup"
	else
		echo "Can not find location folder, skip backup location"
	fi
}

function main() {
	#service nginx stop
	backup
	clean_old_config
}

### workflow: stop nginx and clean the old config files
echo "Stop the nginx service and clean the old config files." 
main 
echo "Done."