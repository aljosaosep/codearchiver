class AdminLog < ActiveRecord::Base
   def log(id, controller, action)
    @admin_log = self.new(id, :controller => controller, :action => action)
    @admin_log.save
   end
end
