pipeline {
  agent any
  stages {
    stage('error') {
      steps {
        sh 'docker login -u $DOCKERUSER -p $DOCKERPASS'
      }
    }

  }
  environment {
    DOCKERUSER = 'umsaldanha'
    DOCKERPASS = '253154Saldanha'
  }
}