# AWS + Elastic Beanstalk + Docker + Python

Just a sample app. Check the commits reference.

## Prepare the Local environment

    make prepare
    make deps

## Prepare de EB environment

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
