class Order < ApplicationRecord
    belongs_to :user
    belongs_to :cart

    scope :create_order, ->(cart){Order.create(status:"true",cart_id:cart.id,user_id:cart.user_id)}
end
