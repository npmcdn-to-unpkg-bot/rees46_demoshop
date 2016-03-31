class Category < ActiveRecord::Base
  extend ActsAsTree::TreeWalker
  extend FriendlyId

  acts_as_tree order: 'name'

  friendly_id :name, use: [:slugged, :history]

  has_many :products
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'Category'

  validates :name, presence: true

  def should_generate_new_friendly_id?
    new_record?
  end

  def human_categories_industry
    if  self.categories_industry == 0
      return 'fashion'
    elsif  self.categories_industry == 1
      return 'cosmetic'
    else  self.categories_industry == 2
      return 'child'
    end
  end
end
