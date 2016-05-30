class RecommendationsController < ApplicationController
  def rees46_recommender
    raise(ArgumentError, 'recommended_by name is not provided') if params[:recommended_by].blank?

    @products = Product.where(id: params[:ids])
    @recommended_by = params[:recommended_by]
  end
end
