FROM alpine:3.23.3@sha256:eb37f58646a901dc7727cf448cae36daaefaba79de33b5058dab79aa4c04aefb

RUN apk add \
  bash \
  curl \
  bind-tools \
  tcpdump \
  tshark \
  iproute2

# Make bash kill words in a sensical way
RUN echo "stty werase undef" >> ~/.bashrc && \
  echo bind \'"\C-w":backward-kill-word\' >> ~/.bashrc

ENTRYPOINT ["/bin/bash"]
