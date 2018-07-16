class QcMailer < ActionMailer::Base
  
  helper :application
  layout 'lmail'
   
  def contact(sMessage)
    setup_email()
    @body[:message] = sMessage
  end
  
   protected
    def setup_email()
      @recipients  = "eosullivan@epnet.com"
      @from = 'DDPQAAutomationTeam@ebscohost.com'
      @subject = "!!! AutoQC job is stuck !!!"
      @sent_on     = Time.now
      @content_type = "text/html"
    end
	
end
