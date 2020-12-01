pipeline {
  environment {
    /*k8sCredential = 'k8s-jojoe'*/
    registryUrl = "https://harbor.touchzlab.com"
    registry = "harbor.touchzlab.com/touchzlab/"
    registryCredential = 'harbor-admin'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Building Image') {
      steps{
        script {         
          /*echo "touchzlab --> ${DOCKER_TAG}"*/
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( registryUrl, registryCredential ) {
            dockerImage.push()
            /*dockerImage.push('latest')*/
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        script {
        sh "docker rmi -f $registry:$BUILD_NUMBER"
      }
    }
  }
}
