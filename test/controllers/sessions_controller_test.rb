require "test_helper"
require 'pry'

describe SessionsController do

  it "redirects to home page, sets user id on session, and displays a successful flash message when successfully logging in with github" do
    # Arrange
    # make sure that for some existing user, everything is configured!

    grace = users(:grace)

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( grace ) )

    # Act
    # Simulating logging in with github being successful (given the OmniAuth hash made above)
    get auth_callback_path(:github)

    # Assert
    # check that it redirects
    must_redirect_to root_path
    expect(session[:user_id]).must_equal grace.id
    # check on flash that there is a key called :success
    expect(flash[:success]).must_equal "Logged in as existing user #{grace.username}"



  end

end
