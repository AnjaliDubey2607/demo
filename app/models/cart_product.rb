class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  scope :return_cart_product, ->(attributes,params){
    @cartproducts = CartProduct.where(attributes => params)}


  def self.add_cartproduct(params,cart)
    @cartproduct=CartProduct.return_cart_product("cart_id",cart).and(CartProduct.return_cart_product("product_id",params))
    if @cartproduct.present?
      @cartproduct[0].quantity +=1
      @cartproduct[0].total_price += Product.find_product("id",params).price
      @cartproduct[0].update(quantity:@cartproduct[0].quantity,total_price:@cartproduct[0].total_price)   
    else
        CartProduct.create(quantity:1, product_id:params, total_price:Product.find_product("id",params).price,cart_id:cart) 
    end
  end


  def self.remove_quantity(cartproducts,product_id)
    cartproducts.each do |cartproduct|
      if cartproduct.product_id == product_id.to_i
        if cartproduct.quantity > 1
          cartproduct.quantity -= 1
          cartproduct.total_price -= Product.find_product("id",product_id).price
          cartproduct.update(quantity:cartproduct.quantity,total_price:cartproduct.total_price) 
        end
      end
    end
  end


end
