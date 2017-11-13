class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :load_micropost, except: %i(create index)

  def index
    if params[:search]
      @microposts = Micropost.search(params[:search]).order_by_created_at_desc
        .paginate page: params[:page], per_page: Settings.per_page
    else
      @microposts = Micropost.all.order_by_created_at_desc
        .paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def show
    @comment = @micropost.comments.build(params[:comment])
    @comments = @micropost.comments.order_by_created_at_desc
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t "micropost_created"
    else
      flash[:warning] = t "micropost_cannot_be_created"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost_deleted"
    else
      flash[:warning] = t "micropost_cannot_be_deleted"
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
    flash[:warning] = t "cannot_find_micropost"
    redirect_to root_path
  end
end
