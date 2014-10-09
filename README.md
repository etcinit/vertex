![logo](https://raw.githubusercontent.com/eduard44/vertex/master/logo.png)

# Vertex

A barebones Docker image with node, grunt and bower

## Getting started

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

## Getting started: Using Make

Using `make` simplify the process:

```
$ cd vertex
$ make
```

"Login" to the container:

```
$ make login
```

## Using the default project

Vertex is pre-configured with a default PHP project in `/var/www/vertex`. You may add a Laravel project to this directory or your own PHP framework here. Public files are assumed to be in `/var/www/vertex/public`. 

This is useful if you're looking to get a server running a PHP project with the least amount of config possible

Note: Make sure that when adding files, they are still executable by HHVM

### Using Make:

Start an Nginx server with HHVM at port 80:

```
$ make server
```

### Manually:

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
