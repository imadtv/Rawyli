FROM datarhei/restreamer:latest

RUN apk add --no-cache curl iproute2 bash tailscale

ENV TAILSCALE_AUTHKEY="tskey-auth-kQJR2kp6FY11CNTRL-sysAHSYrU45tkSez9qGS55j9KAnvn5W7W"

EXPOSE 8080 8181 1935 1936 6000/udp

CMD bash -c "\
  mkdir -p /var/run/tailscale && \
  tailscaled --tun=userspace-networking --state=/tmp/tailscaled.state & \
  sleep 8 && \
  tailscale up --authkey=\"${TAILSCALE_AUTHKEY}\" --hostname=restreamer --accept-dns=false && \
  tailscale serve http / 8080 && \
  exec /app/restreamer \
"
