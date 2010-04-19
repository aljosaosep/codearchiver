class AddListingToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :listing, :integer
  end

  def self.down
    remove_column :profiles, :listing
  end
end
