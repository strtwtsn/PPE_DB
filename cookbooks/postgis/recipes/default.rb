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
createdb -T template0 -O postgres -U postgres -E UTF8 template_postgis
createlang plpgsql -U postgres -d template_postgis
psql -d template_postgis -U postgres -c "CREATE EXTENSION postgis;"
psql -d template_postgis -U postgres -c "CREATE EXTENSION postgis_topology;"
psql -d template_postgis -U postgres < /usr/local/src/postgis-2.0.2/postgis/legacy.sql
psql -d postgres -U postgres -c "CREATE USER ppe"
psql -d postgres -U postgres -c "ALTER USER ppe WITH SUPERUSER CREATEDB REPLICATION;"
ldconfig
EOH
end

