FROM alpine:3.22.2@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

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
