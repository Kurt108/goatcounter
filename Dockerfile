FROM debian:buster-slim

WORKDIR /goatcounter

ENV GOATCOUNTER_LISTEN '0.0.0.0:8080'
ENV GOATCOUNTER_DB 'sqlite:///goatcounter/db/goatcounter.sqlite3'
ENV GOATCOUNTER_SMTP ''

RUN apt-get update \
  && apt-get install -y ca-certificates curl \
  && update-ca-certificates --fresh


ARG GOATCOUNTER_VERSION=v2.0.4
ARG PLATFORM_ARCH=linux-amd64

RUN echo "Downloading Goatcounter v${GOATCOUNTER_VERSION}..." && \
    echo "https://github.com/zgoat/goatcounter/releases/download/${GOATCOUNTER_VERSION}/goatcounter-${GOATCOUNTER_VERSION}-linux-${PLATFORM_ARCH}"  && \
    curl -sLo "/usr/local/bin/goatcounter.gz" "https://github.com/zgoat/goatcounter/releases/download/${GOATCOUNTER_VERSION}/goatcounter-${GOATCOUNTER_VERSION}-${PLATFORM_ARCH}.gz" && \
    gunzip /usr/local/bin/goatcounter.gz && \
    chmod a+x /usr/local/bin/goatcounter



EXPOSE 8080


CMD ["/usr/local/bin/goatcounter"]
