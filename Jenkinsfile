pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('build') {
      steps {
        sh 'docker build --tag umsaldanha/mqtt2mongodb:jenkins .'
      }
    }

    stage('dockerhub login') {
      steps {
        sh 'docker login -u umsaldanha -p 253154Saldanha'
      }
    }

    stage('push') {
      steps {
        sh 'docker push umsaldanha/mqtt2mongodb:jenkins'
      }
    }

  }
  environment {
    dockerhubuser = 'umsaldanha'
    dockerhubpass = '253154Saldanha'
  }
}