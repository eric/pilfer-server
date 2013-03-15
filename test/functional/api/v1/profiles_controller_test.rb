require 'test_helper'

class Api::V1::ProfilesControllerTest < ActionController::TestCase
  test 'sending a profile' do
    app = apps(:one)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(app.token)

    post :create, JSON.parse(File.read("#{Rails.root}/test/fixtures/profile-payload-1.json"))

    assert_response :success
  end
end
