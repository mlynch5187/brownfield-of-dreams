class UsersController < ApplicationController
  def show
    if !current_user.token.nil?
      search_results = SearchResult.new
      @repos = search_results.repos(current_user.token)
      @followers = search_results.followers(current_user.token)
      @following = search_results.following(current_user.token)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:email, :first_name, :last_name, :password, :token)
  end
end
