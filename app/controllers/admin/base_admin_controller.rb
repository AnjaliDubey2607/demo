class Admin::BaseAdminController < ApplicationController
    before_action :authorize_admin
    private
    def authorize_admin
      if user_signed_in?
        redirect_to autherised_path, alert: 'Access Denied' unless current_user.role=="Admin"
      end
    end
    
end