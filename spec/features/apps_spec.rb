require 'features/helper'

describe 'Managing Apps' do
  describe 'viewing the apps listing' do
    context 'with no apps' do
      before do visit apps_path end

      it 'shows a message to create an app' do
        expect(page).to have_content('You have no apps!')
        click_link 'Create one now'
        expect(current_path).to eq(new_app_path)
      end
    end

    context 'with an app' do
      let!(:app) { App.create!(name: 'My App') }
      before do visit apps_path end

      it "displays the app's details" do
        expect(page).to have_content(app.name)
        expect(page).to have_content(app.token)
      end
    end
  end

  describe 'creating an app' do
    let(:app_name) { 'My App' }

    context 'with a unique name' do
      before do
        visit new_app_path
        fill_in 'app_name', with: app_name
        click_button 'Create App'
      end

      it 'creates the app' do
        expect(App.exists?(name: app_name)).to be_true
        expect(page).to have_content('App created')
        expect(current_path).to eq(apps_path)
      end
    end

    context 'with the same name of another app' do
      before do
        App.create!(name: app_name)
        visit new_app_path
        fill_in 'app_name', with: app_name
        click_button 'Create App'
      end

      it 'does not create the app' do
        expect(App.where(name: app_name).count).to eq(1)
        expect(page).to have_content('Name has already been taken')
      end
    end
  end

  describe 'updating an app' do
    let!(:app)     { App.create!(name: old_name) }
    let(:old_name) { 'My App' }
    let(:new_name) { 'Renamed' }

    before do
      visit apps_path
      click_link 'Edit'
    end

    it 'displays the app edit form' do
      expect(current_path).to eq(edit_app_path(app))
      expect(find_field('app_name').value).to eq(app.name)
    end

    context 'with a unique name' do
      before do
        fill_in 'app_name', with: new_name
        click_button 'Update App'
      end

      it 'updates the app' do
        expect(App.exists?(name: old_name)).to be_false
        expect(App.exists?(name: new_name)).to be_true
        expect(page).to have_content('App updated')
        expect(current_path).to eq(apps_path)
      end
    end

    context 'with the same name of another app' do
      before do
        App.create!(name: new_name)
        fill_in 'app_name', with: new_name
        click_button 'Update App'
      end

      it 'does not update the app' do
        expect(App.where(name: new_name).count).to eq(1)
        expect(page).to have_content('Name has already been taken')
      end
    end
  end

  describe 'deleting an app' do
    let!(:app) { App.create(name: 'My App') }

    before do
      visit apps_path
      click_link 'Delete'
    end

    it 'deletes the app' do
      expect(App.exists?(app)).to be_false
      expect(current_path).to eq(apps_path)
    end
  end
end
