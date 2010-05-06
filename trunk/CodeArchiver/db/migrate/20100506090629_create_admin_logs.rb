class CreateAdminLogs < ActiveRecord::Migration
  def self.up
    create_table :admin_logs do |t|
      t.int :user_id
      t.string :controller
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_logs
  end
end
