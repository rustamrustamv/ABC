pipeline {
    agent any

    stages {
        stage('Code Checkout') {
            steps {
                // replace with your GitHub repo URL and branch if different
                git url: 'https://github.com/rustamrustamv/ABC.git', branch: 'main'
            }
        }

        stage('Code Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Packaging') {
            steps {
                sh 'mvn package'
            }
        }
    }

    post {
        success {
            echo '✅ Build, test and package all succeeded!'
        }
        failure {
            echo '❌ Something went wrong. Check the console output above.'
        }
    }
}
