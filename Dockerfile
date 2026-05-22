FROM alpine:3.23.4@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

RUN apk add \
  # Suckless shell
  fish \
  curl \
  # nslookup & friends
  bind-tools \
  # Traffic capture
  tcpdump tshark \
  # Listing open connections
  lsof \
  # Network utils
  iproute2 \
  # Provides libresolv, required to launch kubernetes binaries.
  gcompat \
  # Misc sysadmin tools
  btop ncdu

ENTRYPOINT ["/usr/bin/fish"]
