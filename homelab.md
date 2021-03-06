# HomeLab Notes
## Objectives
- Reduce VPS cost
- Add security to personal selfhosted services via VPN ()
- Simplify re-deployment and improve independency
- Automatic Maintenance and Notification

# Requirements

## Equipment
ℹ️ [local]
- Perseverance - Main Server
  - CPU:
  - RAM: 16 GB
  - OS: Debian
  - Storage:
- Curiosity - RaspberryPi 4
  - CPU:
  - RAM: 4 GB
  - OS: Debian - 64 GB SSD
  - Storage: RAID1 - 120 GB SSD
- Possibility: Another RaspberryPi 4

ℹ️ [remote]
- Opportunity - Main VPS - Linode
  - CPU:
  - RAM: 1 GB
  - OS: Debian - 10GB SSD
  - Storage:
- Pathfinder - VPS - Hetznet
  - CPU:
  - RAM: 4 GB
  - OS:
  - Storage:

## PoC
ℹ️ [remote]
- Opportunity - Main VPS
  - Docker:
    - [ ] VPN Server - OpenVPN
    - :heavy_check_mark: Budget - FireflyIII
    - :heavy_check_mark: Wiki - DokuWiki
    - :heavy_check_mark: Website - Wordpress3
    - :heavy_check_mark: Books - Ubooquity
    - :heavy_check_mark: Container Manager - Portainer
    - [ ] Project Management - Leantime
    - :heavy_check_mark: Reverse Proxy - Traefik
    - :heavy_check_mark: PP - Travel Map

- Pathfinder - VPS - Hetznet
  - Docker:
    - :heavy_check_mark: Game Server - Valheim

ℹ️ [local]
- Curiosity - RaspberryPi 4
  - Docker:
    - [ ] PRM - Monica
    - [ ] VPN Client - OpenVPN
    - [ ] Configuration Management - Ansible
    - [ ] Git - Git
    - [ ] DNS Server -
    - [ ] Reverse Proxy - Traefik
    - [ ] (Synced from Opportunity) Budget - FireflyIII
    - [ ] (Synced from Opportunity) Wiki - DokuWiki
    - [ ] (Synced from Opportunity) Website - Wordpress3
    - [ ] (Synced from Opportunity) Books - Ubooquity
    - [ ] (Synced from Opportunity) Container Manager - Portainer
    - [ ] (Synced from Opportunity) Project Management - Leantime
    - [ ] (Synced from Opportunity) PP - Travel Map

- Perseverance - Main Server
  - VM:
    - [ ] NAS - TrueCore

## Usage
- [ ] Opportunity serves public available services eg: Website, Wiki, VPN Server
- [ ] Opportunity connects Client via VPN to Curiosity for serving private services eg: Budget, Git, PRM
- [ ] Perseverance serves files to local network

## Backup
- [ ] Curiosity pulls from Opportunity
- [ ] Perseverance pulls from Curiosity
- [ ] Perseverance pushes to BackBlaze B2 / Google Drive
