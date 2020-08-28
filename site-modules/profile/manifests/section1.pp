# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include profile::section1
#
#
# @param [String] password
#   The password for the user.
# @param [String] username
#   The username for the user.
# @param [String] groupname
#   The name for the group.
# @param [Boolean] force_membership
#   Wether only the users listed are allowed in the group or not defaults to false.
# @param [String] dir
#   The name for the directory for section1.
class profile::section1 (
  String[1] $password,
  String[1] $username = 'negast',
  String[1] $groupname = 'mygroup',
  Boolean $force_membership = false,
  String[1] $dir = 'c:/test',

) {

  group { $groupname:
    ensure          => 'present',
    name            => $groupname,
    auth_membership => $force_membership,
  }

  user { $username:
    ensure   => 'present',
    password => $password,
    groups   => $groupname,
  }

  local_security_policy { 'Log on as a service':
    ensure       => 'present',
    policy_value => $username,
  }

  file { $dir:
    ensure => 'directory',
    mode   => '0660',
    owner  => $username,
    group  => $groupname,
  }

  acl { $dir:
    permissions => [
      { identity => $username, rights => ['full'] },
      { identity => $groupname, rights => ['read'] }
    ],
  }
  # https://4sysops.com/archives/disable-internet-explorer-enhanced-security-configuration-ie-esc-with-group-policy/
  registry_value { 'HKLM\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}\\IsInstalled':
    ensure => present,
    type   => dword,
    data   => 1,
  }
  registry_value { 'HKLM\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}\\IsInstalled':
    ensure => present,
    type   => dword,
    data   => 1,
  }

  registry_value { 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Reliability\\ShutdownReasonUI':
    ensure => present,
    type   => dword,
    data   => 1,
  }
  registry_value { 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Reliability\\ShutdownReasonOn':
    ensure => present,
    type   => dword,
    data   => 1,
  }

}
