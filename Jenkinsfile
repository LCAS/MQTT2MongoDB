pipeline {
  agent any
  stages {
    stage('error') {
      steps {
        sh '''sleep 10
docker ps
sleep 10
docker info'''
      }
    }

  }
  environment {
    DOCKERUSER = 'umsaldanha'
    DOCKERPASS = '253154Saldanha'
  }
}