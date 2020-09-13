
# PKG6
- Open tasks
  [] Indexing
- Ideas
  - integration as [[aurora-notes.md]] image registry
  - reproducible tar files?
  - Precomputed images (image to image version upgrade)
    - OCIv2 images

# Get amount of packages
`cat /var/pkg/publisher/openindiana.org/catalog/catalog.dependency.C | jq '.["openindiana.org"] | keys' | wc -l`
# Get amount of versions of package 
`cat /var/pkg/publisher/openindiana.org/catalog/catalog.dependency.C | jq '.["openindiana.org"]."consolidation/userland/userland-incorporation" | length'`
# Get amount of actions for package
`cat /var/pkg/publisher/openindiana.org/catalog/catalog.dependency.C | jq '.["openindiana.org"]."consolidation/userland/userland-incorporation"[].actions | length'`

# Links
- [Image Packaging System Description](https://docs.oracle.com/cd/E23824_01/html/E21796/pkg-5.html)