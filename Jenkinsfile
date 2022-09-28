pipeline {
  agent any

  tools {
    nodejs 'node-16.17.1'
  }

  stages {

    stage('Fetch code') {
      steps {
        git branch: 'develop', credentialsId: 'jenkins-dev-key', url: 'https://github.com/doomokun/cafe-web.git'
      }
    }

    stage('Test') {
      steps {
        sh 'docker --version'
      }
    }

    stage('Test node') {
      steps {
        sh 'npm version'
      }
    }

    // stage('Upload App image') {
    //   post {
    //     success {
    //       echo 'Now Archiving it ...'
    //       archiveArtifacts artifacts: '**/dict' 
    //     }
    //   }
    // }

  }
}