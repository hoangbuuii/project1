class StaticPagesController < ApplicationController
  def home
  	@micropost = current_user.microposts.build if logged_in?
  	@microposts = Micropost.order_by_created_at_desc.paginate page: 
      params[:page], per_page: Settings.per_page
  end

  def help
  end

  def about
  end
end
