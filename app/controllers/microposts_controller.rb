class MicropostsController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = "microposts created"
      redirect_to root_url
    else
      flash[:warning] = "You missed sth"
      redirect_to root_url
    end
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
end
