class { 'ssh::client':
  options => {
    'IdentityFile'           => '~/.ssh/school',
    'PasswordAuthentication' => 'no',
  },
}
