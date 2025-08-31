node {
    def appName = "flask-app"
    def imageTag = "latest"

    stage('Checkout') {
        git branch: 'master', url: 'https://github.com/Kasimalbatros/checkout-to-deploy-python-pipeline.git'
    }

    stage('Build Image') {
        echo "Building Docker image..."
        sh "docker build -t ${appName}:${imageTag} ."
    }

    stage('Test Image') {
        echo "Testing Docker image..."
        sh '''
            # Remove old test container if it exists
            docker rm -f flask-app-test || true

            # Run new test container
            docker run -d --name flask-app-test -p 8000:8000 flask-app:latest

            # Wait a few seconds for app to start
            sleep 5

            # Test endpoint
            curl -s http://localhost:8000 | grep 'Hello'

            # Clean up test container
            docker rm -f flask-app-test
        '''
    }

    stage('Deploy') {
        echo "Deploying container on port 8000..."
        sh "docker rm -f ${appName} || true"
        sh "docker run -d --name ${appName} -p 8000:8000 ${appName}:${imageTag}"
    }
}


