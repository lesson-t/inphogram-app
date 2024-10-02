require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'コンテンツが入力されていれば、記事を保存できる' do
    user = User.create!({
      email: 'tester@example.com',
      password: 'password',
      name: 'tester'
    })
    post = user.posts.build({
      content: Faker::Lorem.characters(number: 1)
    })

    expect(post).to be_valid
  end
end
