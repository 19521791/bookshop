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
                sh 'bundle install --deployment --path vendor/bundle --without development test'
            }
        }
        stage('Deploy') {
            steps {
               sshagent(['vps-ssh-key']) {
                    sh """
                        export PATH=$PWD/vendor/bundle/ruby/3.1.0/bin:$PATH
                        bundle install
                        bundle exec cap ${DEPLOY_ENV} deploy
                    """
               }
            }
        }
    }
    post {
        always {
            script {
                buildDuration = currentBuild.durationString?.replace(' and counting', '') ?: 'N/A'
                timestamp = new Date().format("yyyy-MM-dd HH:mm:ss z")

                isSuccess = (currentBuild.currentResult == 'SUCCESS')
                emoji = isSuccess ? '✅' : '❌'
                color = isSuccess ? '#36a64f' : '#ff0000'

                escapeMarkdown = { text -> text.replaceAll(/([_*\[\]()~`>#+\-=|{}.!])/, '\\\\$1') }

                projectName = env.JOB_NAME
                buildNumber = env.BUILD_NUMBER
                buildUrl = env.BUILD_URL
                resultText = isSuccess ? "DEPLOYMENT SUCCESS" : "DEPLOYMENT FAILED"

                emailBody = """
                    <html>
                        <body style="font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px;">
                            <div style="max-width: 600px; background: white; padding: 20px; border-radius: 8px;">
                            <h2 style="color: ${color};">${emoji} ${resultText}</h2>
                            <p><strong>Project:</strong> ${projectName}</p>
                            <p><strong>Build #:</strong> ${buildNumber}</p>
                            <p><strong>Status:</strong> ${currentBuild.currentResult}</p>
                            <p><strong>Duration:</strong> ${buildDuration}</p>
                            <p><strong>Timestamp:</strong> ${timestamp}</p>
                            <p><a href="${buildUrl}" style="color: ${color}; font-weight: bold;">View Build Details</a></p>
                            </div>
                        </body>
                    </html>
                """

                telegramMessage = """
                    *${emoji} ${escapeMarkdown(resultText)}*
                            
                    *Project*: ${escapeMarkdown(projectName)}
                    *Build*: #${buildNumber}
                    *Status*: ${escapeMarkdown(currentBuild.currentResult)}
                    *Duration*: ${escapeMarkdown(buildDuration)}
                    *Timestamp*: ${escapeMarkdown(timestamp)}
                """
            }
        }

        success {
            mail to: "${MAIL_RECIPIENTS}",
                subject: "${emoji} [SUCCESS] ${projectName} #${buildNumber}",
                body: emailBody,
                mimeType: "text/html"

            sh """
                curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
                -d chat_id="${TELEGRAM_CHAT_ID}" \
                -d text="${telegramMessage}" \
                -d parse_mode="MarkdownV2" \
                -d reply_markup='{"inline_keyboard":[[{"text":"View Build","url":"${buildUrl}"}]]}'
            """
        }

        failure {
            mail to: "${MAIL_RECIPIENTS}",
                subject: "${emoji} [FAILED] ${projectName} #${buildNumber}",
                body: emailBody,
                mimeType: "text/html"

            sh """
                curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
                -d chat_id="${TELEGRAM_CHAT_ID}" \
                -d text="${telegramMessage}" \
                -d parse_mode="MarkdownV2" \
                -d reply_markup='{"inline_keyboard":[[{"text":"Debug Logs","url":"${buildUrl}"}]]}'
            """
        }
    }
}
