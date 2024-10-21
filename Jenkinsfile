pipeline {
    agent any

    environment {
        // Store these securely in Jenkins credentials
        OPENSHIFT_SERVER = credentials('my-openshift-server') 
        OPENSHIFT_TOKEN  = credentials('my-openshift-token')
        REGISTRY_URL = "docker.io/shashank325/test"
        DOCKER_USERNAME = credentials('docker-username')
        DOCKER_PASSWORD = credentials('docker-password') 
    }

    stages {
        // ... (your Checkout and Build & Push stages)

        stage('Deploy to OpenShift') {
            steps {
                sh "oc login ${OPENSHIFT_SERVER} --token=${OPENSHIFT_TOKEN}"
                sh "oc project shashanktest" 
                sh "oc apply -f openshift/deployment.yaml" 
            }
        }
    }
} 
