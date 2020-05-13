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
    @user_1 = User.create(user_params)
    if @user_1.save
      session[:user_id] = @user_1.id
      setup_email
      RegistrationMailer.inform(@email_info, @user_email).deliver_now
      flash_success_create
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

  def setup_email
    @user_email = @user_1.email
    @email_info = { user: @user_1.first_name,
                   user_email: @user_1.email,
                   user_id: @user_1.id }
  end

  def flash_success_create
    flash[:success] = "Logged in as #{@user_1.first_name} #{@user_1.last_name}"
    flash[:notice] = 'This account has not yet been activated. Please check your email'
  end
end
