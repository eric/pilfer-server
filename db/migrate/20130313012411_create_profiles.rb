class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :app

      t.string :hostname
      t.string :pid
      t.text :payload

      t.timestamps
    end
    
    add_index :profiles, :app_id
  end
end
