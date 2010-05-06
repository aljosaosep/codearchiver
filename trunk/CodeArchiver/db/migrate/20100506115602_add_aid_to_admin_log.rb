class AddAidToAdminLog < ActiveRecord::Migration
  def self.up
    add_column :admin_logs, :aid, :integer
  end

  def self.down
    remove_column :admin_logs, :aid
  end
end
