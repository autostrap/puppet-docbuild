# == Class: docbuild
#
# Checks out documentation repositories read from a hash and executes optional build scripts
#
# == Parameters
#
# [*repos*]
#   (required) A hash of hashes describing the documentation repories to check
#   out. Top-level keys are the filesystem paths to check repositories out to.
#   At the next level there are the following keys:
#     * (required) source     The repository's URL.
#     * (optional) build_cmd  A command script to run after checking out/updating the repository.
#     * (optional) provider   The vcsrepo provider to use for checking out the repository (defaults to git).
#     * (optional) revision   The revision (branch or commit in the case of git repositories) to check out (defaults to 'master')
#
class docbuild(
  ) {
  $repos = hiera_hash('docbuild::repos', {})

  class { 'docbuild::asciidoc': }
  class { 'docbuild::puppetlabs_strings': }

  $repos_keys = keys($repos)

  repodeploy::deploy_repo { $repos_keys:
    require           => [Class['docbuild::asciidoc'], Class['docbuild::puppetlabs_strings'], Package['nginx']],
    repos             => $repos,
    }
  }
