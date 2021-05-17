pipeline {
  environment {
    /*k8sCredential = 'k8s-jojoe'*/
    registryUrl = "https://harbor.touchzlab.com"
    registry = "harbor.touchzlab.com/touchzlab/"
    registryCredential = 'harbor-admin'
    dockerImage = ''
    DOCKER_TAG = getDockerTag()
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git url:'https://github.com/touchtot/TDMP-Project.git', branch:'dev'
      }
    }
  stages {
    stage('Building Image') {
      steps{
        script {         
          echo "touchzlab --> ${DOCKER_TAG}"
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
	  stage('Deployment K8s Dev') {
      steps {
        script {
        /*sh "sed -i 's/tagversion/${BUILD_NUMBER}/g' prometheus-deploy-v1.yaml"
        withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'touchzlab.k8s.local', contextName: 'kubernetes-admin@k8scluster.local', credentialsId: 'k8s-jojoe2', namespace: "", serverUrl: 'https://192.168.10.10:6443']]) {
             sh 'kubectl apply -f prometheus-deploy-v1.yaml --record' */
          echo "Skipped"
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        script {
        /*sh "docker rmi -f $registry:$BUILD_NUMBER"*/
          echo "Skipped"
      }
    }
  }
}
def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
