# `nadiamoe/netdbg`

Container image for network debugging. Contains `tcpdump`, `iproute2`, `iptables`, `crictl`, and a bunch of other useful
utilities like `ncdu` or `btop`. Can be used with `kubectl debug`, for both nodes and pods.

When debugging nodes, Kubernetes will mount the host root in `/host`. When debugging pods and using `--target`, the
container fs (including volumemounts and PVCs) can be accessed in `/proc/1/root` (for the majority of containers that
use PID 1).
