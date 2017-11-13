class CommentsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_micropost, only: :create

  def create
    @comment = Comment.new(comment_params)
    @comment.micropost = @micropost
    @comment.user = current_user

    if @comment.save
      flash[:success] = t "comment_created"
    else
      flash[:warning] = t "comment_cannot_be_created"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "comment_deleted"
    else
      flash[:warning] = t "comment_cannot_be_deletes"
    end
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url unless @comment
  end

  def load_micropost
    @micropost = Micropost.find_by id: params[:micropost_id]
    return if @micropost
    flash[:warning] = t "cannot_find_micropost"
    redirect_to root_path
  end
end
