#!/usr/bin/env sh

# Start clio, Passthrough other arguments
exec ./opt/clio/clio_server ./cfg/config.json "$@"
