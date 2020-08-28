# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include profile::section2::zip7choco
class profile::section2::zip7choco {
  include chocolatey

  package { '7zip':
    ensure   => latest,
    provider => 'chocolatey',
    notify   => Reboot['after_run'],
  }

  reboot { 'after_run':
    apply  => finished,
  }

}
