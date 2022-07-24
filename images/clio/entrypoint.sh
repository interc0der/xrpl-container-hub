#!/usr/bin/env sh

# Start clio, Passthrough other arguments
exec /opt/clio/bin/clio_server /opt/clio/config.json "$@"
