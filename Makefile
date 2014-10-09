all:
	docker build -t vertex .

login:
	docker run -t -i vertex /bin/bash

server:
	docker run -t -i -p 80:80 vertex
