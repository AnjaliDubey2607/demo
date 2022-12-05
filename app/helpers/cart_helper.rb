module CartHelper
    def update_cart_price(total_price)
        @cart=Cart.current_user_cart(current_user.id)
        Cart.update_cart(@cart,"total_price",total_price)
    end
end