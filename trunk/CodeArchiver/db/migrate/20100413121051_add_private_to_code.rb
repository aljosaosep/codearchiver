class AddPrivateToCode < ActiveRecord::Migration
  def self.up
    add_column :codes, :private, :boolean
  end

  def self.down
    remove_column :codes, :private
  end
end
