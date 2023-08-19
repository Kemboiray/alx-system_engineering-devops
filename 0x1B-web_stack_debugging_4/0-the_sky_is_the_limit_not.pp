# Increase resource limit of nginx server

exec { 'increase_ulimit':
  provider => shell,
  command  => 'sed -i \'s/ULIMIT=.*/ULIMIT="-n 4096"/\' /etc/default/nginx',
  before   => Exec['restart nginx'],
}

exec { 'restart nginx':
  provider => shell,
  command  => 'service nginx restart',
}
