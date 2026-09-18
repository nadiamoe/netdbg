FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

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
