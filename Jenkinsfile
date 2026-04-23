pipeline {
    agent any

    environment {
        AWS_REGION     = 'ap-south-1'
        AWS_ACCOUNT_ID = '826229823583'
        ECR_REPO_NAME  = 'repo_docker_image'
        ECR_REPO_URI   = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}"
        IMAGE_TAG      = "latest"
        IMAGE_URI      = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Pulls from your specific repo
                git url: 'https://github.com/Git-ANS/C-project1.git', branch: 'main'
            }
        }

        stage('Build Java Application') {
            steps {
                // Compiles the code and creates the target folder
                sh 'mvn clean -B -Denforcer.skip=true package'
            }
        }

       stage('Login & Push to ECR') {
    steps {
        // This 'aws' binding is specific to the 'AWS Credentials' type
        withCredentials([aws(credentialsId: 'aws-user-creds', 
                             accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
            script {
                sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URI}"
                sh "docker build -t ${IMAGE_URI} -f ECR-file ."
                sh "docker push ${IMAGE_URI}"
            }
        }
    }
}
    }
    
    post {
        success {
            echo "Successfully pushed ${IMAGE_URI} to ECR!"
        }
        failure {
            echo "Pipeline failed. Check Jenkins credentials 'aws-user-creds' or Docker permissions."
        }
    }
}
