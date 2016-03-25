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
          xml.picture "#{product_url(product.image)}"
          xml.vendor "#{product.brand.name}"
          xml.name "#{product.title}"
          xml.description "#{product.description}"
        }
      end

      @products.where(stock: 0).each do |product|
        xml.offer("id" => "#{product.id}", "available" => "#{product.is_available? == 1}") {
          xml.url "#{product_url(product)}"
          xml.price "#{product.price}"
          xml.currencyId "RUB"
          xml.picture "#{product_url(product.image)}"
          xml.vendor "#{product.brand.name}"
          xml.name "#{product.title}"
          xml.description "#{product.description}"
        }
      end
    end
  end
end
