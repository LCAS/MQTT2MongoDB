pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('build') {
      steps {
        sh 'docker info'
        sleep(unit: 'MINUTES', time: 2)
      }
    }

    stage('dockerhub login') {
      steps {
        sh 'docker login -u $DOCKERUSER -p $DOCKERPASS'
      }
    }

    stage('push') {
      steps {
        sh 'docker push $DOCKERUSER/mqtt2mongodb:jenkins'
      }
    }

  }
  environment {
    DOCKERUSER = 'umsaldanha'
    DOCKERPASS = '253154Saldanha'
  }
}