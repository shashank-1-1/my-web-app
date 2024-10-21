pipeline {
    agent any

    environment {
        OPENSHIFT_SERVER = "https://api.cacheocpnode.cacheocp.com:6443"
        OPENSHIFT_TOKEN  = "sha256~tCBViHM1YQkXQnG3PTEDuvfJXecj2ZQ9XUtOAF4zqYs"
        REGISTRY_URL = "docker.io/shashank325/test"
        DOCKER_USERNAME = "shashank325"
        DOCKER_PASSWORD = "Shashank@11"
    }

    stages { 
        stage('Build & Push Docker Image') {
            steps {
                // Build
                sh "docker build -t shashank325/test:my-web-app-${BUILD_NUMBER} ."

                // Docker login
                sh "echo \"${DOCKER_PASSWORD}\" | docker login -u ${DOCKER_USERNAME} --password-stdin"

                // Push
                sh "docker push shashank325/test:my-web-app-${BUILD_NUMBER}"
            }
        }
        stage('Deploy to OpenShift') {
            steps {
                sh "oc login ${OPENSHIFT_SERVER} --token=${OPENSHIFT_TOKEN}"
                sh "oc project shashanktest" // Replace with your project name
                sh "oc apply -f openshift/deployment.yaml" 
                sh "oc set image deployment/my-web-app my-web-app=docker.io/shashank325/test:my-web-app-${BUILD_NUMBER}"
            }
        }
    }
}
