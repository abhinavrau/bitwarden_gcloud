#!/bin/ash
trap 'kill -TERM $PID' TERM INT
echo "Starting Tailscale daemon"
# -state=mem: will logout and remove ephemeral node from network immediately after ending.
tailscaled --tun=userspace-networking --statedir=${TAILSCALE_STATE_DIR} --state=${TAILSCALE_STATE_ARG} &
PID=$!
until tailscale up --authkey="${TAILSCALE_AUTH_KEY}" --hostname="${TAILSCALE_HOSTNAME}"; do
    sleep 0.1
done
tailscale serve / proxy ${TS_PORT:-8080}

echo "---------Starting Tailscale proxy----------"
caddy run \
        --config /etc/caddy/Caddyfile \
        --adapter caddyfile

tailscale status
wait ${PID}
wait ${PID}

