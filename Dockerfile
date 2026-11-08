FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

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
