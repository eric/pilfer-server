require 'helper'

describe App do
  subject { App.create!(name: 'The Guide') }

  its(:name)  { should eq('The Guide') }
  its(:token) { should_not be_nil }
end
