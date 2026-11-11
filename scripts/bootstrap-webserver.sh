#!/bin/bash
# Anga Space - Automated Web Server Bootstrap
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hosted securely by Anga Space</h1>" > /var/www/html/index.html
