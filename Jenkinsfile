pipeline {
    agent any

    stages {

        stage('Test') {
            steps {
                script {
                    echo 'Testing the app...'   // You can add shell commands here later
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
                    echo 'Deploying the app...'  // Replace with actual deploy commands later
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
