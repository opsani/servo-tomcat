#!/bin/bash

set -x

# Download external Opsani dependencies
curl -s -O https://raw.githubusercontent.com/opsani/servo/master/adjust.py
curl -s -O https://raw.githubusercontent.com/opsani/servo/master/measure.py
curl -s -O https://raw.githubusercontent.com/opsani/servo/master/servo

# Make servo executable
chmod +x servo

# Install init script
systemctl daemon-reload
systemctl enable optune-servo



