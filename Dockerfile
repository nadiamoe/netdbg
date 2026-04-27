FROM alpine:3.23.4@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

RUN apk add \
  bash \
  curl \
  # nslookup & friends
  bind-tools \
  tcpdump \
  tshark \
  iproute2 \
  # Provides libresolv, required to launch kubernetes binaries.
  gcompat

# Make bash kill words in a sensical way
RUN echo "stty werase undef" >> ~/.bashrc && \
  echo bind \'"\C-w":backward-kill-word\' >> ~/.bashrc

ENTRYPOINT ["/bin/bash"]
