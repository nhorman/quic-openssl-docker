#!/bin/bash

# Set up the routing needed for the simulation
/setup.sh

# The following variables are available for use:
# - ROLE contains the role of this execution context, client or server
# - SERVER_PARAMS contains user-supplied command line parameters
# - CLIENT_PARAMS contains user-supplied command line parameters

if [ "$ROLE" == "client" ]; then
    # Wait for the simulator to start up.
    /wait-for-it.sh sim:57832 -s -t 30
    [ INSERT COMMAND TO RUN YOUR QUIC CLIENT ]
elif [ "$ROLE" == "server" ]; then
    [ INSERT COMMAND TO RUN YOUR QUIC SERVER ]
fi

