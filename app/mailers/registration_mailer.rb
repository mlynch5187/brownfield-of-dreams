class RegistrationMailer < ApplicationMailer
  def inform(email_info, user_email)
    @user = email_info[:user]
    @email = email_info[:user_email]
    @id = email_info[:user_id]
    mail(to: user_email, subject: "Hello, #{@user}, please register")
  end
end
