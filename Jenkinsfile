pipeline {
    agent any

    environment {
        NODE_HOME = tool name: 'NodeJS', type: 'NodeJS'
        PATH = "${NODE_HOME}/bin:${env.PATH}"
        FIREBASE_SERVICE_ACCOUNT = credentials('firebase-service-account')  // ชื่อที่ตั้งใน Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/gtwndtl/jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'npm install'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'npm run build'
                }
            }
        }

        stage('Deploy to Firebase') {
            steps {
                script {
                    // ใช้ Firebase Service Account Key เพื่อ login โดยไม่ต้องใช้ firebase login
                    withCredentials([file(credentialsId: 'firebase-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh 'firebase deploy --only hosting'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Build and deploy successful!'
        }
        failure {
            echo 'Build or deploy failed.'
        }
    }
}
