class SessionsController < ApplicationController

  def index
    if current_user
      @user = User.find(current_user)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    $current_user = @user
    castle.track(
      name: '$login.succeeded',
      user_id: @user.id)
    redirect_to root_path
  end

  def destroy
    user = @user.id
    @user = nil
    $current_user = nil
    castle.track(
      name: '$logout.succeeded',
      user_id: user)
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
