require 'integration_helper'

describe 'Viewing the home page' do
  before do visit home_page_path end

  context 'without authorization configured' do
    it 'shows a warning message' do
      find('.alert').should have_content('You are running in development mode without any security.')
    end
  end

  context 'with authorization configured' do
    it 'shows no warning messages'
  end

  context 'with authorization ignored' do
    it 'shows no warning messages'
  end
end
