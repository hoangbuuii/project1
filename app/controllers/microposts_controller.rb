class MicropostsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :load_micropost, except: :create
  before_action :logged_in_user, only: %i(create destroy)

  def show
    @comment  = @micropost.comments.build(params[:comment])
    @comments = @micropost.comments.order_by_created_at_desc
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = "microposts created"
    else
      flash[:warning] = "You missed sth"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    if @micropost.destroy
      flash[:success] = "micropost_deleted"
    else
      flash[:warning] = "cannot_delete"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit :title, :content
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end

  def load_micropost
    @micropost = Micropost.find_by id: params[:id]
    return if @micropost
    flash[:warning] = "Cannot find micropost"
    redirect_to root_path
  end
end
