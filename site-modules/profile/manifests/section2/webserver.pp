# @summary This class install iis web server and a small website.
#
# Iis will be installed via windows features. All management and sub modules will aslo be installed.
# The default wsebsite will be disabled and a new site site will be created.
#
# @example
#   include profile::section2::webserver
# @param [Boolean] install_sub
#   Wether to install sub features or not.
# @param [Boolean] install_man
#   Wether to install management tools or not.

class profile::section2::webserver (
  Boolean $install_sub = true,
  Boolean $install_man = true,

) {

  windowsfeature { 'Web-WebServer':
    ensure                 => present,
    installsubfeatures     => $install_sub,
    installmanagementtools => $install_man,
  }

  iis_site {'Default Web Site':
    ensure  => absent,
    require => Windowsfeature['Web-WebServer'],
  }

  file { 'interpub':
    ensure => 'directory',
    path   => 'c:\\inetpub',
  }

  file { 'minimal':
    ensure  => 'directory',
    path    => 'c:\\inetpub\\minimal',
    require => File['interpub'],
  }

  iis_site { 'minimal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\minimal',
    applicationpool => 'DefaultAppPool',
    require         => [
      File['minimal'],
      Iis_site['Default Web Site']
    ],
  }

}
