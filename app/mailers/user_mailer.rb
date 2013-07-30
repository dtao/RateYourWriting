require 'env'

class UserMailer < ActionMailer::Base
  def email_verification(user)
    @user = user

    mail({
      :to => user.email,
      :from => "registration@#{Env::HOST}",
      :subject => 'Welcome to RateYourWriting!'
    })
  end
end
