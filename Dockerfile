FROM debian:buster-slim

WORKDIR /goatcounter

ENV GOATCOUNTER_LISTEN '0.0.0.0:8080'
ENV GOATCOUNTER_DB 'sqlite:///goatcounter/db/goatcounter.sqlite3'
ENV GOATCOUNTER_SMTP ''

RUN apt-get update \
  && apt-get install -y ca-certificates \
  && update-ca-certificates --fresh


ARG GOATCOUNTER_VERSION=
ARG PLATFORM_ARCH=amd64

RUN if [ -z $GOATCOUNTER_VERSION ]; then echo "Finding latest Goatcounter Version..."; GOATCOUNTER_VERSION=$(curl -s "https://github.com/zgoat/Goatcounter/releases/latest/download" 2>&1 | sed "s/^.*download\/\([^\"]*\).*/\1/"); else echo "Goatcounter version passed in build argument v${GOATCOUNTER_VERSION}"; fi && \
    echo "Downloading Goatcounter v${GOATCOUNTER_VERSION}..." && \
    curl -sLo "/usr/bin/goatcounter" "https://github.com/zgoat/goatcounter/releases/download/${GOATCOUNTER_VERSION}/goatcounter-${GOATCOUNTER_VERSION}-${PLATFORM_ARCH}" && \
    chmod a+x /usr/bin/goatcounter

COPY --from=build /go/goatcounter/goatcounter /usr/bin/goatcounter

EXPOSE 8080


CMD ["/usr/bin/goatcounter"]
