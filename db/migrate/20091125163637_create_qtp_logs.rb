class CreateQtpLogs < ActiveRecord::Migration
  def self.up
    create_table :qtp_logs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :qtp_logs
  end
end
