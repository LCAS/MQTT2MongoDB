pipeline {
  agent any
  stages {
    stage('DOCKER LOGIN') {
      steps {
        sh '''echo USERNAME: $DOCKERUSER
echo PASSWORD: $DOCKERPASS
echo $DOCKERPASS | docker login -u $DOCKERUSER --password-stdin'''
      }
    }

  }
  environment {
    DOCKERUSER = 'umsaldanha'
    DOCKERPASS = '253154Saldanha'
  }
}