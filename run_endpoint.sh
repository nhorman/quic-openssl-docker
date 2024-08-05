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
        OUTOPTS=""
        for i in $REQUESTS
        do
            OUTFILE=$(basename $i)
            OUTOPTS="$OUTOPTS -o /downloads/$OUTFILE "
        done
        SSL_CERT_FILE=/certs/ca.pem curl --verbose --parallel --http3-only $OUTOPTS $REQUESTS 
        if [ $? -ne 0 ]
        then
            exit 1
        fi
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

