class Category < ActiveRecord::Base
  extend ActsAsTree::TreeWalker
  acts_as_tree order: "name"
  has_many :products
  validates :name, presence: true
  has_many :children, class_name: 'Category', foreign_key: :parent_id, :dependent => :destroy
  belongs_to :parent, class_name: 'Category'
end
