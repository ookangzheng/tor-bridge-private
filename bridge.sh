#!/usr/bin/env bash

echo "Updating server..."
apt update
apt full-upgrade -y

echo "Adding gpg"
apt install -y dirmngr
gpg --keyserver keys.gnupg.net --recv $TOR_PUBLIC_KEY
gpg --export $TOR_PUBLIC_KEY | apt-key add -

echo Adding Tor repositories...
rm -f /etc/apt/sources.list.d/tor.list 2> /dev/null
rm -f /etc/apt/sources.list.d/tor.list.save 2> /dev/null
echo "deb http://deb.torproject.org/torproject.org $(lsb_release -cs) main" > /etc/apt/sources.list.d/tor.list
echo "deb-src http://deb.torproject.org/torproject.org $(lsb_release -cs) main" >> /etc/apt/sources.list.d/tor.list

echo Installing Tor bridge...
apt update
apt install -y tor tor-geoipdb deb.torproject.org-keyring obfs4proxy
