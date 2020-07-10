FROM wyrihaximusnet/github-actions-alpine:3

COPY entrypoint.sh /workdir/entrypoint.sh

ENTRYPOINT ["/workdir/entrypoint.sh"]
