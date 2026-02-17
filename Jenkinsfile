pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "bigkola1/java-react-example"
        IMAGE_TAG      = "${BUILD_NUMBER}"
        DOCKERHUB_CRED = credentials('dockerhub-creds')
        SSH_CRED       = 'ec2-server-key'
        EC2_USER       = 'ec2-user'
        EC2_HOST       = '13.59.195.211'
        APP_DIR        = '/home/ec2-user'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Big-Kola/aws-practice.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKERHUB_REPO:$IMAGE_TAG ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh """
                   echo $DOCKERHUB_CRED_PSW | docker login -u $DOCKERHUB_CRED_USR --password-stdin
                   docker push $DOCKERHUB_REPO:$IMAGE_TAG
                """
            }
        }

        stage('Deploy to EC2 via Docker Compose') {
            steps {
                sshagent(credentials: [SSH_CRED]) {
                    sh """
                        # Copy docker-compose.yaml to EC2
                        scp -o StrictHostKeyChecking=no docker-compose.yaml $EC2_USER@$EC2_HOST:$APP_DIR/

                        # SSH into EC2 and deploy safely
                        ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST '
                            cd $APP_DIR &&
                            export DOCKERHUB_REPO='$DOCKERHUB_REPO' &&
                            export IMAGE_TAG='$IMAGE_TAG' &&
                            docker-compose down --remove-orphans &&
                            docker-compose pull &&
                            docker-compose up -d &&
                            docker-compose ps
                        '
                    """
                }
            }
        }
    }
}
