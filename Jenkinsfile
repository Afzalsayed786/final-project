pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t final-project-app:latest ./app'
            }
        }

        stage('Test Application') {
            steps {
                sh '''
                    docker run -d --name final-project-test -p 5000:5000 final-project-app:latest
                    sleep 5
                    curl -f http://localhost:5000
                '''
            }
        }

        stage('Cleanup') {
            steps {
                sh 'docker rm -f final-project-test || true'
            }
        }
    }
}

