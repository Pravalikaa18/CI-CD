pipeline {
    agent any
    environment {
        IMAGE_NAME = "pravalikaa18/java"
        BRANCH_NAME = "${env.GIT_BRANCH}".replaceAll('origin/', '')
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            when {
                branch 'develop'
            }
            steps {
                sh 'docker build -t $IMAGE_NAME:$BRANCH_NAME .'
            }
        }

        stage('Push to Registry') {
            when {
                branch 'develop'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $IMAGE_NAME:$BRANCH_NAME'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                branch 'develop'
            }
            steps {
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }
}
