class CategoriesController < ApplicationController
    before_action :check_role, only: [:new, :create, :edit, :update ,:destroy]
    def index
        @categories=Category.all
    end

    def show
        @categories = Category.sub_category(params[:id])
    end
    def new
        @categories = Category.new
    end
    
    def create
      @categories = Category.new(category_params)
      if @categories.save
        redirect_to categories_path
      else
       render :new, status: :unprocessable_entity
      end
    end
    
    def edit
        @categories = Category.find_category("id",params[:id])
    end
    
    def update
        @categories = Category.find_category("id",params[:id])
        debugger
        if @categories.update(category_params)
          redirect_to categories_path 
        else
          render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @category = Category.find_category("id",params[:id])
        @category.destroy
        unless @category.parent_id.nil?
          redirect_to category_path(@category.parent_id)
        else
          redirect_to categories_path
        end
      end
    private
    
    def category_params
        params.require(:category).permit(:name,:parent_id)    
    end
    
    def check_role
      redirect_to root_path unless  current_user.role == "Admin"
    end
end
