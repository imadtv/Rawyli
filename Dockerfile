# Dockerfile واحد: Restreamer + TailScale مع AuthKey ثابت
FROM datarhei/restreamer:latest

# تثبيت TailScale
RUN apt-get update && \
    apt-get install -y curl gnupg lsb-release iproute2 && \
    curl -fsSL https://tailscale.com/install.sh | sh

# AuthKey مباشرة
ENV TAILSCALE_AUTHKEY="tskey-auth-kQJR2kp6FY11CNTRL-sysAHSYrU45tkSez9qGS55j9KAnvn5W7W"

# فتح المنافذ الضرورية
EXPOSE 8080 8181 1935 1936 6000/udp

# تشغيل TailScale أولاً ثم Restreamer
CMD bash -c "\
  tailscaled & \
  sleep 5 && \
  tailscale up --authkey \"${TAILSCALE_AUTHKEY}\" --accept-routes --accept-dns && \
  exec /app/restreamer \
"
