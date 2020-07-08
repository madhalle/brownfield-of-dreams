require "rails_helper"

RSpec.describe ValidationMailer, type: :mailer do
  # pending "add some examples to (or delete) #{__FILE__}"
  xit "inform" do
    # Create the email and store it for further assertions
    email = ValidationMailer.inform(message:"Validate your account",
                                    account_holder: 'me@example.com')

    # Send the email, then test that it got queued
    # assert_emails 1 do
    #   require "pry"; binding.pry
    #   email.deliver_now
    # end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['me@example.com'], email.recipient
    # assert_equal ['friend@example.com'], email.to
    assert_equal 'Visit here to activate your account.', email.info
    assert_equal read_fixture('inform').join, email.body.to_s
  end
end
