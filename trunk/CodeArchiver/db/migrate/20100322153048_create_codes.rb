class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.string :title
      t.text :code_body
      t.string :tag
      t.text :description
      t.text :shortdescription
      t.references :user
      t.references :program_language
      t.references :category
      t.references :type

      t.timestamps
    end
  end

  def self.down
    drop_table :codes
  end
end
