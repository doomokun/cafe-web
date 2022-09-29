pipeline {
  agent any

  // tools {
  //   nodejs 'node-16.17.1'
  // }

  stages {

    stage('Fetch code') {
      steps {
        git branch: 'develop', credentialsId: 'jenkins-dev-key', url: 'https://github.com/doomokun/cafe-web.git'
      }
    }

    // stage('Test') {
    //   steps {
    //     sh 'docker --version'
    //     sh 'npm version'
    //   }
    // }

    // stage('Test') {
    //   steps {
    //     sh 'npm install'
    //   }
    // }

    // stage('Build') {
    //   steps {
    //     sh 'npm run build'
    //   }

    //   post {
    //     success {
    //       echo 'Now Archiving it ...'
    //       sh 'tar -czf dist.tar.gz ./dist'
    //       archiveArtifacts artifacts: 'dist.tar.gz' 
    //     }
    //   }
    // }

    stage('Docker Build') {
      steps {
        // sh 'docker-compose -f build.yml up --exit-code-from fpm_build --remove-orphans fpm_build'
        sh 'docker compose ps'
      }
    }

  }
}