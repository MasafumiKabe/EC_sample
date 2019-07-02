class UsersController < ApplicationController
  before_action :require_user_logged_in

  def show
    @user = User.find(params[:id])
    @items = @user.items.uniq
    @count_want = @user.want_items.count
  end
end
