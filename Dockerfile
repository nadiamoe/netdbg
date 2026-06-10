FROM --platform=${BUILDPLATFORM} alpine:3.24.0@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4 as crictl

WORKDIR /crictl
ARG TARGETOS
ARG TARGETARCH
ARG CRICTL_VERSION=v1.36.0
ADD https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz .
RUN tar -xzvf *.tar.gz

FROM alpine:3.24.0@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4

COPY --from=crictl /crictl/crictl /usr/local/bin/
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
