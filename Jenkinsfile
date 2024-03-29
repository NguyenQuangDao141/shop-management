pipeline {
    agent {label 'agent1'}
    tools {
        maven 'daonq-maven'
    }
    environment {
        DOCKERHUB_LOGIN = credentials('dockerhub')
    }
    stages {
        stage('Start'){
            agent any
            stages{
                stage('Build With Maven') {
                    steps {
                        sh 'mvn --version'
                        sh 'java -version'
                        sh 'mvn clean package -Dmaven.test.failure.ignore=true'
                    }
                }
                stage('Build Docker Image '){
                    steps{
                        sh 'docker build -t daonq141/shop-management:latest .'
                    }
                }
                stage('Login to Dockerhub'){
                    steps{
                        sh('echo $DOCKERHUB_LOGIN_PSW | docker login -u $DOCKERHUB_LOGIN_USR --password-stdin')
                    }
                }
                stage('Pushing image') {
                    steps {
                        sh 'docker push daonq141/shop-management:latest'
                    }
                }
                stage('Deploy Application to DEV') {
                    steps {
                        echo 'Deploying and cleaning'
                        sh ' docker image pull daonq141/shop-management'
                        sh ' docker container stop shop-management || echo "this container does not exist" '
                        sh ' docker network create dev || echo "this network exists"'
                        sh ' y |  docker container prune '
                        sh ' docker container run -d --rm --name shop-management -p 8081:8080 --network dev daonq141/shop-management'
                    }
                }
            }
        }
        stage('Deploy Application to PRODUCT'){
            agent{
                docker {
                    image 'khaliddinh/ansible'
                }
            }
            environment {
                    ANSIBLE_HOST_KEY_CHECKING = 'False'
                }
            stages{
                stage('deploy...'){
                    steps {
                        withCredentials([file(credentialsId: 'ansible_key', variable: 'ansible_key')]) {
                            sh 'ls -la'
                            sh "cp /$ansible_key ansible_key"
                            sh 'cat ansible_key'
                            sh 'ansible --version'
                            sh 'ls -la'
                            sh 'chmod 400 ansible_key '
                            sh 'ansible-playbook -i hosts --private-key ansible_key playbook.yml'
                        }
                    }
                }
            }
        }

    }
    post {
        // Clean after build
        always {
            cleanWs()
        }
    }
}