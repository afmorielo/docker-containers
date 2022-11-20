#!/bin/bash

sudo service munge start

jupyter lab --no-browser --allow-root --ip=0.0.0.0

tail -f /dev/null
