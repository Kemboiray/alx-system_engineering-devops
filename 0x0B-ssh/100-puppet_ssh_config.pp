# Configure ssh client to use private key `~/.ssh/school`
# and refuse password authentication
file { '/etc/ssh/ssh_config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => '
Host *
  IdentityFile ~/.ssh/school
  PasswordAuthentication no
',
}
