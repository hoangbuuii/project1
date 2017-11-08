class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.order_by_created_at_desc
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def index
    @users = User.select_id_name_email.order_created_at.paginate page: 
      params[:page], per_page: Settings.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user 
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "user_deleted"
    else
      flash[:danger] = "user_cannot_be_deleted"
    end
    redirect_to users_url
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = "Cannot find user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user?(@user)
   end

  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end
end
