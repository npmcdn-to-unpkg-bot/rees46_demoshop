xml.instruct!
xml.shop do
  xml.name {
    xml.name 'Rees46 Demo'
  }
  xml.company {
    xml.company 'REES46'
  }
  xml.url {
    xml.url 'localhost:3000'
  }
  xml.currencies {
    xml.currency_id {

    }
  }

  xml.categories do
    @categories.each do |category|
      xml.category("#{category.name}","id"=>"#{category.id}")
    end
  end
end
