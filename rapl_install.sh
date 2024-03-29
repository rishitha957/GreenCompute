#!/usr/bin/env bash
set -e
echo "How do you want to install RAPL Formula ?";
echo "1) pip 2) docker 3) deb";
read;
VAR=${REPLY:-2}
echo "Installing RAPL Formula..."
case $VAR in
    1) pip install rapl_formula;;
    2) docker pull powerapi/rapl-formula;;
    3) echo "Getting RAPL Formula...";
       curl -s https://api.github.com/repos/powerapi-ng/rapl-formula/releases/latest |  grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -;
       echo "Smartwatts downloaded";
       echo "Building...";
       sudo apt install ./python3-rapl-formula_*-1_all.deb || rm python3-rapl-formula_*-1_all.deb;;
    *) echo "Not a valid choice. Installation aborted"; exit 0;;
esac
echo "RAPL formula Installed"
echo "Installing the sensor..."
echo "How do you want to install the sensor (HWPC)"
echo "1) docker 2) deb 3) binary";
read;
VAR=${REPLY:-1}
echo "Installing Sensor..."
case $VAR in
    1) docker pull powerapi/hwpc-sensor;;
    2) echo "Getting HWPC Sensor...";
       curl -s https://api.github.com/repos/powerapi-ng/hwpc-sensor/releases/latest |  grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -;
       echo "HWPC Sensor downloaded";
       echo "Building...";
       sudo apt install ./hwpc-sensor-*.deb || rm hwpc-sensor-*.deb;;
    3)curl -s https://api.github.com/repos/powerapi-ng/hwpc-sensor/releases/latest  |  grep "browser_download_url*" | grep --invert-match ".deb" |  cut -d : -f 2,3 | tr -d \" | wget -qi -;;
    *) echo "Not a valid choice. Installation aborted"; exit 0;;
esac
echo "Sensor Installed"
