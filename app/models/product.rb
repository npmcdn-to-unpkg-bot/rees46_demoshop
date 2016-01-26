class Product < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true
  validates :image, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :brand, presence: true
  mount_uploader :image, ImageUploader
end
