# Packet Filter file configuration and some tables and scripts
🎯 This repository hosts a file configuration of Packet Filter on [OpenBSD](https://www.openbsd.org)

📝 Here the [man](https://man.openbsd.org/pf.conf) for the Packet Filter service configuration file.

🛡️ Secure your network home or a standalone server and reduce the noisy traffic.

## Prerequisites
 * You need to have an account with doas set correctly.

## Usage


## RAW Tables
* pf-810ck-81u3734m.pft raw list of all IP's coming from my own honeypot analysis.
  * block in/out

## Scripts
* pf-810ck-f4c3800k.sh create a raw list of all IP's under Facebook's AS.
  * block out

## Blueteam - Check new settings
* You can check through `pfctl` the statitics or the log of pflog0
  * `pfctl -vvs Tables`

🐡 Have fun!
