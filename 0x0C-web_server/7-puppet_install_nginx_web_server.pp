# Install and configure nginx

# Installation
class nginx_setup {
  package { 'nginx':
    ensure => present,
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello World!',
    require => Package['nginx'],
  }

  file { '/var/www/html/my_404.html':
    ensure  => file,
    content => "Ceci n'est pas une page",
    require => Package['nginx'],
  }

  file_line { 'nginx_server_name':
    path  => '/etc/nginx/sites-available/default',
    line  => "\tserver_name _;",
    match => "^\tserver_name _;",
  }

  file_line { 'nginx_redirect':
    path  => '/etc/nginx/sites-available/default',
    line  => "\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;",
    match => "^\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;",
    after => "^\tserver_name _;",
  }

  file_line { 'nginx_error_page':
    path  => '/etc/nginx/sites-available/default',
    line  => "\terror_page 404 /my_404.html;",
    match => "^\terror_page 404 /my_404.html;",
    after => "^\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;",
  }

  file_line { 'nginx_error_page_location':
    path  => '/etc/nginx/sites-available/default',
    line  => "\tlocation = /my_404.html {\n\t\troot /var/www/html;\n\t\tinternal;\n\t}",
    match => "^\tlocation = /my_404.html",
    after => "^\terror_page 404 /my_404.html;",
  }
}
