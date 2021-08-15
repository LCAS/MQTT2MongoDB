pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('build') {
      steps {
        sh 'docker build -t $dockerhubuser/mqtt2mongodb:jenkins .'
      }
    }

    stage('dockerhub login') {
      steps {
        sh 'docker login -u $dockerhubuser -p $dockerhubpass'
      }
    }

    stage('push') {
      steps {
        sh 'docker push $dockerhubuser/mqtt2mongodb:jenkins'
      }
    }

  }
  environment {
    dockerhubuser = 'umsaldanha'
    dockerhubpass = '253154Saldanha'
  }
}