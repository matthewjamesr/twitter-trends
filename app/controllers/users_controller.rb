class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    $current_user = @user.id
    redirect_to root_path
  end

  def destroy
    @user = nil
    $current_user = nil
    redirect_to root_path
  end

  def show
    if $current_user
      if $current_user.id = params[:id]
        @user = User.find(params[:id])
        searches = Search.where(user_id: @user.id).find_each

        @query_hash = {}
        searches.each do |s|
          query = s.query
          if !@query_hash.has_key? query
            @query_hash[query] = 0
          end
          @query_hash[query] = @query_hash[query] + 1
        end

      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :first_visit)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
