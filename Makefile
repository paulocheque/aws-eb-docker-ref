ELB_ENV=aws-eb-docker-sample
ELB_MACHINE=t2.micro


info:
	@env/bin/python --version
	@docker --version
	@env/bin/eb --version

clean:
	@find . -name "*.pyc" -delete

prepare:
	@clear ; python3.6 -m venv env

deps:
	@env/bin/pip install -r requirements.txt

shell:
	@env/bin/python

# EB

eb_init:
	@clear
	@echo "Creating the .elasticbeanstalk/config.yml file."
	env/bin/eb init

eb_create:
	@clear
	time env/bin/eb create ${ELB_ENV} --cname ${ELB_ENV} --instance_type '${ELB_MACHINE}' --scale 1 --timeout 5 --single

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
	env/bin/eb logs ${ELB_ENV}
