FROM alpine:3.10

LABEL maintainer="https://github.com/nbgallery"

USER root

RUN \
  apk --update add \
    bash \
    build-base \
    bzip2 \
    ca-certificates \
    curl \
    openssh-client \
    patch \
    python3-dev \
    py3-zmq \
    readline-dev \
    tar \
    tini \
    wget && \
  rm -rf /var/cache/apk/* && \
  pip3 install --no-cache-dir notebook && \
  mkdir /notebooks

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["jupyter", "notebook", "--allow-root", "--port=8888", "--ip='*'", "--no-browser", "--notebook-dir=/notebooks"]

