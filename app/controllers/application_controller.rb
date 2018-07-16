# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  self.allow_forgery_protection = false
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password


  def qcauto_user_agent
    return request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(qcauto)/]
  end
  
#  def appworx_user_agent
#    return request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(appworx)/]
#  end

  def appworx_qaaw_user_agent
    return request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(qaaw)/]
  end

  def appworx_paaw_user_agent
    return request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(paaw)/]
  end
  
  def appworx_prod_user_agent
    return request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(prod)/]
  end
  
  def appworx_qa_user_agent
    return request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(qa)/]
  end

  
end
