FROM jenkins/jenkins:latest

# เปลี่ยนไปใช้งาน root user ในการติดตั้ง
USER root

# ติดตั้ง Docker
RUN apt-get update && apt-get install -y docker.io

# ให้ Jenkins user สามารถใช้งาน Docker ได้
RUN usermod -aG docker jenkins

# ติดตั้ง Node.js (ในที่นี้ใช้ version 16.x)
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# ติดตั้ง Firebase CLI
RUN npm install -g firebase-tools

# เปลี่ยนกลับไปใช้งาน Jenkins user
USER jenkins
