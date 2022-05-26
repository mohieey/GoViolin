pipeline {
    agent any
    tools {
        go 'go-1.18.2'
    }
    stages {
        stage("Start Building"){
            steps{
                sh "go mod init GoViolin"
                sh "go get github.com/stretchr/testify"
                sh "go mod vendor"
            }
            post{
                success{
                    slackSend channel: "#jenkins", message: "${JOB_NAME} bulid no: ${BUILD_NUMBER} has started.", color: "#467fd0"
                }
                failure{
                    slackSend channel: "#jenkins", message: "Building failed in the initial stage.", color: "#ffc107"
                }
            }
        }
        
        stage("Testing") {
            steps {
                sh "go test ./... -v"
            }
            
            post{
                failure{
                    slackSend channel: "#jenkins", message: "Testing failed.", color: "#ffc107"
                }
            }
        }

        stage("Compiling"){
            steps{
                sh "go build"
            }

            post{
                failure{
                    slackSend channel: "#jenkins", message: "Compiling the code failed.", color: "#ffc107"
                }
            }
        }

        stage("Building Docker Image"){
            steps{
                sh "docker build -t mohiey/goviolin:latest ."
            }

            post{
                failure{
                    slackSend channel: "#jenkins", message: "Building the docker image failed.", color: "#ffc107"
                }
            }
        }

        stage("Tagging Docker Image"){
            steps{
                sh "docker tag mohiey/goviolin:latest mohiey/goviolin:${BUILD_NUMBER}"
            }

            post{
                failure{
                    slackSend channel: "#jenkins", message: "Tagging the docker image failed.", color: "#ffc107"
                }
            }
        }

        stage("Pushing Image To DockerHub"){
            steps{
                withCredentials([
                    usernamePassword(credentialsId: "dockerhub", usernameVariable: "USER", passwordVariable: "PASS"),
                ]){
                    sh "docker push mohiey/goviolin:latest"
                    sh "docker push mohiey/goviolin:${BUILD_NUMBER}"
                }
            }

            post{
                failure{
                    slackSend channel: "#jenkins", message: "Pushing image to DockerHub failed.", color: "#ffc107"
                }
            }
        }
    } 

    post{
        always{
            cleanWs()
            sh "docker image rm mohiey/goviolin:latest mohiey/goviolin:${BUILD_NUMBER}"
        }
        success{
            slackSend channel: "#jenkins", message: "${JOB_NAME} build no: ${BUILD_NUMBER} succeeded and image mohiey/goviolin:${BUILD_NUMBER} was pushed to DockerHub.", color: "#42ba96"
        }
        failure{
            slackSend channel: "#jenkins", message: "${JOB_NAME} build no: ${BUILD_NUMBER} failed.", color: "#df4759"
        }
    }
}
