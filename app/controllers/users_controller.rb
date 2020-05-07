class UsersController < ApplicationController
  def show
    if current_user.token != nil
      conn = Faraday.new('https://api.github.com') do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers['Authorization'] = "token #{current_user.token}"
      end
      response = conn.get('/user/repos')
      json = JSON.parse(response.body, symbolize_names: true)

      @repos = json.map do |github_repos|
        Repo.new(github_repos)
      end

      follower_list = conn.get('/user/followers')
      following_list = conn.get('user/following')

      @followers = json.map do |github_repos|
        Follow.new(follower_list)
      end

      @following = json.map do |github_repos|
        Follow.new(following_list)
      end
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
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
