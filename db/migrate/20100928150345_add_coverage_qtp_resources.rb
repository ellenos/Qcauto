class AddCoverageQtpResources < ActiveRecord::Migration
  def self.up
    add_column :qtp_resources, :coverage, :string
  end

  def self.down
    remove_column :qtp_resources, :coverage
  end
end
