pipeline {
  agent { docker 'node:current-alpine' }
  stages {
    stage('build') {
      steps {
        sh 'npm --version'
      }
    }
  }
}