xml.instruct!
xml.declare! :DOCTYPE, :yml_catalog, :SYSTEM, "shops.dtd"
xml.yml_catalog("date"=>"#{Time.now.strftime("%d/%m/%Y %H:%M")}") do
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
        xml.offer("id" => "#{product.id}", "available" => "#{product.available? == 1}") {
          xml.url "#{product_url(product)}"
          xml.price "#{product.price}"
          xml.currencyId "RUB"
          xml.categoryId  "#{product.category_id}"
          xml.picture "#{image_url(product.image)}"
          xml.vendor "#{product.brand.name}"
          xml.name "#{product.title}"
          if !product.description.empty?
            xml.description "#{ActionView::Base.full_sanitizer.sanitize(product.description)}"
          end
          if product.industry == "fashion"
            xml.fashion {
              if !product.gender_type.nil?
                xml.gender "#{product.gender_type}"
              end
              if !product.product_type.nil?
                xml.type "#{Product::TYPES.keys[product.product_type.to_i]}".downcase
              end
              if !product.size.nil?
                xml.sizes {
                  if product.size == 2 && Product::SIZES.keys[2].present?
                    product.human_available_british_sizes.each do |ps|
                      xml.size "#{ps}"
                    end
                  elsif product.size == 1 && Product::SIZES.keys[1].present?
                    product.human_available_euro_sizes.each do |ps|
                      xml.size "#{ps}"
                    end

                  elsif product.size && Product::SIZES.keys[product.size].present?
                    product.human_available_sizes.each do |ps|
                      xml.size "#{ps[0]}"
                    end
                  end
                }
              end
              }

          elsif product.industry == "cosmetic"
            xml.cosmetic {
              if !product.gender_type.nil?
                xml.gender "#{product.gender_type}"
              end
              xml.hypoallergenic "#{product.hypoallergenic}"

              if !product.part_types.nil?
                xml.part_types {
                  if product.part_types
                    product.human_available_part_types.each do |part_type|
                      xml.part_type "#{part_type}".downcase
                    end
                  end
                }
              end

              if !product.skin_types.nil?
                xml.skin_types {
                  if product.skin_types
                    product.human_available_skin_types.each do |skin_type|
                      xml.skin_type "#{skin_type}".downcase
                    end
                  end
                }
              end

              if product.conditions.nil?
                xml.conditions {
                  if product.conditions
                    product.human_available_conditions.each do |condition|
                      xml.condition "#{condition}"
                    end
                  end
                }
              end

              if product.volumes.nil?
                xml.volumes {
                  product.volumes.each do |v|
                    xml.volume {
                      xml.value "#{v.value}"
                      xml.price  "#{v.value_price}"
                    }
                  end
                }
              end

              if !product.periodic.nil?
                xml.periodic "#{product.periodic}"
              end

            }

          elsif product.industry == "child"

            if !product.gender_type.nil? || !product.child_ages_prefixed.first.nil? || !product.child_ages_prefixed.last.nil?
              xml.child {
                if !product.gender_type.nil?
                  xml.gender "#{product.gender_type}"
                end

                if Product::AGES.values[product.child_ages] == 0
                  xml.age {
                    xml.min product.child_ages_prefixed.first
                    xml.max product.child_ages_prefixed.last
                  }
                end
              }
            end
          end

          if !product.product_type.nil? || !product.size.nil? || !product.periodic.nil?
            xml.fashion {
              if !product.product_type.nil?
                xml.type "#{Product::TYPES.keys[product.product_type.to_i]}".downcase
              end

              if !product.size.nil?
                if product.size == 2 && Product::SIZES.keys[2].present?
                  product.human_available_british_sizes.each do |ps|
                    xml.size "#{ps}"
                  end
                elsif product.size == 1 && Product::SIZES.keys[1].present?
                  product.human_available_euro_sizes.each do |ps|
                    xml.size "#{ps}"
                  end

                elsif product.size && Product::SIZES.keys[product.size].present?
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

          if !product.part_types.empty? || !product.skin_types.empty? || !product.conditions.empty? || !product.volumes.empty? || !product.periodic.nil? || !product.hypoallergenic.nil?
            xml.cosmetic {

              if !product.hypoallergenic.nil?
                xml.hypoallergenic "#{product.hypoallergenic}"
              end

              if !product.part_types.empty?
                xml.part_types {
                  if product.part_types
                    product.human_available_part_types.each do |part_type|
                      xml.part_type "#{part_type}".downcase
                    end
                  end
                }
              end

              if !product.skin_types.empty?
                xml.skin_types {
                  if product.skin_types
                    product.human_available_skin_types.each do |skin_type|
                      xml.skin_type "#{skin_type}".downcase
                    end
                  end
                }
              end

              if !product.conditions.empty?
                xml.conditions {
                  if product.conditions
                    product.human_available_conditions.each do |condition|
                      xml.condition "#{condition}"
                    end
                  end
                }
              end

              if !product.volumes.empty?
                xml.volumes {
                  product.volumes.each do |v|
                    xml.volume {
                      xml.value "#{v.value}"
                      xml.price  "#{v.value_price}"
                    }
                  end
                }
              end

              if !product.periodic.nil?
                xml.periodic "#{product.periodic}"
              end
            }
          end

        }
      end

      @products.where(stock: 0).each do |product|
        xml.offer("id" => "#{product.id}", "available" => "#{product.available? == 1}") {
          xml.url "#{product_url(product)}"
          xml.price "#{product.price}"
          xml.currencyId "RUB"
          xml.categoryId  "#{product.category_id}"
          xml.picture "#{image_url(product.image)}"
          xml.vendor "#{product.brand.name}"
          xml.name "#{product.title}"
          if !product.description.empty?
            xml.description "#{ActionView::Base.full_sanitizer.sanitize(product.description)}"
          end
          if product.industry == "fashion"
            xml.fashion {
              if !product.gender_type.nil?
                xml.gender "#{product.gender_type}"
              end
              if !product.product_type.nil?
                xml.type "#{Product::TYPES.keys[product.product_type.to_i]}".downcase
              end
              if !product.size.nil?
                xml.sizes {
                  if product.size == 2 && Product::SIZES.keys[2].present?
                    product.human_available_british_sizes.each do |ps|
                      xml.size "#{ps}"
                    end
                  elsif product.size == 1 && Product::SIZES.keys[1].present?
                    product.human_available_euro_sizes.each do |ps|
                      xml.size "#{ps}"
                    end

                  elsif product.size && Product::SIZES.keys[product.size].present?
                    product.human_available_sizes.each do |ps|
                      xml.size "#{ps[0]}"
                    end
                  end
                }
              end
              }

          elsif product.industry == "cosmetic"
            xml.cosmetic {
              if !product.gender_type.nil?
                xml.gender "#{product.gender_type}"
              end

              if !product.hypoallergenic.nil?
                xml.hypoallergenic "#{product.hypoallergenic}"
              end

              if !product.part_types.nil?
                xml.part_types {
                  if product.part_types
                    product.human_available_part_types.each do |part_type|
                      xml.part_type "#{part_type}".downcase
                    end
                  end
                }
              end

              if !product.skin_types.nil?
                xml.skin_types {
                  if product.skin_types
                    product.human_available_skin_types.each do |skin_type|
                      xml.skin_type "#{skin_type}".downcase
                    end
                  end
                }
              end

              if product.conditions.nil?
                xml.conditions {
                  if product.conditions
                    product.human_available_conditions.each do |condition|
                      xml.condition "#{condition}"
                    end
                  end
                }
              end

              if product.volumes.nil?
                xml.volumes {
                  product.volumes.each do |v|
                    xml.volume {
                      xml.value "#{v.value}"
                      xml.price  "#{v.value_price}"
                    }
                  end
                }
              end

              if !product.periodic.nil?
                xml.periodic "#{product.periodic}"
              end

            }

          elsif product.industry == "child"

            if !product.gender_type.nil? || !product.child_ages_prefixed.first.nil? || !product.child_ages_prefixed.last.nil?
              xml.child {
                if !product.gender_type.nil?
                  xml.gender "#{product.gender_type}"
                end

                if Product::AGES.values[product.child_ages] == 0
                  xml.age {
                    xml.min product.child_ages_prefixed.first
                    xml.max product.child_ages_prefixed.last
                  }
                end
              }
            end
          end

          if !product.product_type.nil? || !product.size.nil? || !product.periodic.nil?
            xml.fashion {
              if !product.product_type.nil?
                xml.type "#{Product::TYPES.keys[product.product_type.to_i]}".downcase
              end

              if !product.size.nil?
                if product.size == 2 && Product::SIZES.keys[2].present?
                  product.human_available_british_sizes.each do |ps|
                    xml.size "#{ps}"
                  end
                elsif product.size == 1 && Product::SIZES.keys[1].present?
                  product.human_available_euro_sizes.each do |ps|
                    xml.size "#{ps}"
                  end

                elsif product.size && Product::SIZES.keys[product.size].present?
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

          if !product.part_types.empty? || !product.skin_types.empty? || !product.conditions.empty? || !product.volumes.empty? || !product.periodic.nil? || !product.hypoallergenic.nil?
            xml.cosmetic {

              if !product.hypoallergenic.nil?
                xml.hypoallergenic "#{product.hypoallergenic}"
              end

              if !product.part_types.empty?
                xml.part_types {
                  if product.part_types
                    product.human_available_part_types.each do |part_type|
                      xml.part_type "#{part_type}".downcase
                    end
                  end
                }
              end

              if !product.skin_types.empty?
                xml.skin_types {
                  if product.skin_types
                    product.human_available_skin_types.each do |skin_type|
                      xml.skin_type "#{skin_type}".downcase
                    end
                  end
                }
              end

              if !product.conditions.empty?
                xml.conditions {
                  if product.conditions
                    product.human_available_conditions.each do |condition|
                      xml.condition "#{condition}"
                    end
                  end
                }
              end

              if !product.volumes.empty?
                xml.volumes {
                  product.volumes.each do |v|
                    xml.volume {
                      xml.value "#{v.value}"
                      xml.price  "#{v.value_price}"
                    }
                  end
                }
              end

              if !product.periodic.nil?
                xml.periodic "#{product.periodic}"
              end
            }
          end
        }
      end
    end
  end
end
