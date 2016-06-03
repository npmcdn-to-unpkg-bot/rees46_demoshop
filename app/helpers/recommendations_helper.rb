module RecommendationsHelper
  def get_recommended_case(recommended_case)
    @recommended_by = recommended_case
    case @recommended_by
      when 'also_bought'
        content_tag(:h2, 'С этим товаром покупают', class: ["text-center"])
      when 'interesting'
        content_tag(:h2, 'Возможно, вам это понравится', class: ["text-center"])
      when 'similar'
        content_tag(:h2, 'Похожие товары', class: ["text-center"])
      when 'popular'
        content_tag(:h2, 'Популярные товары', class: ["text-center","recommender-block-title"])
      when 'recently_viewed'
        content_tag(:h2, 'Вы недавно смотрели', class: ["text-center","recommender-block-title"])
      when 'see_also'
        content_tag(:h2, 'Посмотрите также', class: ["text-center","recommender-block-title"])
    end
  end
end
