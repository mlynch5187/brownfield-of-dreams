class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    token = request.env['omniauth.auth']['credentials']['token']
    #current_user.link_github(token)

    current_user.update(token: token)
    if current_user.save
      flash[:success] = "Successfully linked to Github"
      redirect_to '/dashboard'
    else
      flash[:error] = "Looks like you couldn't connect to Github"
      redirect_to '/dashboard'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :token)
  end
end
