class UsersController < ApplicationController
  def add_name
    @user = current_user
    @user.name = params[:name]
    @user.save

    redirect_to root_path
  end
end
