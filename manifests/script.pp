# == Class cloudinit::script
#
# A define to install a cloudinit script
#
define cloudinit::script(
  $ensure      = present,
  $source      = undef,
  $content     = undef,
  $script_type = 'per-instance',
  $script_base = '/var/lib/cloud/scripts',
  $owner       = 'root',
  $group       = '0',
  $mode        = '0750'
) {

  $both = ($source != undef and $content != undef)
  $neither = ($source == undef and $content == undef)
  if $both or $neither {
    fail('Must specify exactly one of $source/$content')
  }
  validate_string($name)
  validate_re($script_type, '^per-(?:boot|instance|once)$')

  $script_dir = "${script_base}/${script_type}"
  $target = "${script_dir}/${name}"

  file{$target:
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    source  => $source,
    content => $content,
  }

}