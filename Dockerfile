FROM alpine:3.24.2@sha256:3cf95fe0816180395592b8373f3ec60663f076127617bbacb4eacf9667afe2e9

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
    iproute2        # Network utils
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
