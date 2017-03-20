## Usage

### Development environment using docker-compose
1. Create container specification in docker-compose.yml
```
  - image: eugenebalaban:laravel-php-fpm
  - args:
     - INSTALL_XDEBUG=true
  - environment:
    - XDEBUG_CONFIG=remote_host=127.0.0.1
    - PHP_IDE_CONFIF=serverName=appSetup
``` 
2. If you're using MacOS replace '127.0.0.1' with '10.200.10.1' in docker-compose.yml file.
3. If you're using MacOS open terminal and execute: `sudo ifconfig lo0 alias 10.200.10.1/24`.
4. In PhpStorm use the following steps:
    - Go to `Run > Edit Configurations`;
    - Click `Add > PHP Remote Debug`;
    - Configure Web Server using corresponding IP address and port;
    - Use 'PHPSTORM' as IDE key;
    - Configure mapping './' => '/var/www/html'.