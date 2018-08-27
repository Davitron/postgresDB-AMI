#! /bin/bash

# install postgreSQL
installPG() {
  sudo apt-get update
  sudo apt-get install postgresql postgresql-contrib -y
}

fixPermission() {
  sudo sed -i "s/#listen_address.*/listen_addresses '*'/" /etc/postgresql/9.5/main/postgresql.conf
  sudo rm /etc/postgresql/9.5/main/pg_hba.conf
  sudo cp /tmp/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
}

setupDatabase() {
  echo "/==================================== CREATE DB ==========================/"
  sudo -u postgres createdb eventodb
  echo "/==================================== SET PASSWORD ==========================/"
  sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
  sudo /etc/init.d/postgresql restart
}

main() {
  installPG
  fixPermission
  setupDatabase
}

main