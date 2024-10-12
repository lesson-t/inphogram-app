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
require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user) }

  context 'コンテンツと画像ファイルが入力されている場合' do
    let!(:post) { build(:post, user: user) }

    it '記事を保存できる' do
      expect(post.photos).to be_attached
      expect(post).to be_valid
    end
  end

  context 'コンテンツが0文字の場合' do
    let!(:post) { build(:post, content: '', user: user) }

    before do
      post.save
    end
    
    it '記事を保存できない' do
      post.validate
      expect(post.errors.messages[:content][0]).to eq('を入力してください')
      expect(post.errors.messages[:content][1]).to eq('は1文字以上で入力してください')
    end
  end
end
