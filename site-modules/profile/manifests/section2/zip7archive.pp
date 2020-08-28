# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include profile::section2::zip7archive
class profile::section2::zip7archive {

  archive { 'c:/7z1900-x64.exe':
    source => 'https://www.7-zip.org/a/7z1900-x64.exe',
  }

  package { '7-Zip 19.00 (64-bit)':
    ensure          => installed,
    source          => 'c:/7z1900-x64.exe',
    install_options => ['/S'],
    notify          => Reboot['after_run_package'],
  }

  reboot { 'after_run_package':
    apply  => finished,
  }

}
