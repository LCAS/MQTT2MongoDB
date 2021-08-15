pipeline {
  agent any
  stages {
    stage('error') {
      steps {
        sh '''docker build --tag umsaldanha/mqtt2mongodb:jenkins .
'''
      }
    }

  }
  environment {
    DOCKERUSER = 'umsaldanha'
    DOCKERPASS = '253154Saldanha'
  }
}