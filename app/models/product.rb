class Product < ApplicationRecord
    belongs_to :user
	belongs_to :category
    has_many :cart_products, dependent: :destroy
    has_many :carts, through: :card_products

    mount_uploader :avatar, AvatarUploader

    scope :find_product, ->(attribute,params) { @product = Product.find_by(attribute => params)}

end
