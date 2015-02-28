![logo](https://i.imgur.com/Ai4VtYt.png)

# Vertex

A barebones Docker image with essentials for PHP and Node.js developement and deployment

#### Components included:

- Nginx
- HHVM
- Node.js
- NPM
- Composer
- Grunt
- Bower
- Gulp
- PHPUnit
- Vim

Build status and docker stats: https://registry.hub.docker.com/u/eduard44/vertex/

## Getting started

Getting a bash shell inside a Vertex container is easy:

### Using Docker Hub

Pull down a pre-built image from the Docker Hub, and run bash inside the container afterwards:

```
$ docker run -ti eduard44/vertex /bin/bash
```

### Using Make

Using `make` simplify the process:

```
$ cd vertex
$ make
```

"Login" to the container:

```
$ make login
```

### From the source code:

First, you need to clone this git repository

Then, build the docker image:

```
$ cd vertex
$ docker build -t vertex .
```

This will take some time if it is the first Docker image you have built
on your system

Start hacking:
```
$ docker run -i -t vertex /bin/bash
```

This will open a shell session inside the container

## Using the default PHP project

Vertex is pre-configured with a default PHP project inside `/var/www/vertex`. You may add a Laravel project to this directory or your own PHP framework here. Public files are assumed to be in `/var/www/vertex/public`, which is where the  Nginx server will server files from.

This default setup is useful if you're looking to get a server running a PHP project with the least amount of config possible. However, if you need to change Nginx's or HHVM's you will need to add your own configurations files inside the container.

Note: Make sure that when adding files, they are still executable by HHVM. The user is `www-data`.

Once the server is running you should see the following page:

![Screenshot](http://i.imgur.com/ucJXOmm.png)

### Using Docker Hub:

Mount the current directory into `/var/www/vertex` and start HHVM and Nginx:

```
$ docker run -it -v "$(pwd):/var/www/vertex" -p 80:80 eduard44/vertex
```

**Note:** This makes the assumption that your project has a `public` directory. Otherwise, modify the `-v` option to point to a directory with an `index.php` or `index.html` file.

### Using the Vertex GitHub repository:

If you pulled `eduard44/vertex` from GitHub, you can run a server using the Makefile or manually:

#### Using Make:

Start an Nginx server with HHVM at port 80:

```
$ make server
```

#### Manually:

Start an Nginx server with HHVM at port 80:

```
docker run -t -i -p 80:80 vertex
```

## Dockerfiles and pre-built images

The purpose of Vertex is to have a prebuilt image with some of the basic dependencies for a Node.js/PHP project. The benefit? Speed. This image
is built automatically at the Docker Hub. If one of your projects uses it as a base image, you don't need to waste time downloading common dependencies like NPM or Composer.

__To use it as part of a project:__

Your project needs to have Dockerfile on the root directory of the project.

Adding the following line to the top of your docker file specifies the base image:
```
FROM eduard44/vertex
```

Note: Remove `FROM ubuntu` if you were using ubuntu as the base image.

### Dockerfile workflow

The following is an example of how to use Vertex in a PHP project:

```bash
FROM eduard44/vertex

# Add the current directory into the image
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
If you don't mount your project using the `-v` tag while using `docker run`, your code won't automatically update inside the container; it will only update during a `docker build`.

Once you have a dockerfile you can build your application image (Here we will tag it as `myapp` for reference):

```bash
docker build -t myapp .
```

**Note:** Don't forget about the dot at the end

After your image is built, you can run it:

```bash
docker run -ti -p 80:80 myapp
```

Additionally, you can mount a directory so that your code updates automatically:

```bash
docker run -ti -v "$(pwd):/var/www/vertex" -p 80:80 myapp
```

### To download the standalone image:

The image is usually automatically downloaded as part of the build process, but you can manually downloaded it by running the following:

```bash
docker pull eduard44/vertex
```

## What about Node.js?

Node.js projects can be setup without using `/opt/start.sh` since most Node.js project only require you to launch the server:

```bash
docker run -ti eduard44/vertex -v "$(pwd):/myapp" -p 3000:3000 node /myapp/index.js
```
### Example dockerfile:

Assuming that your application runs on port 3000:

```bash
FROM eduard44/vertex

# Add the current directory into the image
ADD . /myapp

# Set the current working directory
WORKDIR /myapp

# Run composer update
RUN npm install

# Expose ports
EXPOSE 3000

# Logs volume
VOLUME ["/myapp/logs"]

# Start servers
CMD ["node /myapp/index.js"]
```

## Resources

- [Linking containers](https://docs.docker.com/userguide/dockerlinks/)
- [Port forwarding](https://github.com/wsargent/docker-cheat-sheet#exposing-ports)
