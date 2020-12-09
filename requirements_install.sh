#!/usr/bin/env bash

# Install dependencies
sudo apt update && sudo apt install gcc g++ make gdb libssl-dev zlib1g-dev -y

# Install python
sudo apt install python3-pip python3-venv -y

# Install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
~/.rbenv/bin/rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

# Install rbenv-build
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Install nodenv
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src
echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc
~/.nodenv/bin/nodenv init
echo 'eval "$(nodenv init -)"' >> ~/.bashrc
exec $SHELL

# Install nodenv-build
mkdir -p "$(nodenv root)"/plugins
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

# Install postgresql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-12 libpq-dev

# create postgresql superuser
sudo -u postgres bash -c "psql -c \"CREATE USER $(whoami) WITH ENCRYPTED PASSWORD '$(whoami)' SUPERUSER;\""

# Export postgresql credentials
export DATABASE_USERNAME="$(whoami)"
export DATABASE_PASSWORD="$(whoami)"
