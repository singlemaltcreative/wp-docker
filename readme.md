# WordPress Docker Development Environment

This is a Docker based local development environment for WordPress.

## What's Inside

This project is based on [docker-compose](https://docs.docker.com/compose/). By default, the following containers are started: PHP-FPM, MariaDB, Elasticsearch, nginx, phpmyadmin, dnsmasq, and Memcached. The `/wordpress` directory is the web root which is mapped to the nginx container.

You can directly edit PHP, nginx, and Elasticsearch configuration files from within the repo as they are mapped to the correct locations in containers.

A `Dockerfile` is included for PHP-FPM (`/dockerfiles/php-fpm/Dockerfile`). This adds a few extra things to the PHP-FPM image.

The `/config/elasticsearch/plugins` folder is mapped to the plugins folder in the Elasticsearch container. You can drop Elasticsearch plugins in this folder to have them installed within the container.

## Requirements

* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
* [dnsmasq via homebrew (running as service)](https://coderwall.com/p/qknu2g/local-docker-development-with-virtual-hosts)
	-	Replace YOUR_DOCKER_IP as found in the above article's instructions with `localhost`

## Clone

1. `git clone git@github.com:singlemaltcreative/wp-docker.git <my-project-name>`
1. `cd <my-project-name>`

## Configure

1. Replace the `DBNAME` variable at the top of setup.sh, restore.sh, and backup.sh
1. Replace `servername virtualhost.dev` to your desired virtual host URL in `config/nginx/default.conf`.
1. Replace the `MYSQL_DATABASE` and `VIRTUAL_HOST` key-values from docker-compose.yml with your desired database name and virtual host (the virtual host should match the name you specifed in `default.conf` from the above step.

## Setup

1. `docker-compose up`
1. Run `bash setup.sh` to download WordPress and create a `wp-config.php` file.
1. Navigate to `http://localhost` in a browser to finish WordPress setup.

Default MySQL connection information (from within PHP-FPM container):

```
Database: wordpress
Username: wordpress
Password: password
Host: mysql
```

Default Elasticsearch connection information is available here (from within PHP-FPM container):

```Host: http://[virtualhostnamehere.dev]:9200```

Default phpMyAdmin URL:

```Host: http://[virtualhostnamehere.dev]:8181```

## Docker Compose Overrides File

Adding a `docker-compose.override.yml` file alongside the `docker-compose.yml` file, with contents similar to
the following, allows you to change the domain associated with the cluster while retaining the ability to pull in changes from the repo.

```
version: '2'
services:
  phpfpm:
    extra_hosts:
      - "dashboard.dev:172.18.0.1"
```

## WP-CLI

Add this alias to `~/.bash_profile` to easily run WP-CLI command.

```
alias dcwp='docker-compose exec --user www-data phpfpm wp'
```

Instead of running a command like `wp plugin install` you instead run `dcwp plugin install` from anywhere inside the
`<my-project-name>` directory, and it runs the command inside of the php container.

## SSH Access

You can easily access the WordPress/PHP container with `docker-compose exec`. Here's a simple alias to add to your `~/.bash_profile`:

```
alias dcbash='docker-compose exec --user root phpfpm bash'
```

This alias lets you run `dcbash` to SSH into the PHP/WordPress container.

## Credits

This project is a fork of https://github.com/10up/wp-docker, and is a flavor of an environment created by John Bloch.
