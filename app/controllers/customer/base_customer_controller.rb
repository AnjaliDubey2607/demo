class Customer::BaseCustomerController < ApplicationController
    before_action :authorize_Customer
  private
    def authorize_Customer
        if current_user.present?
            redirect_to root_path, alert: 'Access Denied' if current_user.role== ("Supplier" || "Admin")
           # redirect_to root_path, alert: 'Access Denied' if current_user.role=="Admin" 
        end
    end
end