require "test_helper"
require 'pry'

describe SessionsController do

  it "can successfully log in with github as an existing user" do
    # Arrange
    # make sure that for some existing user, everything is configured!

    grace = users(:grace)

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( grace ) )

    # Act
    # Simulating logging in with github being successful (given the OmniAuth hash made above)
    get auth_callback_path(:github)

    # Assert

    must_redirect_to root_path
    expect(session[:user_id]).must_equal grace.id
    expect(flash[:success]).must_equal "Logged in as existing user #{grace.username}"

  end

  it "creates a new user successfully when logging in with a new valid user" do

    start_count = User.count

    new_user = User.new(username: "new user", image_url: "some image", uid: 3, provider: :github)

    # if new_user is not valid, then this test isn't testing the right thing
    expect(new_user.valid?).must_equal true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( new_user ) )

    get auth_callback_path(:github)

    must_redirect_to root_path
    # binding.pry
    expect( User.count ).must_equal start_count + 1
    expect( session[:user_id] ).must_equal User.last.id
  end

  it "does not create a new user when logging in with a new invalid user" do
    start_count = User.count

    invalid_new_user = User.new(username: nil, image_url: nil)

    # if invalid_new_user is valid, then this test isn't testing the right thing
    expect(invalid_new_user.valid?).must_equal false

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( invalid_new_user ) )

    get auth_callback_path(:github)

    must_redirect_to root_path
    expect( session[:user_id] ).must_equal nil
    expect( User.count ).must_equal start_count
  end

end
