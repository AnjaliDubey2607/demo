class Supplier::ProductsController < Supplier::BaseSupplierController

    def index
        @products = Product.where(user_id: current_user.id)
    end

    def show
        @product=Product.find_product("id",params[:id])
    end
    
    def new
        @product = Product.new
    end
    
    def create
        @product = current_user.products.new(product_params)
        if @product.save
            redirect_to supplier_product_path(@product.id)
        else
            render :new
        end
    end
    
    def edit
        @product =Product.find_product("id",params[:id])
    end
    
    def update
        @product = Product.find_product("id",params[:id])
        if @product.update(product_params)
          redirect_to supplier_product_path(@product.id) 
        else
          render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @product = Product.find_product("id",params[:id])
        @product.destroy
        redirect_to supplier_products_path
    end

    private
    def product_params
        params.require(:product).permit(:name,:price,:description,:category_id,:avatar)
    end
end