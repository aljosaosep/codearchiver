class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :email
      t.string :IM
      t.string :company
      t.text :portfolio
      t.string :webpage
      t.string :avatar
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
