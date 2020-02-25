pipeline {
    agent any
    tools {
        maven 'Maven-Tool'
    }
    stages {
        stage('Production'){
            steps {
                sh "mvn verify -s /settings.xml"
            }
        }
        stage('Testing'){
            steps {
                sh "docker build -f Dockerfile -t toxic_test ."
                sh "docker run -d -p 9000:8080 --name toxic_test_cont toxic_test"
                sh "docker build -f Dockerfile_python -t python_test ."
                sh "docker run -d --name python_test python_test"
            }
        }
        stage('Deploy'){
            when {
                branch 'master'
            }
            steps {
                sh "mvn deploy -s /settings.xml"
                sh "docker tag toxic_test 760836743460.dkr.ecr.eu-central-1.amazonaws.com/toxictypo"
                sh "aws ecr get-login-password | docker login --username AWS --password-stdin 760836743460.dkr.ecr.eu-central-1.amazonaws.com"
                sh "docker push 760836743460.dkr.ecr.eu-central-1.amazonaws.com/toxictypo"
            }
        }
        stage('Release'){
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'aws-pair', keyFileVariable: 'KEYFILE', passphraseVariable: '', usernameVariable: 'AWSUSER')]) {
                sh "ssh -i "${KEYFILE}" ${AWSUSER}@ec2-54-93-232-132.eu-central-1.compute.amazonaws.com docker run -p 80:8080 760836743460.dkr.ecr.eu-central-1.amazonaws.com/toxictypo"
                }
            }
        }
    }
}
