class Category < ActiveRecord::Base
  extend ActsAsTree::TreeWalker
  acts_as_tree order: 'name'
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :products
  validates :name, presence: true

  belongs_to :parent, class_name: 'Category'
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
end
