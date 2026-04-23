pipeline {
    agent any
    environment {
        AWS_REGION = 'ap-south-1'
        ECR_REPO_URI = '826229823583.dkr.ecr.ap-south-1.amazonaws.com/repo_docker_image'
        IMAGE_TAG = 'latest'
        AWS_ACCOUNT_ID = '826229823583'
        IMAGE_URI = "${ECR_REPO_URI}:${IMAGE_TAG}"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Git-ANS/C-project1.git', branch: 'main'
            }
        }

        stage('Build Java Application') {
            steps {
                sh 'mvn clean -B -Denforcer.skip=true package'
            }
        }

        stage('Login & Push to ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region $AWS_REGION \
                    | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

                    docker build -t ${IMAGE_URI} .

                    docker push ${IMAGE_URI}
                '''
            }
        }
    }

    post {
        success { echo "Docker image pushed to ECR successfully." }
        failure { echo "Pipeline failed." }
    }
}
