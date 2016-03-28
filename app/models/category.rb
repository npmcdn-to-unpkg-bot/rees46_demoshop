class Category < ActiveRecord::Base
  extend ActsAsTree::TreeWalker
  extend FriendlyId

  acts_as_tree order: 'name'

  friendly_id :name, use: :slugged

  has_many :products
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'Category'

  validates :name, presence: true
end
