class StaticPagesController < ApplicationController
  def home
    if params[:search]
      @microposts = Micropost.search(params[:search]).order_by_created_at_desc
        .paginate page: params[:page], per_page: Settings.per_page
    else
    	@microposts = Micropost.order_by_created_at_desc.paginate page: 
        params[:page], per_page: Settings.per_page
      return unless logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.order_by_created_at_desc
        .paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def help; end

  def about; end
end
