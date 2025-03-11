#!/usr/bin/env bash

host=$1

share_location=$HOME/share

sshfs $host:rvp-ats $share_location/$host -o idmap=user
