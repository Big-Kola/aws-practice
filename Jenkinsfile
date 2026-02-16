pipeline {
    agent any

    environment {
        IMAGE_NAME = "bigkola1/java-react-example:latest"
        EC2_IP = "13.59.195.211"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build App') {
            steps {
                sh './gradlew clean build'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                        docker push ${IMAGE_NAME}
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-server-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ec2-user@${EC2_IP} '
                            # Stop and remove any container using port 7071
                            EXISTING=\$(docker ps -q -f "publish=7071")
                            if [ ! -z "\$EXISTING" ]; then
                                docker stop \$EXISTING
                                docker rm \$EXISTING
                            fi

                            # Pull latest image and run
                            docker pull ${IMAGE_NAME}
                            docker run -d -p 7071:7071 --name java-react-app ${IMAGE_NAME}
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline finished successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
