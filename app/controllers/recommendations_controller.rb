class RecommendationsController < ApplicationController
  def rees46_recommender
    fail(ArgumentError, 'recommended_by name is not provided') if params[:recommended_by].blank?

    @products = Product.where(id: params[:ids])
    @recommended_by = params[:recommended_by]
    @recommended_title = params[:recommended_title]
  end
end
