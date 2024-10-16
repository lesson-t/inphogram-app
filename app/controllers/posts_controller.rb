class PostsController < ApplicationController
    before_action :set_post, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @posts = Post.order(created_at: :desc).limit(30)
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
        @post = current_user.posts.find(params[:id])
    end

    def update
        @post = current_user.posts.find(params[:id])
        if @post.update(post_params)
            redirect_to post_path(@post), notice: 'Updated successfully'
        else
            flash.now[:error] = 'Update failed'
            render :edit
        end
    end

    def destroy
        post = current_user.posts.find(params[:id])
        post.destroy!
        redirect_to root_path, notice: 'Deleted successfully'
    end

    private
    def post_params
        params.require(:post).permit(:content, photos: [])
    end

    def set_post
        @post = Post.find(params[:id])
    end
end