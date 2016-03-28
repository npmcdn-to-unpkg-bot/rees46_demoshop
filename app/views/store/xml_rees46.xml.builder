xml.instruct!
xml.xml_catalog("date"=>"#{Time.now.strftime("%d/%m/%Y %H:%M")}") do
  xml.shop do
    xml.name 'Rees46 Demo'
    xml.company 'REES46'
    xml.url "#{root_url}"

    xml.currencies do |currency|
      xml.currency("id" => "RUB" ,"rate" => "1.00000")
    end

    xml.categories do
      @categories.each do |category|
        xml.category("#{category.name}","id"=>"#{category.id}")
          if category.children.any?
            category.walk_tree do |c, level|
              xml.category("id"=>"#{c.id}", "parentId" => "#{category.id}") {
                xml.text! "#{c.name}"
              }
            end
          end
      end
    end

    xml.offers do |offer|
      @products.where.not(stock: 0).each do |product|
        xml.offer("id" => "#{product.id}", "available" => "#{product.is_available? == 1}") {
          xml.url "#{product_url(product)}"
          xml.price "#{product.price}"
          xml.currencyId "RUB"
          xml.picture "#{image_url(product.image)}"
          xml.vendor "#{product.brand.name}"
          xml.name "#{product.title}"
          xml.description "#{ActionView::Base.full_sanitizer.sanitize(product.description)}"
          if product.industry == "Fashion"
            xml.fashion {
              xml.gender "#{product.gender_type?}"
              xml.type "#{Product::COMMON_TYPES.merge(Product::ADULT_TYPES).keys[product.product_type.to_i]}"
              xml.sizes {
                # Product.const_get(Product::SIZES.keys[product.size.to_i].gsub(' ', '_').upcase).each do |ps|
                #   xml.size "#{ps[product.size.to_i]}"
                # end
                if product.size && Product::SIZES.keys[product.size].present?
                  product.human_avilable_sizes.each do |ps|
                    xml.size "#{ps[product.size.to_i]}"
                  end
                end
                }
              }
          elsif product.industry == "Cosmetic"
            xml.cosmetic {
              xml.gender "#{product.gender_type?}"
              xml.type "#{product}"
            }
          elsif product.industry == "Child"
            xml.child {
              xml.gender "#{product.gender_type?}"
              xml.type "#{product}"
            }
          end
        }
      end

      @products.where(stock: 0).each do |product|
        xml.offer("id" => "#{product.id}", "available" => "#{product.is_available? == 1}") {
          xml.url "#{product_url(product)}"
          xml.price "#{product.price}"
          xml.currencyId "RUB"
          xml.picture "#{image_url(product.image)}"
          xml.vendor "#{product.brand.name}"
          xml.name "#{product.title}"
          xml.description "#{ActionView::Base.full_sanitizer.sanitize(product.description)}"
        }
      end
    end
  end
end
