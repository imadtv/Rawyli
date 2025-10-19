# Restreamer فقط
FROM datarhei/restreamer:latest

# فتح المنافذ اللازمة
EXPOSE 8080 8181 1935 1936

# تشغيل Restreamer
CMD ["/app/restreamer"]
