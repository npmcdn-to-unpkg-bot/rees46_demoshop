class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id
  has_many :products
  validates :name, presence: true
  has_many :children, class_name: 'Category', foreign_key: :parent_id
end
