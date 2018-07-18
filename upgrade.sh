#!/bin/bash

set -x

# Stop service
systemctl stop optune-servo

# Download external Opsani dependencies
curl -s -O https://raw.githubusercontent.com/opsani/servo/master/adjust.py
curl -s -O https://raw.githubusercontent.com/opsani/servo/master/measure.py
curl -s -O https://raw.githubusercontent.com/opsani/servo/master/servo

# Make servo executable
chmod +x servo

# Pull latest drivers
git pull

# Start service
systemctl start optune-servo
