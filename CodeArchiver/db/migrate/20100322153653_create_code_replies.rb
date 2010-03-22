class CreateCodeReplies < ActiveRecord::Migration
  def self.up
    create_table :code_replies do |t|
      t.integer :child_id
      t.references :code

      t.timestamps
    end
  end

  def self.down
    drop_table :code_replies
  end
end
