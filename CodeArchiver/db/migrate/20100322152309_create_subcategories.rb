class CreateSubcategories < ActiveRecord::Migration
  def self.up
    create_table :subcategories do |t|
      t.integer :child_id
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :subcategories
  end
end
