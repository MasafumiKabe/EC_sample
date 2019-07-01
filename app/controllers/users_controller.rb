class UsersController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @user = User.find(params[:id])
  end
end
