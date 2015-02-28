![logo](https://i.imgur.com/Ai4VtYt.png)

# Vertex

A barebones Docker image with essentials for PHP and Node.js developement and deployment

#### Batteries included:

- Web servers: Nginx
- Runtimes: HHVM, Node.js, Python 2.7
- Package managers: NPM, Composer, Bower
- Build tools: Gulp, Grunt
- Testing: PHPUnit
- Development: Vim, Git
- Shells: Zsh with Oh-My-Zsh (default), Bash

#### What's new in v2?

- New default user: The user `vertex` and the group `vertices` are created so that your processes don't have to run as `root`. A home directory is provided and `/var/www/vertex` belongs ot the `vertices` group. _Note: HHVM and Nginx still currently require to run as `root`._
- Refactored build scripts: The build process of vertex is now clearer and easier to understand. Every component is installed by single scripts, so it is easy to add and remove components from the Dockerfile
- Support for Docker Compose: Direct use of the Docker engine is replaced with commands for Docker Compose, which automates  all the tasks provided by the Makefile in v1.
- The user shell is now set to Zsh for both the `root` and `vertex` users. `vertex` also has Oh-my-zsh installed by default.
- Upgraded to Ubuntu 14.10 from 14.04

#### Requirements

- Docker 1.3+
- Docker Compose (previously known as Fig)

Build status and docker stats: https://registry.hub.docker.com/u/eduard44/vertex/

## Getting started

Getting a shell inside a Vertex container is easy, even if it is your first time using Docker:

### Using Docker Hub

Pull down a pre-built image from the Docker Hub, and run zsh inside the container afterwards:

```sh
docker run -ti eduard44/vertex:2.0.0 begin
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
The provided Makefile essentially just calls Docker Compose for you and gets a shell up and going.

Alternatively, you may also just build the image:

```sh
make
```

#### Option 2: Using Docker Compose

With Docker Compose, it is also pretty easy to get a container running:

```sh
# First, build the image:
docker-compose build

# Then, login:
docker-compose run web begin
```

#### Option 3: Using the Docker CLI

If You would like to understand how the internal works, we recommend building the image by hand by interacting with the Docker CLI directly:

```sh
docker build -t vertex .

# This may take some time if it is the first Vertex image you 
# have built on your system

# Start hacking:
docker run -it vertex begin

# Allow a server to run on port 80:
docker run -it -p 80:80 vertex begin
```

### Getting your files inside the container:

Depending on which of the options above you chose to get Vertex running on your machine, you might have already some directories mounted inside the container.

#### Mounting

Docker has allows you to mount external directories or even share them between containers through a concept called Volumes. If you used the Makefile or Docker Compose, the current working directory was automatically mounted into `/var/www/vertex`

If you are using the Docker CLI, you can replicate this by using the `-v` parameter:

```sh
docker run -ti vertex -v $(pwd):/var/www/vertex

# Custom mapping are also possible:
docker run -ti vertex -v $(pwd):/opt/mynodeapp
docker run -ti vertex -v /home/user1/app:/opt/myapp
```

#### Using a Dockerfile and `ADD` or `COPY`:

If you are using Vertex as the base image of your project, you may add files to the image by using the `ADD` and `COPY` commands:

```Dockerfile
FROM eduard44/vertex:2.0.0
# ...

# It is possible to override the default PHP project:
ADD . /var/www/vertex

# Add arbitrary files:
ADD app.js /app.js

# Or even replace existing configuration files:
ADD default /etc/nginx/sites-available/default
```

## PHP Development

Vertex is a bit biased and has PHP setup as the main server even though it also supports other languages such as Node.js and Python. The main reasoning behind this is that setting up a PHP environment is more difficult than getting a Node.js or Python server running.

### Default project:

Vertex is pre-configured with a default PHP project inside `/var/www/vertex`. You can add any framework to this directory, such as Laravel, Wordpress, Symfony, or even your own. Public files are assumed to be in `/var/www/vertex/public`, which is where the  Nginx server will server files from.

This default setup is useful if you're looking to get a server running a PHP project with the least amount of config possible. However, if you need to change Nginx's or HHVM's you will need to add your own configurations files inside the container.

Note: Make sure that when adding files, they are still executable by HHVM which uses the `www-data` user.

> **IMPORTANT:** For more information on getting files on the container, read the section above. Using the Makefile or Docker Compose from the wrong directory could break the default project.

Once the server is running you should see the following page:

![Screenshot](http://i.imgur.com/ucJXOmm.png)

### From Docker Hub:

Mount the current directory into `/var/www/vertex` and start HHVM and Nginx:

```sh
docker run -it -v "$(pwd):/var/www/vertex" -p 80:80 eduard44/vertex
```

**Note:** This makes the assumption that your project has a `public` directory. Otherwise, modify the `-v` option to point to a directory with an `index.php` or `index.html` file.

### From the Vertex GitHub repository:

If you pulled `etcinit/vertex` from GitHub, you can run a server using the Makefile or manually:

#### Using Make:

Start an Nginx server with HHVM at port 80:

```sh
make server
```

#### Using the Docker CLI:

Start an Nginx server with HHVM at port 80:

```sh
docker run -t -i -p 80:80 -v $(pwd):/var/www/vertex vertex
```

## Dockerfiles and pre-built images

The purpose of Vertex is to have a prebuilt image with some of the basic dependencies for a Node.js/PHP project. The benefit? Saved time. This image
is built automatically at the Docker Hub. If one of your projects uses it as a base image, you don't need to waste time downloading common dependencies like NPM or Composer.

> **NOTE**: While Vertex saves some time, it is no replacement for a single purpose image. If you need a small image, please build your own or use one from the Docker Hub.

### Dockerfile workflow

__To use it as part of a project:__

Your project needs to have Dockerfile on the root directory of the project. Review the Docker documentation for more information about the syntax and purpose of this file.

Adding the following line to the top of your docker file specifies the base image:
```
FROM eduard44/vertex:2.0.0
```

> **NOTE:** Remove `FROM ubuntu` if you were using ubuntu as the base image. You can only have one base image. Vertex is based on Ubuntu 14.10

#### Example usage:

The following is an example of how to use Vertex in a PHP project:

```Dockerfile
FROM eduard44/vertex:2.0.0

# Add the current directory into the image
# This replaces the default PHP project
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

# Additionally, you can mount a directory so 
# that your code updates automatically as you work:
docker run -ti -v "$(pwd):/var/www/vertex" -p 80:80 myapp
```

### Standalone workflow:

It is also possible to get servers running using the image from Docker Hub, however this case is usually not suitable for deployment.

The following example assumes you are trying to run a Node.js project stored in `/home/user1/projects/myapp`:

```sh
docker pull eduard44/vertex

docker run -ti -v /home/user1/projects/myapp:/myapp -p 5000:5000 eduard44/vertex node /myapp/app.js
```

## What about Node.js?

Node.js projects can be setup without using `/opt/start.sh` since most Node.js project only require you to launch the server:

```bash
docker run -ti eduard44/vertex -v "$(pwd):/myapp" -p 3000:3000 node /myapp/index.js
```
### Example dockerfile:

Assuming that your application runs on port 3000:

```Dockerfile
FROM eduard44/vertex:2.0.0

# Add the current directory into the image
ADD . /myapp

# Set the current working directory
WORKDIR /myapp

# Run install dependencies
RUN npm install

# Expose ports
EXPOSE 3000

# Logs volume
VOLUME ["/myapp/logs"]

# Start servers
CMD ["node /myapp/index.js"]
```

## Resources

Some additional reading and resources:

- [Docker Online Tutorial](https://www.docker.com/tryit/)
- [Managing data in containers](https://docs.docker.com/userguide/dockervolumes/)
- [Linking containers](https://docs.docker.com/userguide/dockerlinks/)
- [Port forwarding](https://github.com/wsargent/docker-cheat-sheet#exposing-ports)

## License

Copyright (c) 2015 Eduardo Trujillo \<ed@chromabits.com\>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
