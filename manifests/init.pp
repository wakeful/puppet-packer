class packer (
  $version = '0.10.1',
  $cache_dir = '/tmp/packer',
  $bin_dir = '/usr/local/bin',
  $base_url = 'https://releases.hashicorp.com/packer/',
) {

  $_os = $::kernel ? {
    'Linux' => 'linux',
    'FreeBSD' => 'freebsd',
    'OpenBSD' => 'openbsd',
  }

  if $::architecture in ['x86_64', 'amd64', 'x64'] {
    $_arch = 'amd64'
  } else {
    $_arch = '386'
  }

  $packer_zip = "packer_${version}_${_os}_${_arch}.zip"
  $packer_url = "${base_url}${version}/${packer_zip}"

  file { $cache_dir:
    ensure => directory,
    owner => 'root',
    mode => '0644',
  }

  file { 'download-packer':
    path => "${cache_dir}/${packer_zip}",
    source => $packer_url,
    require => File[$cache_dir],
  }

  exec { 'install packer': 
    command => "unzip ${cache_dir}/${packer_zip}",
    cwd => $bin_dir,
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require => File['download-packer'],
  }

}