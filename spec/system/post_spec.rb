require 'rails_helper'

RSpec.describe 'Post', type: :system do
    let!(:user) { create(:user) }
    let!(:posts) { create_list(:post, 3, user: user) }

    it '記事一覧が表示される' do
        visit root_path

        posts.each do |post|
            expect(page).to have_css('.post_content', text: post.content)
            expect(page).to have_selector('img')
            post.photos.each do |photo|
                image_url = Rails.application.routes.url_helpers.rails_blob_path(photo, only_path: true)
                expect(page).to have_selector("img[src*='#{image_url}']")
            end
        end
    end

    it '記事の詳細が表示される' do
        visit root_path

        post = posts.first
        click_on posts.first.content
        expect(page).to have_css('.post_content_in', text: post.content)
        expect(page).to have_selector('img')
        post.photos.each do |photo|
            image_url = Rails.application.routes.url_helpers.rails_blob_path(photo, only_path: true)
            expect(page).to have_selector("img[src*='#{image_url}']")
        end
    end
end