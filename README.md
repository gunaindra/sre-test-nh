# Provision Virtual Machine on Google Cloud
- Run terraform apply to create four VM (chef-server, VM01, VM02 and VM03) automatically on google cloud On this provision will include VM Creation and network creation such as Public IP and firewall also startup initialization to running yum update and install needed software like wget, curl, git and vim

# Provision needed services on each VM
- First, running ansible docker playbook to install docker on each VM
- After docker succesfully installed then we initiate docker swarm by running docker-swarm playbook with roles swarm init on manager node and swarm node on worker node. This is divided into two parts, initiate swarm manager on VM01 and join swarm worker on VM02.
- Install Jenkins docker by running install jenkins playbook. It will install jenkins master on VM01. 
- Create jenkins-swarm-agent by running ansible jenkins-swarm-agent playbook and running jar file on background using screen command.

# How Pipeline Works

![Untitled Diagram drawio (2)](https://user-images.githubusercontent.com/13705024/192957898-d63a3039-de97-4459-a1ce-ead377e83c59.png)

- This pipeline on Jenkins will scan changes on a defined github repository and look for Jenkinsfile. Note: We need to choose scan repository on Jenkins when there are changes on Github Repository. Would be better if we create a webhook on Github to trigger the Jenkins pipeline.

<img width="1677" alt="image" src="https://user-images.githubusercontent.com/13705024/192957709-e92bad92-72ae-47d0-ba5f-d404479562fe.png">

- After scan completed and found Jenkinsfile and change it will build and deploy on stage phase. If the stage fails it will stop the build process and will not continue to the next phase.
- When stage phase successfully it will deploy stack to node production and scale into other worker node.
