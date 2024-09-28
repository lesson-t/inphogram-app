# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#
class Comment < ApplicationRecord
    belongs_to :post
    validates :content, presence: true

    after_create :accountname_extraction_and_send_mail

    private
    def accountname_extraction_and_send_mail
        accountnames = content.scan(/@(\w+)(?=\s|$|[^\w])/)
        accountnames.each do |accountname|
            user = User.find_by(name: accountname)
            if user
                AddCommentMailer.notify_account(user, self).deliver_later
            end
        end
    end
end
