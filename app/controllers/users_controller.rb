class UsersController < ApplicationController
  def show
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Authorization'] = "token #{current_user.token}"
    end
    response = conn.get("/user/repos")
    @repos = JSON.parse(response.body, symbolize_names: true)

    follower_list = conn.get("/user/followers")
    @followers = JSON.parse(follower_list.body, symbolize_names: true)

    following_list = conn.get("user/following")
    @following = JSON.parse(following_list.body, symbolize_names: true)        
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
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
