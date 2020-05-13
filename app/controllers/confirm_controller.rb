class ConfirmController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user.update(status: 'active')
  end
end
