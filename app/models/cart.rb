class Cart < ApplicationRecord
    belongs_to :user
    has_one :order,  dependent: :destroy
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products

    scope :create_cart, ->{Cart.create(status:true)}
    scope :current_user_cart, ->(params){Cart.where("user_id"=>params) && (Cart.find_by(status:true))}
    scope :update_cart, ->(cart,attributes,params){cart.update(attributes=>params)}    
end
