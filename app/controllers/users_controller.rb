class UsersController < ApplicationController
    def show
    end

    def followings
        @user = User.find(params[:id])
        followings = @user.followings
        render 'followings'
    end

    def followers
        @user = User.find(params[:id])
        followers = @user.followers
        render 'followers'
    end
end