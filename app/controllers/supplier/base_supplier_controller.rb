class Supplier::BaseSupplierController < ApplicationController
  before_action :authorize_admin
  private
  def authorize_admin
      redirect_to autherised_path, alert: 'Access Denied' unless current_user.role=="Supplier"
    end
  end