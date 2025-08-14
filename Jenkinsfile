def buildDuration = ""
def timestamp = ""
def emoji = ""
def color = ""

pipeline {
    agent { label 'work-ruby' }
    triggers {
        githubPush()
    }
    environment {
        DEPLOY_ENV = "staging"
        TELEGRAM_TOKEN = credentials('telegram-bot-token')
        TELEGRAM_CHAT_ID = credentials('telegram-chat-id')
        MAIL_RECIPIENTS = credentials('mail-recipients')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[
                              url: 'https://github.com/19521791/bookshop',
                              credentialsId: 'github-ssh-key'
                          ]]
                ])
            }
        }
        stage('Install dependencies') {
            steps {
                sh """
                    export BUNDLE_PATH=vendor/bundle
                    export PATH=$PWD/vendor/bundle/ruby/3.1.0/bin:$PATH
                    bundle install --path vendor/bundle
                """
            }
        }
        stage('Deploy') {
            steps {
               sshagent(['vps-ssh-key']) {
                    sh """
                        bundle exec cap ${DEPLOY_ENV} deploy
                    """
               }
            }
        }
    }

    post {
        always {
            script {
                buildDuration = currentBuild.durationString.replace(' and counting', '')
                timestamp = new Date().format("yyyy-MM-dd HH:mm:ss z")
                
                emoji = currentBuild.currentResult == 'SUCCESS' ? '✅' : '❌'
                color = currentBuild.currentResult == 'SUCCESS' ? '#36a64f' : '#ff0000'
            }
            cleanWs( deleteDirs: true )
        }
        success {
            mail to: "${MAIL_RECIPIENTS}",
                subject: "${emoji} [SUCCESS] ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    <html>
                    <body>
                        <h2 style="color: ${color};">Deployment Successful</h2>
                        <p><strong>Project:</strong> ${env.JOB_NAME}</p>
                        <p><strong>Build #:</strong> ${env.BUILD_NUMBER}</p>
                        <p><strong>Duration:</strong> ${buildDuration}</p>
                        <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">View Details</a></p>
                        <p><strong>Timestamp:</strong> ${timestamp}</p>
                    </body>
                    </html>
                """,
                mimeType: "text/html"

            sh """
                curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
                -d chat_id="${TELEGRAM_CHAT_ID}" \
                -d text="*${emoji} DEPLOYMENT SUCCESS* \
                \n\n*Project*: ${env.JOB_NAME} \
                \n*Build*: \\#${env.BUILD_NUMBER} \
                \n*Duration*: ${buildDuration} \
                \n*Timestamp*: ${timestamp}" \
                -d parse_mode="Markdown" \
                -d reply_markup='{"inline_keyboard":[[{"text":"View Build","url":"${env.BUILD_URL}"}]]}'
            """
        }
        failure {
            mail to: "${MAIL_RECIPIENTS}",
                subject: "${emoji} [FAILED] ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    <html>
                    <body>
                        <h2 style="color: ${color};">Deployment Failed</h2>
                        <p><strong>Project:</strong> ${env.JOB_NAME}</p>
                        <p><strong>Build #:</strong> ${env.BUILD_NUMBER}</p>
                        <p><strong>Error:</strong> ${currentBuild.currentResult}</p>
                        <p><strong>Duration:</strong> ${buildDuration}</p>
                        <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">Debug Logs</a></p>
                        <p><strong>Timestamp:</strong> ${timestamp}</p>
                    </body>
                    </html>
                """,
                mimeType: "text/html"

            sh """
                curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
                -d chat_id="${TELEGRAM_CHAT_ID}" \
                -d text="*${emoji} DEPLOYMENT FAILED* \
                \n\n*Project*: ${env.JOB_NAME} \
                \n*Build*: \\#${env.BUILD_NUMBER} \
                \n*Duration*: ${buildDuration} \
                \n*Timestamp*: ${timestamp}" \
                -d parse_mode="Markdown" \
                -d reply_markup='{"inline_keyboard":[[{"text":"View Build","url":"${env.BUILD_URL}"}]]}'
            """
        }
    }
}
