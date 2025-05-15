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
        // 1) Copy the built WAR from target/ into abc.war at the root of the workspace
        sh 'cp /var/lib/jenkins/workspace/${JOB_NAME}/target/ABCtechnologies-1.0.war /var/lib/jenkins/workspace/${JOB_NAME}/abc.war'
        
        // 2) Build the Docker image, using this workspace 
        sh 'docker build -t abc_tech:${BUILD_NUMBER} /var/lib/jenkins/workspace/${JOB_NAME}'
        
        // 3) Tag it for your Docker Hub repo
        sh 'docker tag abc_tech:${BUILD_NUMBER} rustamrustamov/abc_tech:${BUILD_NUMBER}'
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
		
		
		
		stage('Deploy to Kubernetes') {
			steps {
				withKubeConfig(credentialsId: 'kubeconfig') {
					sh 'kubectl apply -f k8s/deployment.yaml'
					sh 'kubectl apply -f k8s/service.yaml'
				}
			}
		}

    }
}
