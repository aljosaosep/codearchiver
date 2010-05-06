class AddViewsToCode < ActiveRecord::Migration
  def self.up
    add_column :codes, :views, :integer
  end

  def self.down
    remove_column :codes, :views
  end
end
