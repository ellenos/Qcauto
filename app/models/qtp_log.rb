class QtpLog < ActiveRecord::Base

  establish_connection :qtp_log
  set_table_name :LOG
  set_primary_key :keyname
  
end
