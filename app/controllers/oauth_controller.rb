# class OauthController < ApplicationController
#   def create
#     client_id     = ENV['GITHUB_CLIENT_ID']
#     client_secret = ENV['GITHUB_CLIENT_SECRET']
#     code          = params[:code]
#     response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
#
#     pairs = response.body.split("&")
#     response_hash = {}
#     pairs.each do |pair|
#         key, value = pair.split("=")
#         response_hash[key] = value
#     end
#     token = response_hash["access_token"]
#     require "pry"; binding.pry
#   end
# end
