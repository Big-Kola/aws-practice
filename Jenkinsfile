pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "bigkola1/java-react-example"
        DOCKERHUB_CRED = credentials('dockerhub-creds')   // Jenkins Docker Hub credential ID
        SSH_CRED       = 'ec2-ssh'                        // Jenkins SSH credential ID
        EC2_USER       = 'ec2-user'
        EC2_HOST       = '13.59.195.211'
        APP_PORT       = '7071'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Big-Kola/aws-practice.git'
            }
        }

        stage('Build App') {
            steps {
                // Using system-installed Gradle since no gradlew in repo
                sh 'gradle clean build'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKERHUB_REPO:$BUILD_NUMBER ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh """
                   echo $DOCKERHUB_CRED_PSW | docker login -u $DOCKERHUB_CRED_USR --password-stdin
                   docker push $DOCKERHUB_REPO:$BUILD_NUMBER
                """
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: [SSH_CRED]) {
                    sh """
                       ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST '
                         docker pull $DOCKERHUB_REPO:$BUILD_NUMBER &&
                         docker stop java-react-app || true &&
                         docker rm java-react-app || true &&
                         docker run -d --name java-react-app -p $APP_PORT:$APP_PORT $DOCKERHUB_REPO:$BUILD_NUMBER
                       '
                    """
                }
            }
        }
    }
}
