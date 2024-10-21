pipeline {
    agent any

    environment {
        // Store these securely in Jenkins credentials
        OPENSHIFT_SERVER = credentials('my-openshift-server') 
        OPENSHIFT_TOKEN  = credentials('my-openshift-token')
        REGISTRY_URL = "your-docker-registry.com"
        DOCKER_USERNAME = credentials('docker-username')
        DOCKER_PASSWORD = credentials('docker-password') 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-username/my-web-app.git'
            }
        }
        stage('Build & Push Docker Image') {
            steps {
                // Build
                sh "docker build -t ${REGISTRY_URL}/my-web-app:$BUILD_NUMBER ."
                
                // Docker login 
                sh "echo \"${DOCKER_PASSWORD}\" | docker login ${REGISTRY_URL} -u ${DOCKER_USERNAME} --password-stdin"

                // Push
                sh "docker push ${REGISTRY_URL}/my-web-app:$BUILD_NUMBER"
            }
        }
        stage('Deploy to OpenShift') {
            steps {
                sh "oc login ${OPENSHIFT_SERVER} --token=${OPENSHIFT_TOKEN}"
                sh "oc project my-project" // Replace with your project name
                sh "
