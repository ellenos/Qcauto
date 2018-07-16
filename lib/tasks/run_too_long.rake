namespace :monitor do
  desc "Check that no job has been running more than 4 hours"
  task :run_too_long => :environment do
	  
    record = DelayedMonitor.jobs_stuck
    message = "False alarm: No records were found"
    
    if !record.nil?
	qr = QtpResource.find_by_delayed_job_id(record.id)
	if !qr.nil?
	  m = Machine.find_by_qtp_resource_id(qr.id)
	  message = "Product code: " + qr.dbcode + "<br/>"
	  message = message + "Label: " + qr.label + "<br/>"
	  if m.blank?
	    message = message + "QTP machine: Not running on any machine<br/>"
	  else
	    message = message + "QTP machine: " + m.name + "<br/>"
	  end
        end
    end
  
    QcMailer.deliver_contact(message)
  end

end