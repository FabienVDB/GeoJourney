class UsersController < ApplicationController
  def show
    @user = current_user
    @favorites = current_user.favorites
  end
end
