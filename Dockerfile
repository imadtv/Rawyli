# Restreamer + Tailscale (متوافق مع Alpine و Railway)
FROM datarhei/restreamer:latest

# تثبيت المتطلبات الأساسية و tailscale مباشرة من المستودع الرسمي
RUN apk add --no-cache curl iproute2 bash tailscale

# وضع مفتاح Tailscale (يمكن تغييره أو تمريره من Secrets)
ENV TAILSCALE_AUTHKEY="tskey-auth-kQJR2kp6FY11CNTRL-sysAHSYrU45tkSez9qGS55j9KAnvn5W7W"

# فتح المنافذ المطلوبة
EXPOSE 8080 8181 1935 1936 6000/udp

# تشغيل tailscaled ثم Restreamer
CMD bash -c "\
  mkdir -p /var/run/tailscale && \
  tailscaled --state=/tmp/tailscaled.state & \
  sleep 5 && \
  tailscale up --authkey \"${TAILSCALE_AUTHKEY}\" --accept-routes --accept-dns && \
  exec /app/restreamer \
"
