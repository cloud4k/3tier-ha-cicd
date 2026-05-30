#!/bin/bash
set -e

dnf update -y
dnf install -y java-21-amazon-corretto wget tar

TOMCAT_VERSION="11.0.9"
TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-11/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"

cd /opt

rm -rf /opt/tomcat11
wget -O tomcat.tar.gz "$TOMCAT_URL"
tar -xzf tomcat.tar.gz
mv apache-tomcat-${TOMCAT_VERSION} tomcat11

useradd -r -U -d /opt/tomcat11 -s /bin/false tomcat || true

chown -R tomcat:tomcat /opt/tomcat11
chmod +x /opt/tomcat11/bin/*.sh

cat > /etc/systemd/system/tomcat.service <<EOT
[Unit]
Description=Apache Tomcat 11
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto"
Environment="CATALINA_PID=/opt/tomcat11/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat11"
Environment="CATALINA_BASE=/opt/tomcat11"

ExecStart=/bin/bash /opt/tomcat11/bin/startup.sh
ExecStop=/bin/bash /opt/tomcat11/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOT

systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat