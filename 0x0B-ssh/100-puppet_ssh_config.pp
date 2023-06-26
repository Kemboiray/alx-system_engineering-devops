# Configure ssh client to use private key `~/.ssh/school`
# and refuse password authentication
exec { 'create_file':
  command => 'echo "Host *\n    IdentityFile ~/.ssh/school\n    PasswordAuthentication no" > 2-ssh_config',
  path    => '/bin:/usr/bin',
}
