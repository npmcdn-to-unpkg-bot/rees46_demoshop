class Category < ActiveRecord::Base
  belongs_to :parents, class: "Category", foreign_key: :parents_id

  validates :name, present: true
end
