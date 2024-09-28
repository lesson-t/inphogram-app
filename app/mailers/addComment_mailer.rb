class AddCommentMailer < ApplicationMailer
    def notify_account(user, comment)
        @user = user
        @comment = comment
        mail to: @user.email, subject: '【お知らせ】あなた宛てのコメントがありました'
    end
end