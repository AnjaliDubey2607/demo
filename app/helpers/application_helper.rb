module ApplicationHelper
    def count_cart
        @cart = Cart.current_user_cart(current_user.id)
        cart_count = CartProduct.return_cart_product("cart_id",@cart).count
    end

end
