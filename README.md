
# Instabug: Infrastructure Internship 2022 Task  
  
  
# How that task was done  

## Created Dockerfile  
  
## Created an Ubuntu VM  
  
Used a digital ocean droplet for that purpose.  
  
## Installed Docker on it  
  
  
## Created a Jenkins Container  
  
`docker run -d \`  
`-p 8080:8080 \ `  
`-p 5000:5000 \ `  
`-v jenkins_home:/var/jenkins_home \`  
`-v /var/run/docker.sock:/var/run/docker.sock \ `  
`-v /usr/bin/docker:/usr/bin/docker \`  
`--name jenkins_server \ `  
`jenkins/jenkins:lts `  
  
The first volume is to persist Jenkins data and protect it from being deleted if the container was deleted.  
The second and third volumes are to make docker commands available inside the Jenkins container, then I logged into the Jenkins container as the root user to give read and write permissions on the `/var/run/docker.sock` path to the Jenkins user inside the container.  
  
## Installed Jenkins Plugins  
  
Installed Go plugin [Go plugin](https://plugins.jenkins.io/golang/).
  
Installed Slack Notification Plugin [Slack Notification Plugin](https://plugins.jenkins.io/slack/).  
  
Installed GCC compiler inside the Jenkins container.
  
## Configured Credentials  
  
Added DockerHub credentials to Jenkins store.  
  
## Created Declarative Pipeline Jenkinsfile And Created a Pipeline Item  
  
## Created A Kubernetes deployment and service files  
  
# You Can Find The Created Image At [mohiey/goviolin](https://hub.docker.com/repository/docker/mohiey/goviolin) on DockerHub  
  
  
  
## How To Run The App Using Docker  
You can run the app using docker by the following command and access it locally on http://localhost:8080/  
`docker run -p 8080:8080 --rm --name goviolin -it mohiey/goviolin`  
  
  
## How To Run The App Using Kubernetes  
If your kubectl tool is connected to a cluster like minikube for example, run `kubectl apply -f .` inside the project directory and you will be able to access the app by the link provided by the service, to get that link if you are using minikube, run `minikube service goviolin-service`.