class Apps::TimelinesController < ApplicationController
    def show
        @posts = Post.joins(:user)
                     .left_joins(:likes)
                     .where(users: { id: current_user.followings.pluck(:id)})
                     .where('posts.created_at >= ?', 24.hours.ago)
                     .group('posts.id')
                     .order('COUNT(likes.id) DESC')
                     .limit(5)

        @posts ||= []
    end
end