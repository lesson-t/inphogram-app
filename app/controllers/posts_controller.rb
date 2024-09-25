class PostsController < ApplicationController
    before_action :set_post, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
    end

    def show
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to post_path(@post), notice: 'Saved successfully'
        else
            flash.now[:error] = 'Save failed'
            render :new
        end
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