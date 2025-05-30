#!/bin/bash
# Update and install Apache2
apt update
apt install -y apache2

# Start and enable Apache2
systemctl start apache2
systemctl enable apache2

# Create web root
mkdir -p /var/www/html

# Download files from GCP bucket 
gcloud storage cp gs://gen-storage-aaron-mcd/static-xavier/index.html /var/www/html/index.html
gcloud storage cp gs://gen-storage-aaron-mcd/static-xavier/styles.css /var/www/html/styles.css
gcloud storage cp gs://gen-storage-aaron-mcd/static-xavier/script.js /var/www/html/script.js

