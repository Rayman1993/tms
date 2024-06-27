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
                    sh "cd .."
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
                    sh 'docker stop $(docker ps -aq) || true'
                    sh 'docker rm $(docker ps -aq) || true'
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        docker.image('rayman1993/calculator').run("-p 9090:5000")
                    }
                }
            }
        }
    }
 post {
     success {
        withCredentials([string(credentialsId: 'bot_tg', variable: 'TOKEN'), string(credentialsId: 'chat_id', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*${env.JOB_NAME}* : POC *Branch*: ${env.GIT_BRANCH} *Build* : OK *Published* = YES'
        """)
        }
     }

     aborted {
        withCredentials([string(credentialsId: 'bot_tg', variable: 'TOKEN'), string(credentialsId: 'chat_id', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*${env.JOB_NAME}* : POC *Branch*: ${env.GIT_BRANCH} *Build* : `Aborted` *Published* = `Aborted`'
        """)
        }

     }
     failure {
        withCredentials([string(credentialsId: 'bot_tg', variable: 'TOKEN'), string(credentialsId: 'chat_id', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*${env.JOB_NAME}* : POC  *Branch*: ${env.GIT_BRANCH} *Build* : `not OK` *Published* = `no`'
        """)
        }
     }

 }
}
