// Jenkinsfile for Dhananjayan Fashions demo pipeline
pipeline {
  agent any
  environment {
    REGISTRY = "dhananjayan-fashions-demo"
    IMAGE_TAG = "${env.BUILD_NUMBER}"
  }
  stages {
    stage('Checkout') {
      steps {
        // Pull code from GitHub
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/<your-user>/dhananjayan-fashions-devops.git']]])
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          // Build docker image from Dockerfile in repo root
          docker.build("${REGISTRY}:${IMAGE_TAG}")
        }
      }
    }
    stage('Run Docker Container (smoke test)') {
      steps {
        script {
          // Run the container for quick smoke test
          def app = docker.image("${REGISTRY}:${IMAGE_TAG}").run('-p 3000:3000')
          sleep 10
          // Stop the container after basic check
          app.stop()
        }
      }
    }
    stage('Push Image (optional for demo, requires registry creds)') {
      when {
        expression { return false } // set true and configure credentials for real pushes
      }
      steps {
        echo 'Image push step is skipped by default in college demo mode.'
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
