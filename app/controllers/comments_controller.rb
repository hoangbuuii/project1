class CommentsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_micropost, only: :create

  def create
    @comment = Comment.new(comment_params)
    @comment.micropost = @micropost
    @comment.user = current_user

    if @comment.save
      flash[:success] = "comment created"
    else
      flash[:warning] = "You missed sth"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    if @comment.destroy
      flash[:success] = "comment deleted"
    else
      flash[:warning] = "cannot delete"
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
    flash[:warning] = "Cannot find micropost"
    redirect_to root_path
  end
end
