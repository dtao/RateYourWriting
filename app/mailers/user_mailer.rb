class UserMailer < ActionMailer::Base
  def email_verification(user)
    @user = user

    mail({
      :to => user.email,
      :from => "registration@#{Env::HTTP_HOST}",
      :subject => 'Welcome to RateYourWriting!'
    })
  end
end
