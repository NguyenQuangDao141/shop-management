pipeline {

    agent any

    tools {
        maven 'daonq-maven'
    }
    environment {
        MYSQL_USER_LOGIN = credentials('mysql-user-login')
        DOCKERHUB_LOGIN = credentials('dockerhub')
    }
    stages {

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
    post {
        // Clean after build
        always {
            cleanWs()
        }
    }
}