FROM martenseemann/quic-network-simulator-endpoint:latest

# Install needed tools
RUN apt-get update && apt-get install -y git make gcc perl

# download and build your QUIC implementation
RUN git clone https://github.com/openssl/openssl.git

RUN cd openssl && ./Configure enable-demos enable-fips --prefix=/usr --openssldir=/etc/pki/tls \
    && make -j && make install

# install the quic client binaries
RUN cp /openssl/demos/guide/quic-client-block /usr/bin && \
    cp /openssl/demos/guide/quic-client-non-block /usr/bin


# Set the environment variable LD_LIBRARY_PATH to ensure we get the right libraries
ENV LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH

# copy run script and run it
COPY run_endpoint.sh .
RUN chmod +x run_endpoint.sh
ENTRYPOINT [ "./run_endpoint.sh" ]

