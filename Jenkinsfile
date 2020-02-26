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
                sh "sh test_script.sh"
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
            when {
                branch 'master'
            }
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'aws-pair', keyFileVariable: 'KEYFILE', passphraseVariable: '', usernameVariable: 'AWSUSER')]) {
                sh "ssh -o StrictHostKeyChecking=no -i ${KEYFILE} ${AWSUSER}@ec2-35-156-29-121.eu-central-1.compute.amazonaws.com < login_script.sh"
                }
            }
        }
    }
    post {
        unsuccessful {
            sh "sh mail.sh"
        }
    }
}
