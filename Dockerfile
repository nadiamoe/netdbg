FROM alpine:3.20.2

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
