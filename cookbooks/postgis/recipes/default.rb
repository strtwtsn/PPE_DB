package "libxml2-dev"


# Download Postgis binary

remote_file "/usr/local/src/postgis-2.0.2.tar.gz" do
source "http://postgis.refractions.net/download/postgis-2.0.2.tar.gz"
end

bash "Extract and install Postgis" do
user "root"
cwd "/usr/local/src"
code <<-EOH
export PATH="$PATH:/usr/local/pgsql/bin"
tar xvzf postgis-2.0.2.tar.gz
cd postgis-2.0.2
./configure
make
checkinstall --pkgname postgis --pkgversion 2.0.2-src --default
EOH
end

bash "configure postgis" do
user "root"
code <<-EOH
ldconfig

sudo -u postgres createdb -T template0 -O postgres -U postgres -E UTF8 template_postgis
sudo -u postgres createlang plpgsql -U postgres -d template_postgis
sudo -u postgres psql -d template_postgis -U postgres -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -d template_postgis -U postgres -c "CREATE EXTENSION postgis_topology;"
sudo -u postgres psql -d template_postgis -U postgres < /usr/local/src/postgis-2.0.2/postgis/legacy.sql
sudo -u postgres psql -d postgres -U postgres -c "CREATE USER ppe"
sudo -u postgres psql -d postgres -U postgres -c "ALTER USER ppe WITH SUPERUSER CREATEDB REPLICATION;"
EOH
end

