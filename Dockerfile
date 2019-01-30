FROM alpine

RUN apk add --update --no-cache curl bash jq netcat-openbsd

RUN cd /usr/local/bin \
    && curl -O https://storage.googleapis.com/kubernetes-release/release/v1.7.14/bin/linux/amd64/kubectl \
    && chmod 755 /usr/local/bin/kubectl

COPY check_nodes.sh /bin/
RUN chmod +x /bin/check_nodes.sh

CMD ["bash", "/bin/check_nodes.sh"]
