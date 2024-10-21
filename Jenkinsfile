pipeline {
  agent any
  stages {
    stage('Test Credentials') { 
      steps {
        build job: 'Test-Credentials-Pipeline', propagate: false 
      }
    } 

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/shashank-1-1/my-web-app.git'
      }
    }

    stage('Build & Push Docker Image') {
      steps {
        sh "docker build -t ${REGISTRY_URL}/my-web-app:$BUILD_NUMBER ."
        sh "echo \"${DOCKER_PASSWORD}\" | docker login ${REGISTRY_URL} -u ${DOCKER_USERNAME} --password-stdin"
        sh "docker push ${REGISTRY_URL}/my-web-app:$BUILD_NUMBER"
      }
    }

    stage('Deploy to OpenShift') {
      steps {
        sh "oc login ${OPENSHIFT_SERVER} --token=${OPENSHIFT_TOKEN}"
        sh "oc project shashanktest"
        sh "oc apply -f openshift/deployment.yaml"
      }
    }
  }
}
