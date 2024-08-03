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
    export SSL_CERTS_DIR=/certs
    echo "TESTCASE is $TESTCASE"
    case "$TESTCASE" in
    "http3")
        echo "Running HTTP3 Client"
        ossl-nghttp3-demo $CLIENT_PARAMS
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

