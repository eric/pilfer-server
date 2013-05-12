require 'features/api/helper'

describe 'Sending a profile' do
  let(:app) { App.create!(name: 'My App') }
  let(:profile_data) {
    profile_path = Rails.root.join(*%w(spec features api support
                                       profile.json))
    JSON.parse(File.read(profile_path))
  }

  context 'without authentication' do
    before do post api_profiles_path, profile_data end

    it 'requests authentication' do
      expect(last_response.status).to eq(403)
    end
  end

  context 'with authentication' do
    before do
      header 'Authorization', ActionController::HttpAuthentication::Token.
                                  encode_credentials(app.token)
      post api_profiles_path, profile_data
    end

    it 'saves the profile' do
      expect(last_response.status).to eq(200)
      expect(app.profiles.count).to eq(1)
    end
  end
end
