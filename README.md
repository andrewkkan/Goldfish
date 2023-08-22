## How we got here from the original Goldfish.Social repo:
Followed this tutorial for dockerization:
https://www.digitalocean.com/community/tutorials/how-to-set-up-laravel-nginx-and-mysql-with-docker-compose

Plus we did the following:
- [x] Dockerized the entire project to run in a containerized environment.  Just run docker compose up -d and you're good to go.
- [x] Added infinite scrolling on top of the existing Inertia pagination.
- [x] Automatic pause of video when scrolling off the viewport.


### Setup Instructions

Clone this repo, then, do the following to start from a clean slate
```
docker compose down
docker rm -f $(docker ps -a -q)
docker volume rm $(docker volume ls -q)
docker system prune -af
docker volume prune -f
rm -rf vendor
rm -rf node_modules
rm -rf public/storage
```

Then follow these commands to get it up and running
```
copy .env.example to .env # and make edits as needed
docker compose up -d
```

Wait a while for the container entrypoint scripts to finish running:
```
docker compose logs -f
```

Once you see the following in the logs, you can exit the logs with ctrl-c, and continue:
```
......
app              | [22-Aug-2023 17:16:38] NOTICE: fpm is running, pid 177
app              | [22-Aug-2023 17:16:38] NOTICE: ready to handle connections
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
