
class QcautoDelayedNotificationObserver < ActiveRecord::Observer
  observe Delayed::Job
 

 def after_create(model)
 end

end
