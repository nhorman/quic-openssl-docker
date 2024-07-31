FROM martenseemann/quic-network-simulator-endpoint:latest

# Install needed tools
RUN apt-get update && apt-get install -y git make gcc perl cmake build-essential

# download and build your QUIC implementation
RUN git clone https://github.com/nhorman/openssl.git

RUN cd openssl && git checkout http3-demo-options && \
    ./Configure enable-demos enable-h3demo enable-fips --prefix=/usr --openssldir=/etc/pki/tls && \
    make -j && make install && cp demos/guide/quic-client-block /usr/local/bin && \
    cp demos/guide/quic-client-non-block /usr/local/bin && \
    cp demos/http3/ossl-nghttp3-demo /usr/local/bin

# Set the environment variable LD_LIBRARY_PATH to ensure we get the right libraries
ENV LD_LIBRARY_PATH=/usr/lib64:/openssl/demos/http3:$LD_LIBRARY_PATH

# copy run script and run it
COPY run_endpoint.sh .
RUN chmod +x run_endpoint.sh
ENTRYPOINT [ "./run_endpoint.sh" ]

