pipeline {

    agent any

    tools {
        maven 'my-maven'
    }
    environment {
        MYSQL_ROOT_LOGIN = credentials('mysql-root-login')
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
                    sh 'docker build -t khaliddinh/springboot .'
                    sh 'docker push khaliddinh/springboot'
                }
            }
        }

        stage('Deploy MySQL to DEV') {
            steps {
                echo 'Deploying and cleaning'
                sh 'docker compose -f docker/mysql/mysql-docker-compose.yml up -d'
                sh 'sleep 20'
                sh "docker exec -i khalid-mysql mysql --user=root --password=${MYSQL_ROOT_LOGIN_PSW} < docker/mysql/script"
            }
        }

        stage('Deploy Spring Boot to DEV') {
            steps {
                echo 'Deploying and cleaning'
                sh 'docker image pull khaliddinh/springboot'
                sh 'docker container stop khalid-springboot || echo "this container does not exist" '
                sh 'docker network create dev || echo "this network exists"'
                sh 'echo y | docker container prune '

                sh 'docker container run -d --rm --name khalid-springboot -p 8081:8080 --network dev khaliddinh/springboot'
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