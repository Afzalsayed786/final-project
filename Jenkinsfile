pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-north-1'
        ECR_REPOSITORY = '295028317770.dkr.ecr.eu-north-1.amazonaws.com/final-project-app'
    }

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

        stage('Push Image to Amazon ECR') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-ecr-credentials',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    sh '''
                        set -eu
                        export AWS_DEFAULT_REGION="$AWS_REGION"

                        aws ecr get-login-password --region "$AWS_REGION" |
                            docker login --username AWS --password-stdin "$ECR_REPOSITORY"

                        docker tag final-project-app:latest "$ECR_REPOSITORY:latest"
                        docker tag final-project-app:latest "$ECR_REPOSITORY:$BUILD_NUMBER"

                        docker push "$ECR_REPOSITORY:latest"
                        docker push "$ECR_REPOSITORY:$BUILD_NUMBER"

                        docker logout "$ECR_REPOSITORY"
                    '''
                }
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
