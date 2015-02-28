all:
	docker-compose build

login:
	docker-compose run web sh /vertex/login.sh

server:
	docker-compose up
