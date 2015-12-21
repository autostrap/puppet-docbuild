# == Class: docbuild::asciidoc
#
# Installs asciidoc authoring tools and sets everything up for editing asciidoc.
class docbuild::asciidoc(
  ) {

    include '::docbuild::deps'

  exec {'enable asciidoc syntax highlighting for vim':
    provider    => shell,
    command     => 'vim-addon-manager -w install asciidoc',
    environment => 'HOME=/root', # Otherwise vim-addon-manager will try Etc.getpwnam() which returns nil when run from puppet.
    unless      => 'vim-addon-manager -q -w | grep asciidoc | grep -q installed',
    require     => Class['docbuild::deps'],
  }

  # We need to install this the ugly way since rjb won't install without JAVA_HOME
  # set. This is impossible with the package type, since the gem provider
  # doesn't allow for setting environment variables (it doesn't use the
  # system's environment either). HOME is set to avoid a non-zero exit status
  # apparently triggered by the following error message:
  #
  #   "couldn't find HOME environment -- expanding `~'".

  exec{'install asciidoctor-diagram':
    provider => shell,
    path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    command  => 'JAVA_HOME=/usr/lib/jvm/default-java HOME=/root gem install asciidoctor-diagram',
    unless   => 'gem query -i -n asciidoctor-diagram',
  }

  # Overwrite asciidoctor from Ubuntu package with version from gem (supports -r)

  file{['/usr/bin/asciidoctor']:
    ensure  => file,
    backup  => '.dist',
    source  => '/usr/local/bin/asciidoctor',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => Exec['install asciidoctor-diagram'],
  }
}
