FROM martenseemann/quic-network-simulator-endpoint:latest

# download and build your QUIC implementation
# [ DO WORK HERE ]

# copy run script and run it
COPY run_endpoint.sh .
RUN chmod +x run_endpoint.sh
ENTRYPOINT [ "./run_endpoint.sh" ]

