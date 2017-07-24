DOCKER_REF=paulocheque/aws-eb-docker-ref:v1
DOCKER_CONTAINER_NAME=pc-docker-ref
DOCKER_CONTAINER_ID=`docker ps -n 1 -q`

ELB_ENV=aws-eb-docker-sample
ELB_MACHINE=t2.micro


info:
	@env/bin/python --version
	@docker --version
	@env/bin/eb --version

clean:
	@find . -name "*.pyc" -delete

prepare:
	@virtualenv env -p python2.7

deps:
	@env/bin/pip install -r requirements-dev.txt
	@env/bin/pip install -r requirements.txt

shell:
	@env/bin/python


# Docker

docker_build:
	# Create a Docker image using the Dockerfile
	@clear
	docker build -f Dockerfile --tag ${DOCKER_REF} .
	docker images

docker_run:
	@clear
	# PORT_HOST:PORT_CONTAINER
	# Host 7999 => Docker Nginx 8000
	# Host 8000 => Docker Gunicorn 8001
	# Docker Nginx 8000 => Docker Gunicorn 8001
	@open "http://localhost:7999" # Gunicorn
	docker run -i -p 7999:8000 -p 8000:8001 ${DOCKER_REF}
	docker ps -l


# Elastic Beanstalk

eb_init:
	@clear
	@echo "Creating the .elasticbeanstalk/config.yml file."
	env/bin/eb init

eb_create:
	@clear
	time env/bin/eb create ${ELB_ENV} --cname ${ELB_ENV} --instance_type '${ELB_MACHINE}' --single --timeout 5

eb_open:
	@env/bin/eb open ${ELB_ENV}

eb_status:
	@clear
	env/bin/eb status ${ELB_ENV}

eb_ssh:
	@clear
	env/bin/eb ssh ${ELB_ENV}

eb_logs:
	@clear
	env/bin/eb events ${ELB_ENV}
	env/bin/eb logs ${ELB_ENV} --no-verify-ssl

eb_deploy:
	env/bin/eb deploy ${ELB_ENV} --timeout 5
