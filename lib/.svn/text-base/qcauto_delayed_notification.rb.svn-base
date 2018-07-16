

class QcautoDelayedNotification

  attr_accessor :qtp_resource_id



  def initialize(qtp_resource)
    self.qtp_resource_id = qtp_resource.id
  end

  def logger
    RAILS_DEFAULT_LOGGER
  end

  def perform
    the_machine = Delayed::Job.machine
    logger.debug "setting machine status to 1 " + the_machine.name
    the_machine.status = 1
    the_machine.save
    oQtp = QtpResource.find(qtp_resource_id)
    # send it to an available server
    oQtp.runDelayed(the_machine)
  end
  
end
