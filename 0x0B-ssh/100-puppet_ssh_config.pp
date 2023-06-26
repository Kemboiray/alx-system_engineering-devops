# Configure ssh client to use private key `~/.ssh/school`
# and refuse password authentication
class { 'ssh::client':
  options => {
    'IdentityFile'           => '~/.ssh/school',
    'PasswordAuthentication' => 'no',
  },
}
