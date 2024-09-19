FROM alpine:3

# hadolint ignore=DL3018
RUN apk add --no-cache curl bash git jq

RUN mkdir /workdir
WORKDIR /workdir

COPY entrypoint.sh /workdir/entrypoint.sh

ENTRYPOINT ["/workdir/entrypoint.sh"]
