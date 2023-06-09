# Class: munin::params
#
# This class defines default parameters used by the main module class munin
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to munin class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class munin::params {

  ### Module Specific parameters
  $server = '127.0.0.1'
  $server_local = false
  $address = $facts[networking][ip]
  $folder = ''
  $grouplogic = ''
  $extra_plugins = false
  $autoconfigure = true
  $autoconfigure_template = $facts[os][name] ? {
    /(?i:OpenBSD)/ => 'munin/munin-autoconfigure-openbsd.erb',
    default        => 'munin/munin-autoconfigure.erb',
  }
  $autoconfigure_file = $facts[os][name] ? {
    /(?i:OpenBSD)/ => '/usr/local/sbin/munin-autoconfigure',
    default        => '/etc/cron.daily/munin-autoconfigure',
  }
  $html_strategy = 'cron'
  $graph_strategy = 'cron'
  $graph_period = 'second'
  $cgi_graph_jobs = '6'
  $max_graph_jobs = '15'

  $package_perlcidr = $facts[os][name] ? {
    /(?i:Centos|Redhat|Rocky|Scientific|Amazon|Linux)/ => $facts[os][release][full] ? {
      4        => 'perl-Net-CIDR-Lite',
      default  => 'perl-Net-CIDR',
    },
    /(?i:OpenBSD)/                               => 'p5-Net-CIDR',
    default                                      => 'libnet-cidr-perl',
  }

  $package_server = $facts[os][name] ? {
    /(?i:OpenBSD)/ => 'munin-server',
    default        => 'munin',
  }

  $config_file_server = '/etc/munin/munin.conf'
  $template_server = 'munin/munin.conf.erb'
  $template_host = 'munin/host.erb'

  $include_dir = '/etc/munin/munin-conf.d'
  $include_dir_purge = false

  $conf_dir_plugins = '/etc/munin/plugin-conf.d'

  $conf_dir_active_plugins = '/etc/munin/plugins/'

  $web_dir = $facts[os][name] ? {
    /(?i:Ubuntu|Debian|Mint)/ => '/var/cache/munin/www',
    default                   => '/var/www/html/munin',
  }

  $plugins_dir = $facts[os][name] ? {
    default => '/usr/share/munin/plugins',
  }

  $restart_or_reload = $facts[os][name] ? {
    /(?i:Debian)/ => 'restart',
    default       => 'reload',
  }

  ### Application related parameters

  $package = $facts[os][name] ? {
    default => 'munin-node',
  }

  $service = $facts[os][name] ? {
    /(?i:OpenBSD)/ => 'munin_node',
    default        => 'munin-node',
  }

  $service_status = $facts[os][name] ? {
    default => true,
  }

  $process = $facts[os][name] ? {
    /(?i:Ubuntu)/ => $facts[os][release][full] ? {
      '12.04'  => 'munin',
      default => 'munin-node',
    },
    default => 'munin-node',
  }

  $process_args = $facts[os][name] ? {
    /(?i:Ubuntu)/ => $facts[os][release][full] ? {
      '12.04'  => 'munin-node',
      default => '',
    },
    default => '',
  }

  $process_user = $facts[os][name] ? {
    default => 'munin',
  }

  $config_dir = $facts[os][name] ? {
    default => '/etc/munin',
  }

  $config_file = $facts[os][name] ? {
    default => '/etc/munin/munin-node.conf',
  }

  $config_file_mode = $facts[os][name] ? {
    default => '0644',
  }

  $config_file_owner = $facts[os][name] ? {
    default => 'root',
  }

  $config_file_group = $facts[os][name] ? {
    /(?i:OpenBSD)/ => 'wheel',
    default        => 'root',
  }

  $config_file_init = $facts[os][name] ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/munin',
    default                   => '/etc/sysconfig/munin',
  }

  $pid_file = $facts[os][name] ? {
    default => '/var/run/munin/munin-node.pid',
  }

  $data_dir = $facts[os][name] ? {
    default => '/etc/munin',
  }

  $log_dir = $facts[os][name] ? {
    default => '/var/log/munin',
  }

  # Munin EPEL package has changed the path of munin-node log
  # to /var/log/munin-node/munin-node.log from version 2.0.9-3 (sigh)
  # Earlier versions logged to /var/log/munin/munin.log
  # The new default is kept here. You may override it with:
  # class { 'munin':
  #   log_file => '/var/log/munin/munin.log',
  # }
  $log_file = $facts[os][name] ? {
    /(Debian|Ubuntu)/                                         => '/var/log/munin/munin-node.log',
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux|Rocky)/ => '/var/log/munin-node/munin-node.log',
    /(?i:OpenBSD)/                                            => '/var/log/munin/munin-node.log',
    default                                                   => '/var/log/munin/munin.log',
  }

  $fcgi_runlevels = '2345'

  $fcgi_command = $facts[os][name] ? {
    /(?i:Ubuntu|Debian|Mint)/ => '/usr/bin/spawn-fcgi -n -s /var/run/munin/fcgi-graph.sock -U www-data -u www-data -g www-data /usr/lib/munin/cgi/munin-cgi-graph',
    default                   => '/usr/bin/spawn-fcgi -n -s /var/run/munin/fcgi-graph.sock -U www-data -u www-data -g www-data munin-fastcgi-graph',
  }

  $fcgi_reload_init = true

  $port = '4949'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'munin/munin-node.conf.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $facts[networking][ip]
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $facts[networking][ip]
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
