#!/bin/bash

sudo service mysql start

sudo service munge start

sudo service slurmdbd start

sudo service slurmctld start

tail -f /dev/null
