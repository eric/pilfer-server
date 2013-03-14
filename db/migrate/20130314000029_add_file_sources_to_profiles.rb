class AddFileSourcesToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :file_sources, :text
  end
end
