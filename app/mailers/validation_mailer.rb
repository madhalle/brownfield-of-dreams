class ValidationMailer < ApplicationMailer
  def inform(info, recipient)
    @user = info[:account_holder]
    mail(to: recipient, subject: "Validate your account")
  end

  def invite(name, email, inviter)
    @user = name
    @inviter = inviter
    mail(to: email, subject: "You've been INVITED!!!!!")
  end
end
