class Admin::DashboardsController < Admin::BaseAdminController

    def user_list
        @users = User.all
    end

    def product_list
        @products = Product.all
    end
    
    def order_list
        @orders = Order.all
    end

end
