class AddImgAttribToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :filename, :string # Original filename
    add_column :profiles, :thumbnail, :string # Mime type
    add_column :profiles, :size, :integer # File size in bytes
  end

  def self.down
   	remove_column :profiles, :filename
    remove_column :profiles, :thumbnail
    remove_column :profiles, :size
  end
end
