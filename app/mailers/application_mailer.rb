class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@advice.io'
  layout 'mailer'
end
