class AddPopularityToCodes < ActiveRecord::Migration
  def self.up
    add_column :codes, :popularity, :float
  end

  def self.down
    remove_column :codes, :popularity
  end
end
