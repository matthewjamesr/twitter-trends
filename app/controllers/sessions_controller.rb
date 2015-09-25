class SessionsController < ApplicationController

  def create
    @user = User.where(uid: auth_hash[:uid], provider: auth_hash[:provider]).first_or_create

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
