class ValidationMailer < ApplicationMailer
  def inform(info, recipient)
    @message = info[:message]
    mail(to: recipient, subject: "Validate your account")
  end
end
