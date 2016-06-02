module RecommendationsHelper
  RECOMMENDER_TYPES = ['interesting', 'also_bought', 'similar', 'popular', 'see_also', 'recently_viewed', 'buying_now']

  def recommended_type_by
    RECOMMENDER_TYPES.each do |recommender_type|
      recommender_type
    end
  end
end
