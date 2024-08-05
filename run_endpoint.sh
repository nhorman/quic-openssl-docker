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
    echo "TESTCASE is $TESTCASE"
    case "$TESTCASE" in
    "http3")
        echo "Running HTTP3 Client"
        cd /downloads
        for i in $REQUESTS
        do
            SSL_CERT_FILE=/certs/ca.pem curl --http3-only $i 
            if [ $? -eq 0 ]
            then
                exit 0
            fi
            exit 1
        done
        exit 0
        ;;
    *)
        echo "UNSUPPORTED TESTCASE $TESTCASE"
        exit 127
        ;;
    esac
elif [ "$ROLE" == "server" ]; then
    echo "UNSUPPORTED"
    exit 127
fi

