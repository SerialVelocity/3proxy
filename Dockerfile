FROM alpine:3.11 AS build

ARG APP_VERSION

RUN apk add --no-cache curl gcc libc-dev linux-headers make

RUN curl -sSL --fail https://github.com/z3APA3A/3proxy/archive/${APP_VERSION}.tar.gz | tar xz

RUN cd /3proxy-${APP_VERSION} && \
    make -f Makefile.Linux && \
    make -f Makefile.Linux DESTDIR=/3proxy install-bin install-etc



FROM alpine:3.11

COPY --from=build /3proxy/ /

ENTRYPOINT ["/usr/local/bin/3proxy"]
CMD ["/usr/local/etc/3proxy/3proxy.cfg"]
