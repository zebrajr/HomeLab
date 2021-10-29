### Info
This script assume a UEFI setup
### Useful Commands
Check if there is an Internet Connection
Wired:
```
ip addr show
```
WifI
```
iwctl
```
Commands for iwctl

| Command | Description |
|---|---|
|``` device list ```|Obtain a list of Wifi devices in your system:
|``` station <device> scan ``` |Scan for wireless access points
|``` station <device> get-networks ```|View a list of detected networks|
|``` station <device> connect <wireless-network-name> ```|Connect to a wireless network|
