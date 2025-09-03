pipeline {
    agent any

   

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
    credentialsId: 'github-creds',
    url: 'https://github.com/venky-2-003/BookWorm-Library-Management-System.git'

            }
        }

        stage('Build Docker Image') {
            steps {
               sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG}'
            }
        }

        stage('Run Container (Test)') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME || true
                    docker run -d --name $CONTAINER_NAME -p 8081:8080 $DOCKER_IMAGE:latest
                '''
      
            }
        }
    }

   
}
