FROM alpine:3.10

RUN apk add --no-cache jq curl bash

RUN mkdir /workdir
COPY entrypoint.sh /workdir/entrypoint.sh
WORKDIR /workdir

ENTRYPOINT ["/workdir/entrypoint.sh"]
