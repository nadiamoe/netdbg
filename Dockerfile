FROM alpine:3.24.4@sha256:93b41ef40b1677fce8fcc64ff4af09daddfacf5040afde618bc46c1e2d1cc7d4

RUN <<EOF
  set -e

  # Lil sed fuckery to be able to comment why we install each package.
  apk --no-cache add $(sed 's/#.*//' <<'PACKAGES'
    bash fish       # Suckless shells
    bat             # cat with syntax highlighting and pagination
    curl            # Old reliable
    bind-tools      # nslookup & friends
    tcpdump tshark  # Traffic capture
    lsof            # Listing open connections
    iproute2 iperf3 ethtool # Network utils
    gcompat         # Provides libresolv, required to launch kubernetes binaries.
    cri-tools       # crictl
    containerd-ctr  # containerd CLI
    kubectl k9s     # Kubernetes CLI tools
    btop ncdu       # Misc sysadmin tools
PACKAGES
  )
EOF

ENV fish_features=no-query-term

ENTRYPOINT ["/usr/bin/fish"]
