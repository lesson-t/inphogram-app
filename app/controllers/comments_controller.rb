class CommentsController < ApplicationController
    def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments
    end

    # def new
    #     @post = Post.find(params[:post_id])
    #     @comments = @post.comments
    #     render json: @comments
    # end

    def create
        post = Post.find(params[:post_id])
        @comment = post.comments.build(comment_params)
        @comment.save!
        # redirect_to post_comments_path(@comment), notice: 'Saved successfully'
        render json: @comment
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    
    end
end