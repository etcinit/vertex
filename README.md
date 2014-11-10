![logo](https://raw.githubusercontent.com/eduard44/vertex/master/logo.png)

# Vertex

A barebones Docker image with node, grunt and bower

## Getting started

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

## Using the default project

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

The purpose of this dockerfile is to have a prebuilt image with some of the
basic dependencies for a node.js project. The benefit? Speed. This image
is built automatically at the Docker Hub and all you need to do is download it.

__To use it as part of a project:__

Add the following line to the top of your docker file:
```
FROM eduard44/vertex
```

Note: Remove `FROM ubuntu` if you were using ubuntu as the base image.

__To download the standalone image:__

Run the following commands:

```
$ docker pull eduard44/vertex
```
