pipeline {
    agent { label 'work-ruby' }
    triggers {
        githubPush()
    }
    environment {
        DEPLOY_ENV = "staging"
        TELEGRAM_TOKEN = credentials('telegram-bot-token')
        TELEGRAM_CHAT_ID = credentials('telegram-chat-id')
        MAIL_RECIPIENTS = "toannguyenvan145@gmail.com"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[
                              url: 'https://github.com/19521791/bookshop',
                              credentialsId: 'vps-ssh-key'
                          ]]
                ])
            }
        }
        stage('Install dependencies') {
            steps {
                sh 'bundle install --deployment --without development test'
            }
        }
        stage('Deploy') {
            steps {
               sshagent(['vps-ssh-key']) {
                    sh """
                        bundle install
                        bundle exec cap ${DEPLOY_ENV} deploy
                    """
               }
            }
        }
    }
    post {
        success {
          mail to: "${MAIL_RECIPIENTS}",
              subject: "✅ Deploy success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
              body: "The deployment completed successfully.\nJob: ${env.BUILD_URL}"
          sh """
              curl -s -X POST https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage \
              -d chat_id=${TELEGRAM_CHAT_ID} \
              -d text='✅ Deploy success for ${env.JOB_NAME} #${env.BUILD_NUMBER}'
          """
        }
        failure {
          mail to: "${MAIL_RECIPIENTS}",
              subject: "❌ Deploy failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
              body: "The deployment failed.\nJob: ${env.BUILD_URL}"
          sh """
              curl -s -X POST https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage \
              -d chat_id=${TELEGRAM_CHAT_ID} \
              -d text='❌ Deploy failed for ${env.JOB_NAME} #${env.BUILD_NUMBER}'
          """
        }
    }
}
