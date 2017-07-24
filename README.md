# AWS + Elastic Beanstalk + Docker + Python

Just a sample app. Check the commits for reference.

## Prepare your Local environment

    make prepare
    make deps


## Check your Docker container locally

Build a image and run a container.

    make docker_build
    make docker_run


## Prepare your AWS-EB environment

#### 1. Configure your AWS keys. 

Check the `.env` file for reference.

#### 2. Init, create/deploy and open the browser

    make eb_init
    make eb_create
    make eb_open

#### 3. Check your environment

    make eb_status
    make eb_logs

    make eb_ssh
    # Then, `cd /var/app/current/` or `cd /var/log/eb-docker/containers/eb-current-app/`

#### 4. Deploy updates

    make eb_deploy
