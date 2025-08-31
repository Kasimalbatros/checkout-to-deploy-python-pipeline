node {
    def appName = "flask-app"
    def imageTag = "latest"

    stage('Checkout') {
        git branch: 'main', url: 'https://github.com/your-username/python-docker-jenkins.git'
    }

    stage('Build Image') {
        echo "Building Docker image..."
        sh "docker build -t ${appName}:${imageTag} ."
    }

    stage('Test Image') {
        echo "Testing Docker image..."
        sh "docker run -d --name ${appName}-test -p 8000:8000 ${appName}:${imageTag}"
        
        sleep 5
        
        sh "curl -s http://localhost:8000 | grep 'Hello'"
        
        sh "docker rm -f ${appName}-test"
    }

    stage('Deploy') {
        echo "Deploying container on port 8000..."
        sh "docker rm -f ${appName} || true"
        sh "docker run -d --name ${appName} -p 8000:8000 ${appName}:${imageTag}"
    }
}

