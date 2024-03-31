pipeline {
    agent none
    tools {
        maven 'daonq-maven'
    }
    environment {
        DOCKERHUB_LOGIN = credentials('dockerhub')
    }
    stages {
        stage('Build With Maven') {
            agent any
            steps {
                sh 'mvn --version'
                sh 'java -version'
                sh 'mvn clean package -Dmaven.test.failure.ignore=true'
            }
        }
        stage('Build Docker Image '){
            agent any
            steps{
                sh 'docker build -t daonq141/shop-management:latest .'
            }
        }
        stage('Login to Dockerhub'){
            agent any
            steps{
                sh('echo $DOCKERHUB_LOGIN_PSW | docker login -u $DOCKERHUB_LOGIN_USR --password-stdin')
            }
        }
        stage('Pushing image') {
            agent any
            steps {
                sh 'docker push daonq141/shop-management:latest'
            }
        }
        stage('Deploy Application to DEV') {
            agent any
            steps {
                echo 'Deploying and cleaning'
                sh ' docker image pull daonq141/shop-management'
                sh ' docker container stop shop-management || echo "this container does not exist" '
                sh ' docker network create dev || echo "this network exists"'
                sh ' y |  docker container prune '
                sh ' docker container run -d --rm --name shop-management -p 8081:8080 --network dev daonq141/shop-management'
            }
        }
        stage('Prepare for deploying to PRODUCTION'){
            input {
                id 'productionDeploy'
                message 'Proceed with production deployment?'
                ok 'Deploy'
            }
            stages {
                stage('Deploy Application to Production') {
                    agent{
                        docker {
                            image 'khaliddinh/ansible'
                            }
                        }
                    environment {
                        ANSIBLE_HOST_KEY_CHECKING = 'False'
                    }
                    steps {
                        withCredentials([file(credentialsId: 'ec2_private_key', variable: 'ec2_private_key')]) {
                            sh 'ls -la'
                            sh "cp /$ec2_private_key ec2_private_key"
                            sh 'cat ec2_private_key'
                            sh 'ansible --version'
                            sh 'ls -la'
                            sh 'chmod 400 ec2_private_key '
                            sh 'ansible-playbook -i hosts --private-key ec2_private_key playbook.yml'
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