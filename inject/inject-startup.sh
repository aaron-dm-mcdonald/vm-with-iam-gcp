#!/bin/bash

# Install Apache2
apt update
apt install -y apache2

# Start and enable Apache on boot
systemctl start apache2
systemctl enable apache2

# Create the web root directory if it doesn't exist
mkdir -p /var/www/html

# Download HTML template and image from the bucket
gcloud storage cp gs://gen-storage-aaron-mcd/inject/inject-html.html /tmp/inject-html.html
gcloud storage cp gs://gen-storage-aaron-mcd/static-xavier/cambodian-1.jpg /var/www/html/cambodian-1.jpg

# Fetch instance metadata from GCP metadata server
METADATA_URL="http://metadata.google.internal/computeMetadata/v1"
METADATA_HEADER="Metadata-Flavor: Google"

local_ipv4=$(curl -H "$METADATA_HEADER" -s "$METADATA_URL/instance/network-interfaces/0/ip")
zone=$(curl -H "$METADATA_HEADER" -s "$METADATA_URL/instance/zone")
project_id=$(curl -H "$METADATA_HEADER" -s "$METADATA_URL/project/project-id")
hostname_fqdn=$(hostname -f)

# Replace placeholders in the HTML template with actual metadata values
cat /tmp/inject-html.html | sed \
  -e "s|<!--LOCAL_IPV4-->|$local_ipv4|g" \
  -e "s|<!--ZONE-->|$zone|g" \
  -e "s|<!--PROJECT_ID-->|$project_id|g" \
  -e "s|<!--HOSTNAME-->|$hostname_fqdn|g" \
  > /var/www/html/index.html
