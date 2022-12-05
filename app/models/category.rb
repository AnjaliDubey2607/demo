class Category < ApplicationRecord
    validates :name, presence:true
    
    has_many :products, dependent: :destroy
    has_many :subordinates, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
    belongs_to :parent, class_name: 'Category', optional: true

    scope :category,->{ Category.where(parent_id:nil)}
    scope :category_name, ->{ Category.where.not(id: Category.where.not(parent_id:nil).pluck(:parent_id) )}
    scope :sub_category, ->(params){Category.where(parent_id:params)}
    scope :find_category, ->(attributes,params){Category.find_by(attributes => params)}
end

