# == Class: docbuild::deps
#
# Package dependencies wrapped in an extra layer of collision avoidance.
class docbuild::deps(
  ) {
  ensure_packages([ 'asciidoc',                     # required for asciidoc documentation.
                    'asciidoctor',                  # required for asciidoc documentation
                    'calibre',                      # required for .mobi output generated from mkdocs documentation
                    'default-jdk',                  # required for asciidoc blockdiag diagrams
                    'fonts-lmodern',                # required for pandoc PDF generator
                    'graphviz',                     # required for asciidoc dot diagrams
                    'lmodern',                      # required for pandoc PDF generator
                    'markdown',                     # required for mkdocs
                    'pandoc',                       # required for PDF output generated from mkdocs documentation
                    'python-blockdiag',             # required for asciidoc blockdiag diagrams
                    'ruby-dev',                     # required for asciidoctor
                    'ruby-redcarpet',               # required for asciidoctor
                    'texlive-base',                 # required for pandoc PDF generator
                    'texlive-latex-extra',          # required for pandoc PDF generator
                    'texlive-fonts-recommended',    # required for pandoc PDF generator
                    'texlive-latex-recommended',    # required for pandoc PDF generator
                    'texlive-xetex',                # required for utf-8 input to pandoc PDF generator
                    'vim-addon-manager',            # required for asciidoc syntax highlighting
                    'yard'                          # required for puppet module documentation generator
                    ])

  # Required to allow comments in Markdown documents (HTML style, but starting with 3 dashes, e.g.
  # <!--- this is a comment -->
  package { 'python-markdown-comments':
    ensure   => installed,
    source   => 'git+https://github.com/ryneeverett/python-markdown-comments.git',
    provider => 'pip',
  }

  # Converts mkdocs documentation to a single pandoc style document.
  package { 'mkdocs-pandoc':
    ensure   => installed,
    provider => 'pip',
  }


  # Required for building openstack-kundendoku

  package { 'mkdocs':
    ensure   => installed,
    provider => 'pip',
  }

  package { 'markdown-include':
    ensure   => installed,
    provider => 'pip',
  }
  
}
