#!/usr/bin/env bash

OS_VERSION=$(sw_vers -productVersion | cut -d'.' -f 1-2)

touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line *.* version $OS_VERSION" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
softwareupdate -i "$PROD" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

curl https://bootstrap.pypa.io/get-pip.py | python
pip install ansible