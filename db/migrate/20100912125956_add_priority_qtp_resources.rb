class AddPriorityQtpResources < ActiveRecord::Migration
  def self.up
    add_column :qtp_resources, :priority, :integer
  end

  def self.down
    remove_column :qtp_resources, :priority
  end
end
