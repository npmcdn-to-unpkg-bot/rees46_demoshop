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
          if product.description.nil?
            xml.description "#{ActionView::Base.full_sanitizer.sanitize(product.description)}"
          end
          if product.industry == "Fashion"
            xml.fashion {
              if !product.gender_type.nil?
                xml.gender "#{product.gender_type}"
              end
              if !product.product_type.nil?
                xml.type "#{Product::COMMON_TYPES.merge(Product::ADULT_TYPES).keys[product.product_type.to_i]}".downcase
              end
              xml.sizes {
                if !product.size.nil?
                  if product.size && Product::SIZES.keys[product.size].present?
                    product.human_available_sizes.each do |ps|
                      xml.size "#{ps[0]}"
                    end
                  end
                end
                }
              }

          elsif product.industry == "Cosmetic"
            xml.cosmetic {
              if !product.gender_type.nil?
                xml.gender "#{product.gender_type}"
              end
              xml.hypoallergenic "#{product.hypoallergenic}"
              xml.part_types {
                if product.part_types
                  product.human_available_part_types.each do |part_type|
                    xml.part_type "#{part_type}".downcase
                  end
                end
              }

              xml.skin_types {
                if product.skin_types
                  product.human_available_skin_types.each do |skin_type|
                    xml.skin_type "#{skin_type}".downcase
                  end
                end
              }

              xml.conditions {
                if product.conditions
                  product.human_available_conditions.each do |condition|
                    xml.condition "#{condition}"
                  end
                end
              }

              xml.volumes {
                product.volumes.each do |v|
                  xml.volume {
                    xml.value "#{v.value}"
                    xml.price  "#{v.value_price}"
                  }
                end
              }
              if !product.periodic.nil?
                xml.periodic "#{product.periodic}"
              end
            }

          elsif product.industry == "Child"
            xml.child {
              if !product.gender_type.nil?
                xml.gender "#{product.gender_type}"
              end
              if product.product_type.nil?
                xml.type "#{Product::COMMON_TYPES.merge(Product::ADULT_TYPES).keys[product.product_type.to_i]}".downcase
              end
              if Product::AGES.values[product.child_ages] == 0
                xml.age {
                  xml.min product.mac_child_ages.first
                  xml.max product.mac_child_ages.last
                }
              else
                if product.size && Product::SIZES.keys[product.size].present?
                  product.human_available_sizes.each do |ps|
                    xml.size "#{ps[0]}"
                  end
                end
              end

              if !product.periodic.nil?
                xml.periodic "#{product.periodic}"
              end
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
