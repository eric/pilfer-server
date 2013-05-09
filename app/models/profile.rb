class Profile < ActiveRecord::Base
  attr_accessible :hostname, :pid, :description, :payload, :file_sources

  serialize :payload, JSON
  serialize :file_sources, JSON

  belongs_to :app

  scope :latest, limit(50).order('id DESC')

  def total_time
    sum_field('total')
  end

  def cpu_time
    sum_field('total_cpu')
  end

  def idle_time
    [ 0, total_time - cpu_time ].max
  end

  private

  def sum_field(field)
    return 0 unless payload and payload['files']
    payload['files'].inject(0) {|total, (file, data)| total + data[field] }
  end
end
