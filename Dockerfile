FROM alpine:3.19

RUN apk update && apk add \
    nodejs \
    gcc g++ cmake make \
    tmux dropbear bash \
    linux-headers

WORKDIR /workdir

COPY badvpn-src/ ./badvpn-src
COPY proxy3.js ./
COPY run.sh ./

WORKDIR /workdir/badvpn-src/build
RUN cmake .. \
    -DBUILD_NOTHING_BY_DEFAULT=1 \
    -DBUILD_TUN2SOCKS=1 \
    -DBUILD_UDPGW=1 \
    -DCMAKE_BUILD_TYPE=Release \
    && make -j2 install

WORKDIR /workdir
RUN rm -rf badvpn-src && chmod +x run.sh

EXPOSE 8080

CMD ["./run.sh"]
