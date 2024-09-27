class AddCommentMailer < ApplicationMailer
    def new_comment(user)
        @user = user
        mail to: @user.email, subject: '【お知らせ】コメントされました'
    end
end