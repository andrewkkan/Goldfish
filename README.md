## What has been done so far from the original repo

- [x] Dockerized the entire project to run in a containerized environment.  Just run follow the setup instructions below and you're good to go.
- [x] Added infinite scrolling on top of the existing Inertia pagination.
- [x] Automatic pause of video when scrolling off the viewport.

### Setup Instructions

The dream is to have a single command to run the entire project, but for now, we have to do a few things manually.  Let me know if any of you have any ideas on how to improve this.

First, copy .env.example to .env and edit .env or just leave it the way it is:  
```
cp .env.example .env
```
Then, assuming you have Docker installed, run the following commands:

```
docker run --rm -v $(pwd):/app composer:2.4.3 install --ignore-platform-req=ext-pcntl  # This will install composer dependencies in the vendor folder, with the correct php version.
docker compose up -d
```

Now create the database user
```
docker-compose exec db bash
```
and within the interactive container shell, run the following commands
```
mysql -u root -p
# Enter password (root)
```
Within the mysql shell, run the following commands
```
show databases;
GRANT ALL ON laravel.* TO 'laraveluser'@'%' IDENTIFIED BY 'your_laravel_db_password';
FLUSH PRIVILEGES;
EXIT;
```
Now exit the interactive container shell
```
exit
```

Onto the final stretch of setup, do the following
```
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan config:cache
docker-compose exec app php artisan storage:link
docker-compose exec app php artisan migrate --force
docker-compose exec app php artisan horizon:install
docker-compose exec app php artisan horizon:publish
```

Now, point your browser to http://localhost to see the app running!

### Back to the original README.md
What follows below is the original README.md from the originally forked [repo](https://github.com/Goldfish-Social/Goldfish).

## Goldfish Social

Hello there! Welcome to the Goldfish Social repo, this project is intended as a free open source alternative to (former) Vine and (currently) TikTok. The project has just started and is in very early stages. We started out with something different, but after some great advice restarted the project in SPA form(Single Page Application). We are using the following stacks:

- [Laravel 9.x](https://laravel.com/).
- [Vue JS 3.x](https://vuejs.org/).
- [Tailwind CSS 2.x](https://tailwindcss.com/).
- [Inertia.js](https://inertiajs.com/).


If you want to test out this software for yourself, do checkout our little [documentation](/docs/install.md).


## Features

As said, the project is in very early stages, and we will update the repo as soon as the code is available and tested. For now, we are building a full-featured social platform and later add Federation through [ActivityPub](https://www.w3.org/TR/activitypub/). 

## Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit our [Patreon page](https://patreon.com/GoldfishSocial).

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to stux via [stux@mstdn.social](mailto:stux@mstdn.social). All security vulnerabilities will be promptly addressed.

## License

Goldfish Social is open-sourced software licensed under the AGPL license.
