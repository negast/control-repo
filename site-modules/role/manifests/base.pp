# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include role::base
class role::base {
  include profile::section1
  include profile::section2::webserver
  include profile::section2::zip7choco

}
