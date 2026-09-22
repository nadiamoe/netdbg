FROM --platform=${BUILDPLATFORM} archlinux:base AS build

ARG TARGETOS
ARG TARGETARCH

WORKDIR /build

# Download crictl. ADD stores http headers that keep this in the build cache.
ARG CRICTL_VERSION=v1.37.0
ADD https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz .
RUN tar -xzvf crictl-*.tar.gz -C /usr/local/bin

FROM archlinux:base

# crictl (cri-tools) has no Arch package, official repos or AUR. Fetched from upstream releases instead.
RUN <<EOF
  set -e

  # Lil sed fuckery to be able to comment why we install each package.
  pacman -Syu --noconfirm --needed $(sed 's/#.*//' <<'PACKAGES'
    bash fish             # Suckless shells
    bat                   # cat with syntax highlighting and pagination
    curl                  # Old reliable
    bind                  # dig, nslookup & friends
    tcpdump wireshark-cli # Traffic capture
    lsof                  # Listing open connections
    iproute2 iperf3 ethtool # Network utils
    containerd            # ctr CLI
    kubectl k9s           # Kubernetes CLI tools
    btop ncdu             # Misc sysadmin tools
PACKAGES
  )
  rm -rf /var/cache/pacman/pkg/*
EOF

COPY --from=build --chmod=0555 /usr/local/bin/crictl /usr/local/bin/crictl

ENV fish_features=no-query-term

ENTRYPOINT ["/usr/bin/fish"]
