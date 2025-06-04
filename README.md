# 🛡️ Suricata-Testing 🛡️

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![GitHub issues](https://img.shields.io/github/issues/user/repo.svg)](https://GitHub.com/user/repo/issues/)

## 🎯 Objective
Setup Suricata in IDS mode (and IPS if needed) to protect a simulated industrial network.

## 🌐 Network structure
     +-----+         +-----+   +-----+
     |  A  |         |  B  |   |  U  |
     +-----+         +-----+   +-----+ 
         \             /         /
          \           /---------
           \         /
             +-----+           +-----+
             |  S  | --------- |  M  |
             +-----+           +-----+
                ⇅            /
          .~~~~~~~~~~~.     /
       .~~   INTERNET   ~~.
      '~~~~~~~~~~~~~~~~~~~'

S is the main router and sniffs the forwarded packets to find potential threats using Suricata. The ruleset is defined in `custom.rules`. To use it, you need to uncomment "suricata-update" in `start.sh`.

## 🚀 How to Run
1.  **Build and start the services:**
    ```bash
    make
    ```
    Alternatively, you can use Docker Compose directly:
    ```bash
    docker-compose up -d --build
    ```
2.  **Access the GUI:**
    The GUI is accessible at http://localhost:3000

## 🧪 Tests
The scripts to run from the Malicious container (M) are in the `scripts/` folder. These scripts should make requests to the internal network for Suricata to see the traffic. `U` is an unauthorized host, and its requests will be flagged with the current rules.

## 📊 GUI
The GUI is accessible at http://localhost:3000.

The data is from Elasticsearch. To create the dashboard:
1.  Make a new connection to an Elasticsearch origin: `http://elasticsearch:9200`
2.  Create the dashboard from there.

## 📜 License
This project is licensed under the GNU Affero General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
