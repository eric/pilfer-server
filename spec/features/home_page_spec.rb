require 'features/helper'

describe 'Viewing the home page' do
  before do visit home_page_path end

  context 'with authorization configured' do
    it 'shows sign in button'
  end

  context 'without authorization configured' do
    it 'redirects to dashboard' do
      expect(current_path).to eq(dashboard_path)
    end
  end

  context 'with authorization ignored' do
    it 'redirects to dashboard'
  end
end
