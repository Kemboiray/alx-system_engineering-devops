# Debug apache2

exec { 'fix_wp_locale':
  command => "/bin/sed -i 's/class-wp-locale.phpp/class-wp-locale.php/' /var/www/html/wp-settings.php",
  path    => ['/bin', '/usr/bin'],
}
