# == Class: docbuild::asciidoc
#
# Installs puppetlabs-strings (for generating puppet module documentation).
class docbuild::puppetlabs_strings(
  ) {

  include '::docbuild::deps'

  file{['/usr/share/nginx/html/puppet']:
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => Package['nginx'],
  }
}
