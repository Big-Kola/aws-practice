pipeline {
    agent any

    stages {

        stage('Test') {
            steps {
                script {
                    echo 'Testing the app...' 
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    echo 'Building the app...'  // Replace with actual build commands later
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def dockerCmd = 'docker run -p 7071:7071 -d bigkola1/java-react-example:latest'
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.59.195.211 ${dockerCmd}"
                    }
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
