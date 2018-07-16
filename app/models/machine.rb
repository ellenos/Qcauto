require 'win32ole'

class Machine < ActiveRecord::Base 

	# Constants
  Forced_reboot = 6
  WbemImpersonationLevelImpersonate = 3
  WbemAuthenticationLevelPktPrivacy = 6

  Qdomain = "CORP"
  Quser_name = "CORP\\Product"
  Qpassword = "CarDinal13"

  def connect_system
    @oLocator = WIN32OLE.new("WbemScripting.SWbemLocator")
    @oService = @oLocator.ConnectServer(self[:name], "root\\cimv2", Quser_name, Qpassword)
    @oService.Security_.ImpersonationLevel = WbemImpersonationLevelImpersonate
    @oService.Security_.AuthenticationLevel = WbemAuthenticationLevelPktPrivacy
  end

  def isRunning
    isRunning = "QTP not running"
    connect_system
    processes = @oService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'QTPro.exe'")

    # will only be one process per machine
    for process in processes do
    	isRunning = "QTP is running"
    end
    return isRunning
  end


  def reboot_machine
    connect_system
    colOS = @oService.ExecQuery("SELECT * FROM Win32_OperatingSystem")

    # just will return one system object
    for objOS in colOS do
      objOS.Win32Shutdown(Forced_reboot)
    end
    self[:status] = 0
    self.save!
  end
	

  def startQTP(flow, the_db, label, email, lognum, engine)

    @oLocator = WIN32OLE.new("WbemScripting.SWbemLocator")
    @qtp_script = "ruby " + configatron.qtp_startup_script + " " + flow + " " + the_db + " " + label + " " + email + " " + lognum.to_s + " " + engine
    connect_system
    oProcess = @oService.Get("Win32_Process")
    errReturn = oProcess.Create(@qtp_script, nil, nil, 0)

    if errReturn == 0 then
      logger.debug "QTP was started with command line " + @qtp_script
    else
      logger.debug "QTP could not be started due to error: " + errReturn.to_s
    end
  end
  
  def whatsRunning
    whats = ""
    qid = self[:qtp_resource_id]
    if !qid.nil? then
	q = QtpResource.find_by_id(qid) 
	if !q.nil? then
	  whats = q.dbcode + " in " + q.label
        end	  
    end
    return whats 
  end

end
