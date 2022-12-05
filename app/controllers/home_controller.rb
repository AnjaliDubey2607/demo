class HomeController < ApplicationController
    def index
        if user_signed_in?
            if current_user.role == "Admin"
                redirect_to admin_dashboards_product_list_path
            elsif current_user.role == "Supplier"
                redirect_to supplier_products_path
            else
                redirect_to customer_dashboards_path
            end
        else
            @products = Product.all
            render "/customer/dashboards/index"
        end 
    end

    def page_not_found
    end

    def autherised
    end 

end
