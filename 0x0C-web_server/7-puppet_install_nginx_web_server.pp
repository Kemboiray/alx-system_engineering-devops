# Ensure Nginx is installed
package { 'nginx':
  ensure => present,
}

# Allow HTTP traffic through the firewall
exec { 'ufw allow "Nginx HTTP"':
  path => '/usr/bin',
}

# Create index.html and custom 404 error page
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

file { '/var/www/html/my_404.html':
  ensure  => file,
  content => "Ceci n'est pas une page",
}

# Start Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
}

# Create backup of default Nginx configuration file
file { '/etc/nginx/sites-available/default_back_up':
  ensure => present,
  source => '/etc/nginx/sites-available/default',
}

# Modify default Nginx configuration file
file_line { 'add redirect':
  path  => '/etc/nginx/sites-available/default',
  line  => "\tlocation ~ /redirect_me[/]?$ {\n\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n\t}\n",
  after => '\tserver_name _;',
}

file_line { 'add custom error page':
  path  => '/etc/nginx/sites-available/default',
  line  => "\terror_page 404 /my_404.html;\n\tlocation = /my_404.html {\n\t\troot /var/www/html;\n\t\tinternal;\n\t}",
  after => '\tserver_name _;',
}

# Restart Nginx service to apply changes
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
