class UserMailer < ActionMailer::Base
  default :from => 'donotreply@ryw.herokuapp.com'

  def email_verification(user)
    @user = user

    mail({
      :to => user.email,
      :subject => 'Welcome to RateYourWriting!'
    })
  end
end
