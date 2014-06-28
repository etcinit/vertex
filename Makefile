all:
		docker build -t vertex .

login:
		docker run -t -i vertex /bin/bash
