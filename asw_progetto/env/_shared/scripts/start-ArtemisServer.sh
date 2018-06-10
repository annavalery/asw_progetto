cd /var/lib/
sudo ${ARTEMIS_HOME}/bin/artemis create server --user admin --password admin --allow-anonymous
cd /server/bin
sudo ./artemis-service start
exit 0 