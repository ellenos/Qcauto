
if ENV['OS'] == 'Windows_NT' then

  require 'win32ole'
  require 'configatron'

  configatron.qtp_startup_script = "c:\\Automation\\Scripts\\startQTP.rb"
   
end
