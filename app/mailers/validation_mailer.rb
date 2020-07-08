class ValidationMailer < ApplicationMailer
  def inform(info, recipient)
    # require "pry"; binding.pry
    @message = info[:message]
    @user = info[:account_holder]
    mail(to: recipient, subject: "Validate your account")
  end
end
