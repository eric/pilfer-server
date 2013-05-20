require 'features/helper'

describe 'Managing Apps' do
  describe 'Viewing the apps listing' do
    context 'when no apps are found' do
      before { visit apps_path }

      it 'displays a no apps message' do
        expect(page).to have_content('No apps found')
      end

      it 'provides a link to create a new app' do
        expect(page).to have_link('Create a new App', href: new_app_path)
      end
    end

    context 'when an app is found' do
      let(:app) { App.create!(name: 'My App') }

      before do
        app
        visit apps_path
      end

      it 'displays the app name' do
        expect(page).to have_content(app.name)
      end

      it 'displays the app token' do
        expect(page).to have_content(app.token)
      end

      it 'provides a link to delete the app' do
        expect(page).to have_link('Delete', href: app_path(app))
      end

      it 'provides a link to edit the app' do
        expect(page).to have_link('Edit', href: edit_app_path(app))
      end
    end
  end

  describe 'Deleting an app' do
    before do
      App.create!(name: 'My App')
      visit apps_path
    end

    it 'deletes the app' do
      expect{ click_link 'Delete' }.to change { App.count }.by(-1)
    end

    it 'redirects to dashboard' do
      click_link 'Delete'
      expect(current_path).to eq(dashboard_path)
    end
  end

  describe 'Creating an app' do
    let(:app_name) { 'My App' }

    before { visit new_app_path }

    def create_app
      fill_in 'app_name', with: app_name
      click_button 'Create App'
    end

    it 'displays no app name' do
      expect(find_field('app_name').value).to be_blank
    end

    it 'allows creating an app' do
      expect{ create_app }.to change{ App.count }.by(1)
    end

    context 'when successful' do
      it 'displays app was created message' do
        create_app
        expect(page).to have_content('successfully created')
      end

      it 'redirects to app details' do
        create_app
        app = App.last
        expect(current_path).to eq(app_path(app))
      end
    end

    context 'when not successful' do
      before { App.create!(name: app_name) }

      it 'displays an error message' do
        create_app
        expect(page).to have_content('Name has already been taken')
      end
    end
  end

  describe 'Updating an app' do
    let(:app) { App.create!(name: 'My App') }
    let(:new_name) { 'An App' }

    before do
      app
      visit edit_app_path(app)
    end

    def update_app
      fill_in 'app_name', with: new_name
      click_button 'Update App'
      app.reload
    end

    it 'displays the app name' do
      expect(find_field('app_name').value).to eq(app.name)
    end

    it 'allows changing the app name' do
      update_app
      expect(app.name).to eq(new_name)
    end

    context 'when successful' do
      it 'displays app was updated message' do
        update_app
        expect(page).to have_content('successfully updated')
      end

      it 'redirects to app details' do
        update_app
        expect(current_path).to eq(app_path(app))
      end
    end
  end
end
