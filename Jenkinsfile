pipeline {
    agent any

    environment {
        NODE_HOME = tool name: 'NodeJS', type: 'NodeJS'  // ชื่อที่ตั้งใน Global Tool Configuration
        PATH = "${NODE_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                // ดึงโค้ดจาก GitHub
                git 'https://github.com/gtwndtl/jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // ติดตั้ง dependencies ด้วย npm (ใน directory ที่มี package.json)
                    sh 'npm install'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // ทำการ build frontend (ในกรณีนี้ React app)
                    sh 'npm run build'
                }
            }
        }

        stage('Deploy to Firebase') {
            steps {
                script {
                    // ใช้ Firebase Service Account สำหรับการ deploy
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
