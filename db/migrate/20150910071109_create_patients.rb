class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :blood_group
      t.string :contact_details, limit: 1024
    end
  end
end
