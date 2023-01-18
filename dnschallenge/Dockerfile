FROM caddy:2.6.2-builder AS builder
    RUN xcaddy build --with github.com/caddy-dns/googleclouddns
    FROM caddy:2.6.2
    COPY --from=builder /usr/bin/caddy /usr/bin/caddy

