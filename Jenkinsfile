pipeline {
  agent any
  stages {
    stage('DOCKER LOGIN') {
      steps {
        sh 'apt-get install gnupg2 pass -yqq'
        sh 'docker login -u $DOCKERUSER -p $DOCKERPASS'
        sh 'docker images'
      }
    }

  }
  environment {
    DOCKERUSER = 'umsaldanha'
    DOCKERPASS = '253154Saldanha'
  }
}