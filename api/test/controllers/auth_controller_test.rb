require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email = users(:johan).email
    @password = 'secret123'

    @new_email = "newuser@gmail.com"
    @name = "Name Name"
  end

  test 'should sign in' do
    post new_user_session_url, headers: { email: @email, password: @password }, as: :json
    assert_equal 200, response.status
    assert_equal @email, response.header['uid']
  end

  test 'should register' do
    post user_registration_url,
         params: { email: @new_email,
                   password: @password,
                   password_confirmation: @password,
                   name: @name }, as: :json
    assert_response :success
  end

end