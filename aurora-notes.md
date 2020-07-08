
# Minimal Zones
- Minimal zone images https://github.com/ptribble/mvi/blob/master/zmvix.sh
- Package manager integration?
- Use manifests and the file lists inside of there.
# Kubernetes
- Awesome kubernetes https://github.com/ramitsurana/awesome-kubernetes
- Compile docs https://docs.microsoft.com/en-us/virtualization/windowscontainers/kubernetes/compiling-kubernetes-binaries
- Docker Term needs to be pointed to moby/term until it lands in kubernetes to version in kubernetes
  - ~/workspace/go/nomad/vendor/github.com/docker/docker
  - Termios fixes upstream in https://github.com/moby/term
- #CRI notes
  - https://github.com/cri-o/ocicni
  - https://github.com/kubernetes/cri-api
  - https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md
- #CSI notes
  - https://github.com/container-storage-interface
# Nomad
- Termios fixes upstream in https://github.com/moby/term
- Refactor utilities (untie things)
# Functions
- #build
  - [Makisu](https://github.com/uber/makisu) builder from uber with nice features to maybe add
- #imgunpack
  - no binary
  - Unpack OCI image into runtime spec compatibe ZFS image
  - Including sub volumes if present
  - Interfaces with OCI layout and ZFS images
- #imgget
  - Download image from registry to OCI directory
  - Interfaces with OCI file spec and registry
- #imgpack
  - Counter to imgunpack (no binary)
  - make OCI directory from ZFS Image
- #imgpush
  - Counter to imgget (no binary)
  - push images to a registry
- #imgconvert
  - convert images between formats 
  - Ingest SmartOS images
- #buildprep
  - prepare sources or unpack a root directory to a container dataset
  - convert container into ZFS Image
  - generate metadata for the image (no runtime)
# CLI utilities
- runz to only execute runtime spec
  - Create Zone and run it
  - convert OCI spec to zone
- buildhelper
  - run build steps inside the container
  - execute actions
  - define services for smf and podinit
  - extract source archives
  - save actions.json with custom actions an image could execute
- podadm
  - manage containers and pods run, start, stop, create, delete, update
- imageadm
  - Client utility for several host functions
  - [[aurora-notes.md#imgget]]
  - [[aurora-notes.md#imgunpack]]
  - [[aurora-notes.md#build]]
  - [[aurora-notes.md#imgconvert]]
- podinit
  - use lofs mounted config.json (readonly) to know which binary to start
  - work as init type service indide the zone
  - config map (key value -> toml, yaml, json)?
  - provide interface to execute actions
# Coding notes
- Daemonizing 
  - https://ieftimov.com/post/four-steps-daemonize-your-golang-programs/
