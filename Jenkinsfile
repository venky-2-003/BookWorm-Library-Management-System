pipeline {
    agent any

    environment {
        IMAGE_NAME = "bookworm-erd"
        IMAGE_TAG  = "latest"
        DOCKER_HUB_USER = "your-dockerhub-username"   // change this
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your repo that contains Dockerfile + BookWormLibraryManagementSystemERD.png
                git branch: 'main', url: 'https://github.com/your/repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Run Container (Test)') {
            steps {
                script {
                    sh "docker run -d -p 8080:80 --name ${IMAGE_NAME} ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Push to DockerHub') {
            when {
                expression { return env.BRANCH_NAME == 'main' } // only push from main branch
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                       echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                       docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                       """
                }
            }
        }
    }

    post {
        always {
            sh "docker rm -f ${IMAGE_NAME} || true"
        }
    }
}

