class Profile < ActiveRecord::Base
  attr_accessible :hostname, :pid, :description, :payload, :file_sources

  serialize :payload, JSON
  serialize :file_sources, JSON

  belongs_to :app

  scope :latest, limit(5).order('id DESC')
end
