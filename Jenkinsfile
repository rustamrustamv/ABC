pipeline {
    agent any

    stages {
        stage('Code Checkout') {
            steps {
                // point at your GitHub repo
                git url: 'https://github.com/rustamrustamv/ABC.git', 
				credentialsId: 'github-creds',
				branch: 'main'
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
				sh """
					# Copy the built WAR 
					cp \"${WORKSPACE}/target/ABCtechnologies-1.0.war\" \"${WORKSPACE}/abc.war\"

					# Build the Docker image from the workspace context
					docker build -t abc_tech:${BUILD_NUMBER} \"${WORKSPACE}\"

					# Tag the image for Docker Hub
					docker tag abc_tech:${BUILD_NUMBER} rustamrustamov/abc_tech:${BUILD_NUMBER}
				"""
			}
		}





        stage('Push Docker Image') {
			steps {
				withDockerRegistry([ credentialsId: 'dockerhub', url: '' ]) {
					// Push the build-number tag
					sh "docker push rustamrustamov/abc_tech:${BUILD_NUMBER}"
					// Also push latest
					sh "docker tag rustamrustamov/abc_tech:${BUILD_NUMBER} rustamrustamov/abc_tech:latest"
					sh "docker push rustamrustamov/abc_tech:latest"
				}
			}
		}


        stage('Deploy to Kubernetes') {
			steps {
				withKubeConfig(credentialsId: 'kubeconfig') {
					// Ensure we’re in the workspace root
					dir("${WORKSPACE}") {
						// Apply your manifests by referencing them explicitly
						sh 'kubectl apply -f deployment.yaml'
						sh 'kubectl apply -f service.yaml'
					}
				}
			}
		}
	}
}