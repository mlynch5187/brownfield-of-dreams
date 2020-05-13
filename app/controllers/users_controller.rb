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
      user_email = user.email
      email_info = { user: user.first_name, user_email: user.email, user_id: user.id }
      RegistrationMailer.inform(email_info, user_email).deliver_now
      flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:notice] = 'This account has not yet been activated. Please check your email'
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
