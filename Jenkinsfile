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
                sh "docker build -f Dockerfile_python -t 'python_test' ."
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
            when {
                branch 'release/*'
            }
            steps {
                // sh "chmod +x script1.sh"
                withCredentials([usernamePassword(credentialsId: 'b2f8966b-16e3-4c2e-9a48-eb0c3bd94f34',
                 passwordVariable: 'GIT_PASS', usernameVariable: 'GIT_USER')]) {
                    sh "sh script1.sh"
                }
            }
        }
    }
}