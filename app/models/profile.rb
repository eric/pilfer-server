class Profile < ActiveRecord::Base
  attr_accessible :app, :hostname, :payload, :pid

  scope :latest, limit(5).order('id DESC')
end
