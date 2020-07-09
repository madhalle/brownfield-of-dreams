require "rails_helper"

RSpec.describe ValidationMailer, type: :mailer do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "inform" do
    user = create(:user)
    # Create the email and store it for further assertions
    email = ValidationMailer.inform({message: "Validate your account",
                                    account_holder: user}, 'me@example.com')

    # Send the email, then test that it got queued
    # assert_emails 1 do
    #   require "pry"; binding.pry
    #   email.deliver_now
    # end
    # Test the body of the sent email contains what we expect it to
    assert_equal ['mad.halle@icloud.com'], email.from
    assert_equal ["me@example.com"], email.to
  end
end
