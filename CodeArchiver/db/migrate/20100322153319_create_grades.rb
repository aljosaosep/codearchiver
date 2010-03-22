class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.decimal :value
      t.references :user
      t.references :code

      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
