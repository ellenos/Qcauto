class AddFromToQtpResources < ActiveRecord::Migration
  def self.up
    add_column :qtp_resources, :from, :string
  end

  def self.down
    remove_column :qtp_resources, :from
  end
end
