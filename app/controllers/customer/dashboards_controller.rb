class Customer::DashboardsController < Customer::BaseCustomerController
  before_action :current_cart, only: [:add_cart, :cart_details, :remove_cartproduct,:add_order]

  def index
    @products = Product.all
  end

  def show
    @product=Product.find_product("id",params[:id])
  end

  def product_list
    @products = Product.where(category_id:params[:id])
  end

  def cart_details
    @cartproducts =  CartProduct.return_cart_product("cart_id",@cart)
  end

  def add_cart
    unless @cart.present?
        @cart= current_user.carts.create(status:true) 
    end
    CartProduct.add_cartproduct(params[:id], @cart.id)
    redirect_to customer_cart_details_path
  end

  def remove_cartproduct
    @cartproduct= CartProduct.return_cart_product("cart_id",@cart)
    CartProduct.remove_quantity(@cartproduct,params[:id])
    redirect_to customer_cart_details_path
  end

  def order_list
    @orders = Order.all.order(id: :desc)
  end

  def add_order
    Order.create_order(@cart)
    Cart.update_cart(@cart,"status","false")
    redirect_to customer_order_list_path
  end

  def destroy
    @cartproduct = CartProduct.find(params[:id])
    @cartproduct.destroy
    redirect_to customer_cart_details_path
  end

  def payment_type
  end

  private

  def current_cart
    if user_signed_in?
      @cart= Cart.current_user_cart(current_user.id)         
    else
      redirect_to user_session_path
    end
  end

end