require 'features/helper'

describe 'Viewing dashboard' do
  context 'with no apps' do
    before do visit dashboard_path end

    it 'shows a message to create an app' do
      expect(page).to have_content('You have no apps!')
      click_link 'Create one now'
      expect(current_path).to eq(new_app_path)
    end
  end

  context 'with a new app' do
    let(:app) { App.create!(name: 'My App') }
    before do
      app
      visit dashboard_path
    end

    it "shows the app's token" do
      find('.alert-info').should have_content(app.token)
    end
  end

  context 'with an app' do
    let(:app)     { App.create!(name: 'My App') }
    let(:profile) { app.profiles.create!(description:  'Profile') }
    before do
      profile
      visit dashboard_path
    end

    it "shows the app's profile" do
      click_link profile.description
      expect(current_path).to eq(app_profile_path(app, profile))
    end
  end
end
