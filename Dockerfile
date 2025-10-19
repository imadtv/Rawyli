# Restreamer + Tailscale (متوافق مع Alpine و Railway)
FROM datarhei/restreamer:latest

# تثبيت المتطلبات الأساسية و tailscale مباشرة من المستودع الرسمي
RUN apk add --no-cache curl iproute2 bash tailscale

# وضع مفتاح Tailscale الجديد
ENV TAILSCALE_AUTHKEY="tskey-auth-kn79VYRC8i11CNTRL-vMkgabScvtd9rSv3q5zitd9x78nBjRwRF"

# فتح المنافذ المطلوبة
EXPOSE 8080 8181 1935 1936 6000/udp

# تشغيل tailscaled في userspace-networking (ليعمل بدون صلاحيات root)
CMD bash -c "\
  mkdir -p /var/run/tailscale && \
  tailscaled --tun=userspace-networking --state=/tmp/tailscaled.state & \
  sleep 8 && \
  tailscale up --authkey=\"${TAILSCALE_AUTHKEY}\" --hostname=restreamer --accept-dns=false && \
  tailscale serve http / 8080 && \
  exec /app/restreamer \
"
