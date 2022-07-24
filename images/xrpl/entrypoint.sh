#!/usr/bin/env sh

# Start rippled, Passthrough other arguments
exec /opt/ripple/bin/rippled --conf /etc/opt/ripple/rippled.cfg "$@"
