# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
    has_many_attached :photos

    validates :content, presence: true
    validates :content, length: { minimum: 1}

    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    belongs_to :user

    def likes_count
        likes.count
    end

    def display_created_at
        I18n.l(self.created_at, format: :default)
    end
end
