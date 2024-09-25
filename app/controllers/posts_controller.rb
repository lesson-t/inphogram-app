class PostsController < ApplicationController
    before_action :set_article, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
    end

    def show
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
    def post_params
        params.require(:post).permit(:content)
    end

    def set_post
        @post = Post.find(params[:id])
    end
end