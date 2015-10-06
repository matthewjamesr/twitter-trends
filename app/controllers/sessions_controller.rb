class SessionsController < ApplicationController

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    $current_user = @user
    redirect_to root_path
  end

  def destroy
    @user = nil
    $current_user = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
