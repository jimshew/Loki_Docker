#/bin/bash

LOKI_FILE="loki_0.3.1_amd64.deb"

APT_FLAGS="-q -y --no-install-recommends"
DEBIAN_FRONTEND=noninteractive

echo "* Install dependency"
install_packages \
	libdumbnet1 python-libpcap python-gtk2 python-dumbnet python-ipy python-glade2 python-urwid \
	iptables bridge-utils \
	ifupdown \
	vim \
	wget

echo "* Get known-good dpkt"
wget --quiet --no-check-certificate https://launchpad.net/ubuntu/+source/python-dpkt/1.8.r98-0.1/+build/8368756/+files/python-dpkt_1.8.r98-0.1_all.deb
echo "* Get ${LOKI_FILE}"
wget --quiet --no-check-certificate https://github.com/jimshew/Loki_Docker/raw/master/${LOKI_FILE}
echo "* Install ${LOKI_FILE}"
dpkg -i ${LOKI_FILE}

echo "* Configure loki"

# used by loki :
mkdir -p /root/.local/share

# update file with mac vendor :
wget --quiet --no-check-certificate https://github.com/wireshark/wireshark/raw/master/manuf -O mac_vendor.txt
grep --extended-regexp --ignore-case '^[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}[[:space:]]' mac_vendor.txt | awk '{print $1 " " $2}' | tr ':' '-' > /usr/share/loki/modules/mac.txt
rm mac_vendor.txt

echo "* Cleaning"

# remove unnecessary :
rm ./${LOKI_FILE}
apt-get ${APT_FLAGS} purge wget

# clean :
apt-get ${APT_FLAGS} autoremove
apt-get ${APT_FLAGS} clean
rm -r /var/lib/apt/lists /var/cache/apt/archives
find /var/log/ -type f -exec truncate -s 0 \{\} \;
# last clean :
rm $(basename $0)
