require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
    describe 'instructions' do
      user = User.create(email: "joe@example.com",
                        first_name: "Joe",
                        last_name: "Biden",
                        password: "password",
                        role: "default",
                        token: ENV["GITHUB_TOKEN"])
      user_email = user.email
      email_info = { user: user.first_name,
                      user_email: user.email,
                      user_id: user.id }
      let(:mail) { RegistrationMailer.inform(email_info, user_email) }

      it 'renders the subject' do
        expect(mail.subject).to eql('Hello, Joe, please register')
      end

      it 'renders the receiver email' do
        expect(mail.to).to eql([user.email])
      end

      it 'renders the sender email' do
        expect(mail.from).to eql(['no-reply@advice.io'])
      end


      it 'assigns @confirmation_url' do
        expect(mail.body.encoded).to match("http://localhost3000/confirm/#{user.id}")
      end
    end
  end
