require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  describe 'GET /api/likes' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200 Status' do
        get api_like_path(post_id: post.id)
        expect(response).to have_http_status(200)  
      end
    end

    context 'ログインしていない場合' do
      it '302 Status' do
        get api_like_path(post_id: post.id)
        expect(response).to have_http_status(302)
      end
    end
  end

  # describe 'POST /api/likes' do
  #   context 'ログインしている場合' do
  #     before do
  #       sign_in user
  #     end

  #     it '「いいね」されて、ステータスokを返す' do
  #       post api_like_path(post_id: post.id, user_id: user.id)

  #       expect(response).to have_http_status(200) 
  #       body = JSON.parse(response.body)
  #       expect(body['status']).to eq('ok')
  #     end
  #   end

  #   context 'ログインしていない場合' do
  #     it '302 Status' do
  #       post api_like_path(post_id: post.id)
  #       expect(response).to have_http_status(302)
  #     end
  #   end
  # end
end
