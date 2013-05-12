require 'features/helper'

describe 'Viewing the home page' do
  context 'with authorization configured' do
    before do visit home_page_path end

    it 'shows sign in button'

    context 'signed in' do
      it 'redirects to dashboard'
    end
  end

  context 'without authorization configured' do
    before do visit home_page_path end

    it 'redirects to dashboard' do
      expect(current_path).to eq(dashboard_path)
    end
  end

  context 'with authorization ignored' do
    before do
      ENV['GITHUB_UNSECURED'] = 'true'
      visit home_page_path
    end
    after do ENV.delete 'GITHUB_UNSECURED' end

    it 'redirects to dashboard' do
      expect(current_path).to eq(dashboard_path)
    end
  end
end
