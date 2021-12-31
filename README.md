[![Python application test with Github Actions](https://github.com/csLinhart/udacity-azure-2/actions/workflows/python-app.yml/badge.svg)](https://github.com/csLinhart/udacity-azure-2/actions/workflows/python-app.yml)

# Overview

This project has been created during the [Azure DevOps Nanodegree on Udacity](https://www.udacity.com/course/cloud-devops-using-microsoft-azure-nanodegree--nd082).

After planning the different steps regarding the deployment of a Python Flask Machine Learning app, we will manage to add GitHub Actions and Azure Pipeline to it to have a fully working CI/CD environment.

## Project Plan

* [Trello Board] (https://trello.com/b/3DjXZVrv/udacity-azure-project-2)
* [Spreadsheet] (https://docs.google.com/spreadsheets/d/1qK27SxDIMCBIy7_c-t23Pbr4ey-1wDNjiXlEsZRy9lw/edit?usp=sharing)

## Instructions

Azure Cloud Shell

![Azure Cloud Shell](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/shell.PNG)

Azure CI

![Azure CI](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/CI.PNG)

Azure CD

![Azure CD](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/CD.PNG)

# Instructions

## Set up Azure Cloud Shell

### Create SSH keys

Launch an Azure Cloud Shell environment and create ssh-keys:

```
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

The id_rsa.pub file contains the key that needs to be uploaded to your GitHub account.
(GitHub > Settings > SSH and GPG keys > Paste > Add the key).

Then you can clone repositories of this Github account from the Azure envoronment without a password.

```
git clone git@github.com:csLinhart/udacity-azure-2.git
```

![Project cloned](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/git-clone.PNG)

### Create a virtual environment

```
python3 -m venv ~/.udacity-azure-2
source ~/.udacity-azure-2/bin/activate
```

### Install and run

```
make all
az webapp up -n flask-ml-service-CL-udacity -l southcentralus --sku B1
```

The `make all` command should deliver this output:

![make all 1](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/make-all1.PNG)
![make all 2](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/make-all2.PNG)

`az webapp up ...` creates a resource group with the App Service and the App Service plan:

![Azure Portal](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/portal.PNG)

Make sure to select a unique name for your app service.
In `make_predict_azure_app.sh`, in `-X POST https://<app-name>.azurewebsites.net:$PORT/predict`, replace <app-name> with the the name of your application.

Browse to https://<your-adress>.azurewebsites.net:

![Sklearn](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/sklearn.PNG)

## Configure GitHub Actions

### Create the workflow

GitHub > Actions > set up a workflow yourself

Replace the default template with:

```
name: Python application test with Github Actions

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python 3.5
      uses: actions/setup-python@v1
      with:
        python-version: 3.5
    - name: Install dependencies
      run: |
        make install
    - name: Lint with pylint
      run: |
        make lint
    - name: Test with pytest
      run: |
        make test
```

Commit this and run the Action:

![GitHub Actions](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/github-actions.PNG)

## Set up Azure Pipelines

Official [Microsot documentation](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops).

![Azure Deployment](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/deployment.PNG)

## Check the application

Run the bash scritp `make_predict_azure_app.sh`.

![Prediction](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/prediction.png)

### Access the logs

Inspect the logs from your running application here:

```
https://<app-name>.scm.azurewebsites.net/api/logs/docker
```


![Logs](https://github.com/csLinhart/udacity-azure-2/blob/master/Screenshots/docker-log.png)

## Enhancements

Set up different branches for different environments, e.g. Dev, Staging and Production. This will help to to test the latest code without having an impact on the Prod environment.

## Demo 

<TODO: Add link Screencast on YouTube>
