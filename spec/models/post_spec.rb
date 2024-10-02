require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'コンテンツと画像ファイルが入力されていれば、記事を保存できる' do
    user = User.create!({
      email: 'tester@example.com',
      password: 'password',
      name: 'tester'
    })
    post = user.posts.build({
      content: Faker::Lorem.characters(number: 10),
      photos: [fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test1.png'), 'image/png')]
    })

    expect(post.photos).to be_attached
    expect(post).to be_valid
  end
end
