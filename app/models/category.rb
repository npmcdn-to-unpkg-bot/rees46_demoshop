class Category < ActiveRecord::Base
  extend ActsAsTree::TreeWalker
  extend FriendlyId

  acts_as_tree order: 'name'

  friendly_id :name, use: :slugged

  has_many :products
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'Category'

  validates :name, presence: true


  def human_categories_industry
    if categories_industry == 0
      return 'fashion'
    elsif categories_industry == 1
      return 'cosmetic'
    elsif categories_industry == 2
      return 'child'
    end
  end
end
