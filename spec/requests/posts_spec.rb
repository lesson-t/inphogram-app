require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user) }

  describe "GET /posts" do
    it "200ステータスが返ってくる" do
      get posts_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /posts" do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
    
      it "記事が保存される" do
        post_instance = build(:post, user: user)
        post posts_path, params: { 
          post: {
            content: post_instance.content,
            photos: [fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test1.png'), 'image/png')]
          } 
        }

        expect(response).to have_http_status(302)
        expect(Post.last.content).to eq(post_instance.content)
        expect(Post.last.photos).to be_attached
        expect(Post.last.photos[0].filename.to_s).to eq('test1.png')
      end
    end

    context 'ログインしていない場合' do
      it "ログイン画面に遷移する" do
        post_instance = build(:post, user: user)
        post posts_path, params: { 
          post: {
            content: post_instance.content,
            photos: [fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test1.png'), 'image/png')]
          } 
        }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
