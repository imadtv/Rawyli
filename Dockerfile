# Dockerfile
FROM datarhei/restreamer:latest

# (اختياري) إذا أردت إضافة ملفات افتراضية أو config:
# COPY ./my-config.json /core/config/

# exposed ports (documentation uses these)
EXPOSE 8080 8181 1935 1936 6000/udp

# image already has entrypoint — لا حاجة لتعريف CMD هنا
