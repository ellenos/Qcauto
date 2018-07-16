require 'win32ole'

class QtpResource < ActiveRecord::Base

 # find test run results associated with this qa test id and run them
  def runDelayed(the_machine)
    #logger.debug "running delayed dbcode: " + self.dbcode + " label: " +  self.label + " email: " + self.Email + " testID: " + self.id.to_s
    #logger.debug "setting machine status to 1 " + the_machine.name
    the_machine.status = 1
    the_machine.save
    
    if self.Email.blank?
    	self.Email = "None"
end

    if self.run_from.blank?
    	self.run_from = "None"
    end

    self.servername = the_machine.name
    self.save
    
    if self.run_from == "autosys"
      engine = "None"
    else
      engine = self.run_from
    end
    
#    n = self.run_from.index('_')
#    if n != nil
#      logger.debug "found an underscore in run_from"
#      a = self.run_from.split('_')
#      engine_code = a[1]
#      if a[1] == "prod"
#        engine = "PROD-MASTER101"
#      elsif a[1] == "qa"
#        engine = "QAAW-MASTER101"
#      else
#        engine = "None"
#      end
#    else
	# default to none for engine
#      engine = "None"
#    end
   
    the_machine.startQTP(self.coverage, self.dbcode, self.label, self.Email, self.id, engine)
    
    #logger.debug "Done running dbcode: " + self.dbcode + " label: " +  self.label + " email: " + self.Email + " testID: " + self.id.to_s + " engine: " + engine

  end

end
