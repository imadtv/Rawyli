# Dockerfile واحد: Restreamer + TailScale (متوافق مع Alpine)
FROM datarhei/restreamer:latest

# تثبيت الأدوات المطلوبة و TailScale
RUN apk add --no-cache curl iproute2 bash && \
    curl -fsSL https://tailscale.com/install.sh | sh

# AuthKey ثابت (يمكنك تغييره)
ENV TAILSCALE_AUTHKEY="tskey-auth-kQJR2kp6FY11CNTRL-sysAHSYrU45tkSez9qGS55j9KAnvn5W7W"

# فتح المنافذ المطلوبة
EXPOSE 8080 8181 1935 1936 6000/udp

# تشغيل TailScale ثم Restreamer
CMD bash -c "\
  tailscaled & \
  sleep 5 && \
  tailscale up --authkey \"${TAILSCALE_AUTHKEY}\" --accept-routes --accept-dns && \
  exec /app/restreamer \
"
