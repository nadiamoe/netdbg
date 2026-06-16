FROM --platform=${BUILDPLATFORM} alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b as crictl

WORKDIR /crictl
ARG TARGETOS
ARG TARGETARCH
ARG CRICTL_VERSION=v1.36.0
ADD https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz .
RUN tar -xzvf *.tar.gz

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

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
