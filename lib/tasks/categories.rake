namespace :categories do
  task product_count_calc: :environment do
    Category.where(parent_id: nil).each do |parent_category|
      parent_category.children.each do |first_child|
        if first_child.children.any?
          first_child.products_count = first_child.children.sum(:products_count)
          first_child.save!
        end
      end
      parent_category.products_count = parent_category.children.sum(:products_count)
      parent_category.save!
    end
  end
end
