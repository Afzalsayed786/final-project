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
                    docker rm -f final-project-test || true
                    docker run -d --name final-project-test --network container:jenkins final-project-app:latest

                    for i in $(seq 1 15); do
                        if curl -fsS http://localhost:5000; then
                            echo "Application test passed!"
                            exit 0
                        fi
                        sleep 2
                    done

                    docker logs final-project-test
                    exit 1
                '''
            }
        }
    }

    post {
        always {
            sh 'docker rm -f final-project-test || true'
        }
        success {
            echo 'Jenkins pipeline completed successfully!'
        }
        failure {
            echo 'Jenkins pipeline failed. Check the Console Output.'
        }
    }
}
