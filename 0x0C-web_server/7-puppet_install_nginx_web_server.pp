# Install and configure nginx

exec { 'apt-update':
  command => 'apt update',
  path    => '/usr/bin:/usr/sbin:/bin',
}

package { 'nginx':
  ensure  => installed,
  require => Exec['apt-update'],
}

exec { 'ufw-allow':
  command => 'ufw allow "Nginx HTTP"',
  path    => '/usr/bin:/usr/sbin:/bin',
  require => Package['nginx'],
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
  require => Exec['ufw-allow'],
}

file { '/var/www/html/my_404.html':
  content => 'Ceci n\'est pas une page',
  require => File['/var/www/html/index.html'],
}

service { 'nginx-start':
  ensure  => running,
  name    => 'nginx',
  enable  => true,
  require => File['/var/www/html/my_404.html'],
}

exec { 'nginx-copy':
  command => 'cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default_back_up',
  path    => '/usr/bin:/usr/sbin:/bin',
  require => Service['nginx-start'],
}

exec { 'nginx-config':
  command => 'awk \'
  	{
  		if ($0 == "\tserver_name _;") {
  			print "\tserver_name _;"
  			print "\tlocation ~ /redirect_me[/]?$ {"
  			print "\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;"
  			print "\t}\n"
  			print "\terror_page 404 /my_404.html;"
  			print "\tlocation = /my_404.html {"
  			print "\t\troot /var/www/html;"
  			print "\t\tinternal;"
  			print "\t}"
  		} else {
  			print $0
  		}
  	}
  \' /etc/nginx/sites-available/default > temp && mv temp /etc/nginx/sites-available/default',
  path    => '/usr/bin:/usr/sbin:/bin',
  require => Exec['nginx-copy'],
  notify  => Service['nginx-restart'],
}

service { 'nginx-restart':
  ensure  => restarted,
  name    => 'nginx',
  require => Exec['nginx-config'],
}
