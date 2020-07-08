class ValidationMailer < ApplicationMailer
  def inform(info, recipient)
    @user = info[:account_holder]
    mail(to: recipient, subject: "Validate your account")
  end
end
