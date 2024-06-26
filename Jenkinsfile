pipeline {
    agent {
        label 'ubuntu'
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/Rayman1993/calculator.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                script {
                    sh "docker build -t rayman1993/calculator ."
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        docker.image('rayman1993/calculator').push('latest')
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        docker.image('rayman1993/calculator').run("-p 9090:5000")
                    }
                }
            }
        }
    }
    post {
        success {
            script {
                emailext (
                    subject: "Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Succeeded",
                    body: """<p>Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Succeeded: Check console output at ${env.BUILD_URL}</p>""",
                    to: 'ray.mail.by.ray.mail.by@gmail.com'
                )
            }
        }
        failure {
            script {
                emailext (
                    subject: "Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed",
                    body: """<p>Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed: Check console output at ${env.BUILD_URL}</p>""",
                    to: 'ray.mail.by.ray.mail.by@gmail.com'
                )
            }
        }
    }
}