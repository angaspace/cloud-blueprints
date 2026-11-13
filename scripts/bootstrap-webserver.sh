#!/bin/bash
# Anga Space - Automated Web Server Bootstrap (EC2 User Data)
# Tested on: Amazon Linux 2023 (see TESTING.md)
set -euo pipefail

dnf update -y
dnf install -y httpd
systemctl enable --now httpd
echo "<h1>Hosted securely by Anga Space</h1>" > /var/www/html/index.html
