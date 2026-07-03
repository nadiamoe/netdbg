FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

RUN <<EOF
  set -e

  # Lil sed fuckery to be able to comment why we install each package.
  apk --no-cache add $(sed 's/#.*//' <<'PACKAGES'
    bash fish       # Suckless shells
    curl            # Old reliable
    bind-tools      # nslookup & friends
    tcpdump tshark  # Traffic capture
    lsof            # Listing open connections
    iproute2        # Network utils
    gcompat         # Provides libresolv, required to launch kubernetes binaries.
    cri-tools       # crictl
    containerd-ctr  # containerd CLI
    btop ncdu       # Misc sysadmin tools
PACKAGES
  )

  # Querying term properties is broken over kubectl debug/exec.
  echo "set -Ua fish_features no-query-term" >> /etc/fish/conf.d/no-query-term.fish
EOF


ENTRYPOINT ["/usr/bin/fish"]
