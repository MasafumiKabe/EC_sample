class UsersController < ApplicationController
  before_action :require_user_logged_in

  def show
    @user = User.find(params[:id])
    @items = @user.want_items
    @count_want = @user.want_items.count
  end

  def cart
    @user = User.find(params[:id])
    @items = @user.cart_items
    @count_cart = @user.cart_items.count
  end
end
