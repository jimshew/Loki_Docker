# Loki_Docker
Docker container to run Loki on Linux / Parrot-OS. Loki is a python based infrastructure pentesting tool focussing on layer 3 protocols.

![Gui of loki](./screenshots/Loki_gui_2023-03-12.png)

Originally from Daniel Mende (https://github.com/0xc0decafe and https://c0decafe.de/) and forked from David Ansart's work (https://github.com/Raizo62/Loki_on_Kali) for my own needs:
* Fix OSPF auth HELLO (checksum issue)
* Simplify use for Slingshot
* Future TBD
  
# Installation

## Image

###  Build the container 

```
cd Docker
sudo sh ./build.sh
```

## Launchers

* Copy launchers in /usr/local/sbin :

```
chmod u+x Docker/run_loki_*.sh
sudo cp Docker/run_loki_*.sh /usr/local/sbin
```

# Play

* Start Loki :

```
sudo run_loki_gtk.sh
```
or
```
sudo run_loki_urw.sh
```
or
```
sudo run_loki_bash.sh
# To run loki, use the command "loki_gtk.py"
```

* The shared folder between Loki and the Host is '/tmp'
