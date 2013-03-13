class AddDescriptionToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :description, :string
  end
end
