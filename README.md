![Logo](https://i.imgur.com/Ai4VtYt.png)

# Vertex

A barebones Docker image with essentials for PHP/Hack development and 
deployment.

## Batteries included:

- Web servers: Proxygen, Nginx (Optional)
- Runtimes: HHVM 3.12.1, Node.js 5.9, Python 2.7.
- Package managers: `composer`, `npm`.
- Development: `git`, `curl`.

## Recent changes:

**What's new in v4.0?:**

- Upgraded to Debian Jessie (`google/debian` -> `debian`).
- Updated packages: HHVM 3.12.1, Node.js 5.9.
- New developer tools: `vmenu`, `vinstall`.
- Nginx is available again, but it is not installed by default.
- New build scripts.

**What's new in v3.2?:**

- Nginx is dropped in favor of HHVM's built-in web server (Proxygen).
- HHVM 3.11.0 (with PHP 7 support).
- Node.js 5.0.

**What's new in v3?:**

- Uses `google/debian` instead of `ubuntu`.
- Newer version of included packages.
- Image size optimizations.

## Requirements

- Docker 1.7+
- Docker Compose (Optional)

## Getting started

Getting a shell inside a Vertex container is easy, even if it is your first 
time using Docker:

### Using Quay.io:

Pull down a pre-built image from the Quay.io, and run a shell inside the 
container afterwards:

```sh
docker run -ti quay.io/etcinit/vertex:3.0.0 begin
```

### From the source code:

First, you need to clone this git repository:

```sh
git clone git@github.com:etcinit/vertex.git
cd vertex
```

#### Option 1: Using Make

If you have `make` installed, we have simplified the process for you:

```sh
make login
```
The provided Makefile essentially just calls Docker Compose for you and gets a
shell up and going.

Alternatively, you may also just build the image:

```sh
make
```

> **NOTE:** These commands will only allow you to build and login to the 
container. They will not automatically bind ports for your servers. See the 
sections below for instructions on how to get servers running and binding 
ports.

#### Option 2: Using Docker Compose

With Docker Compose, it is also pretty easy to get a container running:

```sh
# First, build the image:
docker-compose build

# Then, login:
docker-compose run web begin
```

> **NOTE:** These commands will only allow you to build and login to the 
container. They will not automatically bind ports for your servers. See the 
sections below for instructions on how to get servers running and binding 
ports.

#### Option 3: Using the Docker CLI

If you would like to understand how the internal works, we recommend 
building the image by hand by interacting with the Docker CLI directly:

```sh
docker build -t vertex .

# This may take some time if it is the first Vertex image you 
# have built on your system

# Start hacking:
docker run -it vertex begin

# Allow a server to run on port 80:
docker run -it -p 80:80 vertex begin
```

> **NOTE:** Unlike options 1 and 2, the last command will actually bind a port
for your HTTP server for you. See the sections below for instructions on how 
to get servers running and binding ports.

### Getting your files inside the container:

Depending on which of the options above you chose to get Vertex running on 
your machine, you might have already some directories mounted inside the 
container.

#### Mounting

Docker has allows you to mount external directories or even share them between
containers through a concept called Volumes. If you used the Makefile or Docker
Compose, the current working directory was automatically mounted into 
`/var/www/vertex`.

If you are using the Docker CLI, you can replicate this by using the `-v` 
parameter:

```sh
docker run -ti vertex -v $(pwd):/var/www/vertex

# Custom mapping are also possible:
docker run -ti vertex -v $(pwd):/opt/mynodeapp
docker run -ti vertex -v /home/user1/app:/opt/myapp
```

#### Using a Dockerfile and `ADD` or `COPY`:

If you are using Vertex as the base image of your project, you may add files 
to the image by using the `ADD` and `COPY` commands:

```Dockerfile
FROM quay.io/etcinit/vertex:3.0.0
# ...

# It is possible to override the default PHP project:
ADD . /var/www/vertex

# Add arbitrary files:
ADD app.js /app.js

# Or even replace existing configuration files:
ADD site.ini /vertex/hhvm/site.ini
```

## PHP and Hack Development

### The sample project:

Vertex is pre-configured with a default PHP project inside `/var/www/vertex`. 
You can add any framework to this directory, such as Laravel, Wordpress, 
Symfony, or even your own. Public files are assumed to be in 
`/var/www/vertex/public`, which is where the web server will server files 
from.

This default setup is useful if you're looking to get a server running a PHP 
project with the least amount of configuration possible. However, if you need 
to change the default HHVM settings, you will need to add your own 
configurations files inside the container.

Note: Make sure that when adding files, they are still executable by HHVM 
which uses the `www-data` user.

> **IMPORTANT:** For more information on getting files on the container, read 
the section above. Using the Makefile or Docker Compose from the wrong 
directory could break the default project.

Once the server is running you should see the following page:

![Screenshot](http://i.imgur.com/ucJXOmm.png)

### From Quay.io:

Mount the current directory into `/var/www/vertex` and start HHVM:

```sh
docker run -it -v "$(pwd):/var/www/vertex" -p 80:80 quay.io/etcinit/vertex
```

**Note:** This makes the assumption that your project has a `public` directory. 
Otherwise, modify the `-v` option to point to a directory with an `index.php` 
or `index.html` file.

### From the Vertex GitHub repository:

If you pulled `etcinit/vertex` from GitHub, you can run a server using the 
Makefile or manually:

Start HHVM at port 80:

```sh
make server

# -- OR --

docker run -ti -p 80:80 -v $(pwd):/var/www/vertex vertex
```

## Dockerfiles and pre-built images

The purpose of Vertex is to have a pre-built image with some of the basic 
dependencies for a PHP project. The benefit? Saved time. This image
is built automatically on Quay.io. If one of your projects uses it as a
base image, you don't need to waste time downloading common dependencies.

> **NOTE**: While Vertex saves some time, it is no replacement for a single 
purpose image. If you need a small image, please build your own or use one 
from a Docker registry.

### Dockerfile workflow

__To use it as part of a project:__

Your project needs to have Dockerfile on the root directory of the project. 
Review the Docker documentation for more information about the syntax and 
purpose of this file.

Adding the following line to the top of your docker file specifies the base 
image:
```
FROM quay.io/etcinit/vertex:3.0.0
```

> **NOTE:** Remove `FROM ubuntu` if you were using ubuntu as the base image. 
You can only have one base image. Vertex is based on Debian.

#### Example usage:

The following is an example of how to use Vertex in a PHP project:

```Dockerfile
FROM quay.io/etcinit/vertex:3.0.0

# Add the current directory into the image. This replaces the sample project.
ADD . /var/www/vertex

# Set the current working directory
WORKDIR /var/www/vertex

# Run composer update
RUN composer update

# Expose ports
EXPOSE 80

# Logs volume
VOLUME ["/var/www/vertex/storage/logs"]

# Start servers
CMD ["/opt/start.sh"]
```

If you don't mount your project using the `-v` tag while using `docker run`, 
your code won't automatically update inside the container; it will only update
during a `docker build`.

Once you have a Dockerfile, you can build your application image (Here we will 
tag it as `php-app` for reference):

```bash
docker build -t php-app .
```

**Note:** Don't forget about the dot at the end

After your image is built, you can run it:

```bash
docker run -ti -p 80:80 php-app

# Additionally, you can mount a directory so that your code updates 
# automatically as you work:
docker run -ti -v "$(pwd):/var/www/vertex" -p 80:80 php-app
```

## What about Node.js?

> **WARNING:** Node.js is no longer a supported deployment platform on Vertex.
It's mainly there for build-time asset compilation (SCSS and JS).

Node.js projects can be setup without using `/opt/start.sh` since most Node.js 
project only require you to launch the server:

```bash
docker run -ti quay.io/etcinit/vertex -v "$(pwd):/app" \
    -p 3000:3000 node /app/index.js
```
### Example dockerfile:

Assuming that your application runs on port 3000:

```Dockerfile
FROM quay.io/etcinit/vertex:3.0.0

# Add the current directory into the image
ADD . /app

# Set the current working directory
WORKDIR /app

# Run install dependencies
RUN npm install

# Expose ports
EXPOSE 3000

# Logs volume
VOLUME ["/app/logs"]

# Start servers
CMD ["node /app/index"]
```

## Resources

Some additional reading and resources:

- [Docker Online Tutorial](https://www.docker.com/tryit/)
- [Managing data in containers](https://docs.docker.com/userguide/dockervolumes/)
- [Linking containers](https://docs.docker.com/userguide/dockerlinks/)
- [Port forwarding](https://github.com/wsargent/docker-cheat-sheet#exposing-ports)

### Got questions? Found a bug?

Open a ticket here on GitHub, or if you have a fix or improvement, create a 
Pull Request. Given that this is a Docker-only project there aren't any strict
contribution rules around code. Just keep every line under 80 characters, add
some descriptive comments, and it should be fine.

