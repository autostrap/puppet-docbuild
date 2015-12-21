puppet-docbuild
===============

# Puppet module for checking out documentation repositories and running build scripts.

## Overview

This module checks out one or more documentation repositories described in the
form of a hash. It can optionally run build scripts for these repositories
(e.g. for generating HTML from Markdown).

## Example Hiera configuration

```
docbuild::repos:
  '/opt/doc/cloudstrap':
    source: git@gitlab.syseleven.de:cloudstrap/cloudstrap-docs.git
    provider: git
    build_cmd: |
      #!/bin/sh
      repo="<%= @name %>"
      wwwroot='/usr/share/nginx/html'
      destdir="${wwwroot}/$(basename "$repo")"
      cd $repo
      make
      rm -rf "$destdir"
      mkdir -p "$destdir"
      cp index.html "$destdir"
```
