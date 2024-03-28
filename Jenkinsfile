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

        stage('Build with Maven') {
            steps {
                sh 'mvn --version'
                sh 'java -version'
                sh 'mvn clean package -Dmaven.test.failure.ignore=true'
            }
        }
        stage('Build image '){
            steps{
                sh 'sudo docker build -t daonq141/shop-management:v1 .'
            }
        }
        stage('Login to dockerhub'){
            steps{
                sh('echo $DOCKERHUB_LOGIN_PSW | sudo docker login -u $DOCKERHUB_LOGIN_USR --password-stdin')
            }
        }
        stage('Pushing image') {
            steps {
                sh 'sudo docker push daonq141/shop-management:v1'
            }
        }


        stage('Deploy Application to DEV') {
            steps {
                echo 'Deploying and cleaning'
                sh 'sudo docker image pull daonq141/shop-management:v1'
                sh 'sudo docker container stop shop-management || echo "this container does not exist" '
                sh 'sudo docker network create dev || echo "this network exists"'
                sh 'echo y | sudo docker container prune '

                sh 'sudo docker container run -d --rm --name shop-management -p 8081:8080 --network dev daonq141/shop-management:v1'
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