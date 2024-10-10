class AccountsController < ApplicationController
    def show
        @user = User.find(params[:id])
        if @user == current_user
            redirect_to profile_path
        end
        @recent_posts = @user.posts.order(created_at: :desc).limit(6)
    end

    def followings
        @user = User.find(params[:id])
        @followings = @user.followings
        render 'followings'
    end

    def followers
        @user = User.find(params[:id])
        @followers = @user.followers
        render 'followers'
    end
end