pipeline {
    agent any

    stages {
        stage('Code Checkout') {
            steps {
                // point at your GitHub repo
                git url: 'https://github.com/rustamrustamv/ABC.git', branch: 'main'
            }
        }

        stage('Code Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn package'
            }
        }

        
        stage('Build Docker Image') {
            steps {
                // copy your actual WAR into a flat name for the Docker context
                 sh 'cp /var/lib/jenkins/workspace/${JOB_NAME}/target/ABCtechnologies-1.0.war /var/lib/jenkins/workspace/${JOB_NAME}/abc.war'

                // build & tag locally
                sh "docker build -t abc_tech:${BUILD_NUMBER} ."
                // tag for your Docker Hub namespace
                sh "docker tag abc_tech:${BUILD_NUMBER} rustamrustamv/abc_tech:${BUILD_NUMBER}"
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub', url: '' ]) {
                    sh "docker push rustamrustamov/abc_tech:${BUILD_NUMBER}"
                }
            }
        }

        stage('Deploy as Container') {
            steps {
                sh "docker run -d -P rustamrustamov/abc_tech:${BUILD_NUMBER}"
            }
        }
    }
}
