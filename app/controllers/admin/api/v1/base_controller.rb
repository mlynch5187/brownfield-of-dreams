# class Admin::Api::V1::BaseController < ActionController::API
#   # before_action :require_admin!
#
#   def require_admin!
#     render file: "/public/404" unless current_user.admin?
#   end
#
#   def current_user
#     @current_user ||= if session[:user_id]
#                         User.find(session[:user_id])
#                       else
#                         User.new
#                       end
#   end
# end
