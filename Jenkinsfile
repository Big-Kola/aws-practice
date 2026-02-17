pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "bigkola1/java-react-example"
        DOCKERHUB_CRED = credentials('dockerhub-creds')
        SSH_CRED       = 'ec2-server-key'
        EC2_USER       = 'ec2-user'
        EC2_HOST       = '13.59.195.211'
        APP_DIR        = '/home/ec2-user'  // deployment folder on EC2
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Big-Kola/aws-practice.git'
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

        stage('Deploy to EC2 via Shell Script') {
            steps {
                sshagent(credentials: [SSH_CRED]) {
                    sh """
                        # Copy docker-compose.yaml to EC2
                        scp -o StrictHostKeyChecking=no docker-compose.yaml $EC2_USER@$EC2_HOST:$APP_DIR/

                        # SSH into EC2 and run the deploy script
                        ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST '
                            /home/ec2-user/deploy.sh
                        '
                    """
                }
            }
        }
    }
}
