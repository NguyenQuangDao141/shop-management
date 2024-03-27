pipeline {

    agent any

    tools {
        maven 'daonq-maven'
    }
    environment {
        MYSQL_USER_LOGIN = credentials('mysql-user-login')
    }
    stages {

        stage('Build with Maven') {
            steps {
                sh 'mvn --version'
                sh 'java -version'
                sh 'mvn clean package -Dmaven.test.failure.ignore=true'
            }
        }

        stage('Packaging/Pushing imagae') {

            steps {
                withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t daonq141/shop-management:v1 .'
                    sh 'docker push daonq141/shop-management:v1'
                }
            }
        }

        stage('Deploy MySQL to DEV') {
            steps {
                echo 'Deploying and cleaning'
                sh 'docker compose -f docker/mysql/mysql-docker-compose.yml down'
                sh 'docker compose -f docker/mysql/mysql-docker-compose.yml up -d'
                sh 'sleep 20'
                sh "docker exec -i khalid-mysql mysql --user=root --password=${MYSQL_USER_LOGIN_PSW} < docker/mysql/script"
            }
        }

        stage('Deploy Spring Boot to DEV') {
            steps {
                echo 'Deploying and cleaning'
                sh 'docker image pull daonq141/shop-management:v1'
                sh 'docker container stop shop-management || echo "this container does not exist" '
                sh 'docker network create dev || echo "this network exists"'
                sh 'echo y | docker container prune '

                sh 'docker container run -d --rm --name shop-management -p 8081:8080 --network dev daonq141/shop-management:v1'
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