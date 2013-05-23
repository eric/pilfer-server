require 'helper'

describe Profile do
  let(:profile_data) { JSON.parse(profile_file) }
  let(:profile_file) {
    File.read(Rails.root.join(*%w(spec features api support profile.json)))
  }

  subject {
    Profile.create!(hostname:     profile_data['hostname'],
                    pid:          profile_data['pid'],
                    description:  profile_data['description'],
                    payload:      profile_data['profile'],
                    file_sources: profile_data['file_sources'])
  }

  its(:hostname)     { should eq('52c8ede0-6f4a-479a-ad2e-d0eaaec9a3e4') }
  its(:pid)          { should eq(59078) }
  its(:description)  { should eq('GET /api/v1/dependencies') }
  its(:payload)      { should have(3).keys }
  its(:file_sources) { should have(2).keys }
  its(:total_time)   { should eq(1522540) }
  its(:cpu_time)     { should eq(43151) }
  its(:idle_time)    { should eq(1479389) }

  context 'with no payload' do
    let(:profile_data) {
      data = JSON.parse(profile_file)
      data['profile'] = {}
      data
    }

    its(:total_time) { should eq(0) }
  end

  context 'with no files in the payload' do
    let(:profile_data) {
      data = JSON.parse(profile_file)
      data['profile'].delete 'files'
      data
    }

    its(:total_time) { should eq(0) }
  end

  context 'with a negative idle time' do
    let(:profile_data) {
      data = JSON.parse(profile_file)
      data['profile']['files']['lib/bundler_api/web.rb']['total_cpu'] = 1522540
      data
    }

    it 'rounds up to zero' do
      expect(subject.idle_time).to eq(0)
    end
  end
end
